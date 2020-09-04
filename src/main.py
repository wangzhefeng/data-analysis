#!/usr/bin/env python 
# -*- coding: utf-8 -*-




L = list(range(1213))
start = len(L) - (8 * 60 + 30)
end = len(L) - 30

print(L[start:end])
print(len(L[start:end]))