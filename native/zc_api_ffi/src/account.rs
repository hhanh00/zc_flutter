use log::{debug, error};
use std::panic::catch_unwind;
use std::thread::LocalKey;
use tokio::runtime::Runtime;
use zcash_coldwallet::constants::LIGHTNODE_URL;
use zcash_coldwallet::sign::{sign_tx, sign_tx_with_bytes};
use zcash_coldwallet::transact::{prepare_tx, submit};
use zcash_coldwallet::{chain, Opt, ZECUnit};

pub fn sync(database_path: &str, max_blocks: u32) -> u64 {
    let mut r = Runtime::new().unwrap();
    match r.block_on(chain::sync(database_path, LIGHTNODE_URL, max_blocks)) {
        Err(e) => {
            error!("{}", e);
            0u64
        }
        Ok(k) => k,
    }
}

pub fn get_balance(directory_path: &str) -> u64 {
    match zcash_coldwallet::account::get_balance(directory_path, ZECUnit::Zat) {
        Err(_) => 0u64,
        Ok(v) => v,
    }
}

pub async fn send_async(
    directory_path: &str,
    to_addr: &str,
    amount: u64,
    spending_key: &str,
    spending_params: &[u8],
    output_params: &[u8],
) -> anyhow::Result<()> {
    let opt = Opt::default();
    let tx = prepare_tx(directory_path, to_addr, amount.to_string(), &ZECUnit::Zat)?;
    let tx = sign_tx_with_bytes(spending_key, &tx, &opt, spending_params, output_params)?;
    submit(tx, &opt.lightnode_url).await?;

    Ok(())
}

pub fn send(
    directory_path: &str,
    address: &str,
    amount: u64,
    spending_key: &str,
    spending_params: &[u8],
    output_params: &[u8],
) {
    let mut r = Runtime::new().unwrap();
    match r.block_on(send_async(
        directory_path,
        address,
        amount,
        spending_key,
        spending_params,
        output_params,
    )) {
        Err(e) => {
            error!("{}", e);
        }
        Ok(_) => {
            debug!("Transaction sent");
        }
    }
}
