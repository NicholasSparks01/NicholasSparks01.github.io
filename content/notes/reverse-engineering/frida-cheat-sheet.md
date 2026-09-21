---
title: "Frida Cheat Sheet"
weight: 10
---

Common Frida snippets for dynamic instrumentation.

## Attach and spawn

```bash
frida -U -n TargetApp -l hook.js      # attach to a running process by name
frida -U -f com.example.app -l hook.js # spawn, then instrument
frida-ps -Uai                          # list installed apps on a USB device
```

## Hook a native export

```js {filename="hook.js"}
const addr = Module.getGlobalExportByName("open");
Interceptor.attach(addr, {
  onEnter(args) {
    console.log("open(" + args[0].readUtf8String() + ")");
  },
  onLeave(retval) {
    console.log("  -> fd " + retval.toInt32());
  }
});
```

## Dump a memory region

```js
console.log(hexdump(ptr("0x12345678"), { length: 64 }));
```
