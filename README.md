# GDSercomm
GDNative Serial port communication

**Dependencies:**

- `libsercomm`: https://github.com/ingeniamc/sercomm
- `godot-headers`: https://github.com/GodotNativeTools/godot_headers

**Contents:**

Available functions:

- `open(port,baudrate,timeout,bytesz,parity, stop_byte)`

- `(string) read()`

- `(int) read(true)`	(Read raw value)

- `write(string)`

- `get_available()`

- `flush(queue)`

- `list_ports()`

- `close()`

You can get extra info of a function using `get_documentation(function_name)` if you have a godot editor with *nativescript1.1* support.

**Building (Mac OS only):**

Run:

```
make
```

The result library will be built to `bin/libGDSercomm.dylib`