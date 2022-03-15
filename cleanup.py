#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Licensed under the MIT License (Expat) @ https://www.tldrlegal.com/l/mit

"""
A one-function module to clean up files in folders.

Args:
    -q, --quiet     Suppresses output to stdout.

Author:
    Jonas Gröger <jonas.groeger@gmail.com> | Thanks Jonas :)
    
Edits: 10 March - Added .fls/.synctex.gz/.fdb_latexmk
"""



__author__ = 'Jonas Gröger <jonas.groeger@gmail.com>'

import argparse
import os


def delete_recursive(path, extensions, quiet=False):
    """
    Recusively (in subdirectories also) removes files in path whose extension matches one of 
    those in the parameter extensions.

    Args:
        path: Where to recusively start removing files.
        extensions: A list of file extensions.
        quiet: If the list of deleted files is output to stdout.

    Returns:
        Nothing.

    You might use this function like this:

    >>> delete_recursive('/home/jonas/latex/project/', ['.aux', '.toc', '.log'])
    """
    nothing_removed = True

    for root, dirs, files in os.walk(path):
        files = [f for f in files if not f[0] == '.']  # Skip files starting with '.'
        dirs[:] = [d for d in dirs if not d[0] == '.']  # Skip directories starting with '.'

        for current_file in files:
            for ex in extensions:
                if current_file.endswith(ex):
                    if not quiet: print('Removing {}'.format(os.path.join(os.path.relpath(root), current_file)))
                    os.remove(os.path.join(root, current_file))
                    nothing_removed = False

    if nothing_removed:
        if not quiet: print('No files removed.')


def setup_argparse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-q', '--quiet', action='store_true')
    return parser.parse_args()


if __name__ == '__main__':
    args = setup_argparse()
    unwanted_files = [
        '.aux',
        '.bcf',
        '.blg',
        '.brf',
        '.idx',
        '.ilg',
        '.fdb_latexmk',        
        '.fls',
        '.lof',
        '.log',
        '.lol',
        '.lot',
        '.lpr',
        '.nlo',
        '.nls',
        '.out',
        '.synctex',
        '.synctex.gz',
        '.toc',
    ]
    path = os.path.dirname(os.path.realpath(__file__))
    delete_recursive(path, unwanted_files, quiet=args.quiet)
