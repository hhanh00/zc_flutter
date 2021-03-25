use android_logger::Config;
use log::{debug, error, Level};
use tokio::runtime::Runtime;
use zcash_coldwallet::account::has_account;
use zcash_coldwallet::chain::init_db;
use zcash_coldwallet::constants::LIGHTNODE_URL;
use zcash_coldwallet::keys::{generate_key, Keys};

async fn initialize_async(directory_path: &str) -> anyhow::Result<bool> {
    init_db(directory_path)?;
    has_account(directory_path)
}

async fn init_account_async(directory_path: &str) -> anyhow::Result<Keys> {
    let key_package = generate_key()?;
    zcash_coldwallet::account::init_account(
        directory_path,
        LIGHTNODE_URL,
        &key_package.viewing_key,
        u64::MAX,
    )
    .await?;
    Ok(key_package)
}

pub fn initialize(database_path: &str) -> bool {
    android_logger::init_once(Config::default().with_min_level(Level::Debug));
    let mut r = Runtime::new().unwrap();
    match r.block_on(initialize_async(database_path)) {
        Err(e) => {
            error!("{}", e);
            false
        }
        Ok(v) => v,
    }
}

pub fn init_account(database_path: &str) -> Keys {
    log::debug!("init_account");
    let mut r = Runtime::new().unwrap();
    match r.block_on(init_account_async(database_path)) {
        Err(e) => {
            log::debug!("error {}", e);
            Keys {
                phrase: "".to_string(),
                derivation_path: "".to_string(),
                spending_key: "".to_string(),
                viewing_key: "".to_string(),
                address: format!("{}", e),
            }
        }
        Ok(v) => v,
    }
}
