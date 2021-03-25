use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::slice;

#[repr(C)]
pub struct CKeys {
    phrase: *mut c_char,
    derivation_path: *mut c_char,
    spending_key: *mut c_char,
    viewing_key: *mut c_char,
    address: *mut c_char,
}

#[no_mangle]
pub extern "C" fn initialize(database_path: *mut c_char) -> bool {
    let database_path = unsafe { CStr::from_ptr(database_path) };

    crate::init::initialize(&database_path.to_string_lossy())
}

#[no_mangle]
pub extern "C" fn init_account(database_path: *mut c_char) -> CKeys {
    let database_path = unsafe { CStr::from_ptr(database_path) };

    let keys = crate::init::init_account(&database_path.to_string_lossy());
    let k = CKeys {
        phrase: CString::new(keys.phrase).unwrap().into_raw(),
        derivation_path: CString::new(keys.derivation_path).unwrap().into_raw(),
        spending_key: CString::new(keys.spending_key).unwrap().into_raw(),
        viewing_key: CString::new(keys.viewing_key).unwrap().into_raw(),
        address: CString::new(keys.address).unwrap().into_raw(),
    };
    k
}

#[no_mangle]
pub extern "C" fn sync(database_path: *mut c_char, max_blocks: u32) -> u64 {
    let database_path = unsafe { CStr::from_ptr(database_path) };
    crate::account::sync(&database_path.to_string_lossy(), max_blocks)
}

#[no_mangle]
pub extern "C" fn get_balance(database_path: *mut c_char) -> u64 {
    let database_path = unsafe { CStr::from_ptr(database_path) };
    crate::account::get_balance(&database_path.to_string_lossy())
}

#[no_mangle]
pub extern "C" fn send_tx(
    database_path: *mut c_char,
    address: *mut c_char,
    amount: u64,
    spending_key: *mut c_char,
    spend_params: *const c_char,
    len_spend_params: usize,
    output_params: *const c_char,
    len_output_params: usize,
) {
    let database_path = unsafe { CStr::from_ptr(database_path) };
    let address = unsafe { CStr::from_ptr(address) };
    let spending_key = unsafe { CStr::from_ptr(spending_key) };
    let spend_params =
        unsafe { slice::from_raw_parts(spend_params as *const u8, len_spend_params) };
    let output_params =
        unsafe { slice::from_raw_parts(output_params as *const u8, len_output_params) };

    crate::account::send(
        &database_path.to_string_lossy(),
        &address.to_string_lossy(),
        amount,
        &spending_key.to_string_lossy(),
        spend_params,
        output_params,
    );
}

#[no_mangle]
pub extern "C" fn check_address(address: *mut c_char) -> bool {
    let address = unsafe { CStr::from_ptr(address) };
    zcash_coldwallet::keys::check_address(&address.to_string_lossy())
}
