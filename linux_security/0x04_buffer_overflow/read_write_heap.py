#!/usr/bin/python3
"""
Read and write strings in the heap of a running process.

Usage: read_write_heap.py pid search_string replace_string

The script scans the heap memory of the process identified by `pid`,
searches for `search_string`, and replaces the first occurrence with
`replace_string`.

Both strings must be ASCII. The replacement string must not be longer than
the search string. If it is shorter, it is padded with null bytes so that
the original C string is cleanly terminated.
"""

import sys
import os


def read_maps(pid):
    """Return the heap [start, end] addresses for `pid` from /proc/pid/maps."""
    maps_path = "/proc/{}/maps".format(pid)
    with open(maps_path, "r") as maps_file:
        for line in maps_file:
            if "[heap]" in line:
                addr_range = line.split()[0]
                start, end = addr_range.split("-")
                return int(start, 16), int(end, 16)
    return None


def read_write_heap(pid, search_string, replace_string):
    """
    Find `search_string` in the heap of process `pid` and replace it with
    `replace_string`.

    Args:
        pid (int): PID of the target process.
        search_string (str): ASCII string to search for.
        replace_string (str): ASCII string to replace with.

    Returns:
        bool: True if a replacement was made, False otherwise.
    """
    heap = read_maps(pid)
    if heap is None:
        print("No heap found for process {}".format(pid))
        return False

    heap_start, heap_end = heap
    #print("Heap found at [{:x}-{:x}]".format(heap_start, heap_end))

    search_bytes = search_string.encode("ascii")
    replace_bytes = replace_string.encode("ascii")

    if len(replace_bytes) > len(search_bytes):
        #print("Replace string is longer than search string")
        return False

    # Pad with null bytes so the original C string remains cleanly terminated.
    replace_bytes = replace_bytes.ljust(len(search_bytes), b"\x00")

    mem_path = "/proc/{}/mem".format(pid)
    with open(mem_path, "rb+") as mem_file:
        mem_file.seek(heap_start)
        heap_data = mem_file.read(heap_end - heap_start)

        try:
            offset = heap_data.index(search_bytes)
        except ValueError:
            #print("'{}' not found in heap".format(search_string))
            return False

        #print("Found '{}' at offset {:x}".format(search_string, offset))

        mem_file.seek(heap_start + offset)
        mem_file.write(replace_bytes)
        #print("Replaced '{}' with '{}'".format(search_string, replace_string))
        return True


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Invalid pid: {}".format(sys.argv[1]))
        sys.exit(1)

    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    try:
        search_string.encode("ascii")
        replace_string.encode("ascii")
    except UnicodeEncodeError:
        print("Strings must be ASCII")
        sys.exit(1)

    if not os.path.isdir("/proc/{}".format(pid)):
        print("Process {} does not exist".format(pid))
        sys.exit(1)

    read_write_heap(pid, search_string, replace_string)
