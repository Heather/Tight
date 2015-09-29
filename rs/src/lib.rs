#[no_mangle]
pub extern fn rust_hello(v: i32) -> i32 {
    println!("Hello Rust World: {}", v);
    v + 1
}
