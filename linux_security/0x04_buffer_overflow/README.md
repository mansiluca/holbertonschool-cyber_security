# Read / Write Heap

A small Python3 script that finds an ASCII string inside the **heap** of a running Linux process and overwrites it in place.

## Usage

```bash
./read_write_heap.py pid search_string replace_string
```

- `pid` — PID of the running process.
- `search_string` — ASCII string to look for in the heap.
- `replace_string` — ASCII string to write in its place.

On usage error the script prints an error message on `stdout` and exits with status code `1`.

## Example

Terminal 1 — run a program that keeps a string in the heap:

```bash
./main
[0] Holberton (0x55e646e02a0)
[1] Holberton (0x55e646e02a0)
...
```

Terminal 2 — find the PID and patch the heap:

```bash
ps aux | grep ./main
sudo python3 ./read_write_heap.py 6515 Holberton "maroua"
```

Output:

```text
Heap found at [5f1786f50000-5f1786f71000]
Found 'Holberton' at offset 2a0
Replaced 'Holberton' with 'maroua'
```

The running process will now print `maroua` instead of `Holberton`.

## How it works

1. Reads `/proc/<pid>/maps` to find the `[heap]` memory region.
2. Reads the heap contents from `/proc/<pid>/mem`.
3. Searches for the first occurrence of `search_string`.
4. Seeks back to that address and writes `replace_string`.

The replacement string is required to be **no longer** than the search string, so it does not overflow into adjacent heap data.

## Requirements

- Linux (the script relies on `/proc/<pid>/maps` and `/proc/<pid>/mem`).
- Python 3.
- Root privileges are usually required to read and write another process's memory.

## Notes

- The script only looks inside the heap segment.
- It only replaces the first occurrence of the search string.
- Both strings must be valid ASCII.
