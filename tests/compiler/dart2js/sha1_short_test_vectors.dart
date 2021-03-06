// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of sha1_test;

// Standard test vectors from:
//   http://csrc.nist.gov/groups/STM/cavp/documents/shs/shabytetestvectors.zip

const sha1_short_inputs = const [
const [ ],
const [ 0x36 ],
const [ 0x19, 0x5a ],
const [ 0xdf, 0x4b, 0xd2 ],
const [ 0x54, 0x9e, 0x95, 0x9e ],
const [ 0xf7, 0xfb, 0x1b, 0xe2, 0x05 ],
const [ 0xc0, 0xe5, 0xab, 0xea, 0xea, 0x63 ],
const [ 0x63, 0xbf, 0xc1, 0xed, 0x7f, 0x78, 0xab ],
const [ 0x7e, 0x3d, 0x7b, 0x3e, 0xad, 0xa9, 0x88, 0x66 ],
const [ 0x9e, 0x61, 0xe5, 0x5d, 0x9e, 0xd3, 0x7b, 0x1c, 0x20 ],
const [ 0x97, 0x77, 0xcf, 0x90, 0xdd, 0x7c, 0x7e, 0x86, 0x35, 0x06 ],
const [ 0x4e, 0xb0, 0x8c, 0x9e, 0x68, 0x3c, 0x94, 0xbe, 0xa0, 0x0d, 0xfa ],
const [ 0x09, 0x38, 0xf2, 0xe2, 0xeb, 0xb6, 0x4f, 0x8a, 0xf8, 0xbb, 0xfc, 0x91 ],
const [ 0x74, 0xc9, 0x99, 0x6d, 0x14, 0xe8, 0x7d, 0x3e, 0x6c, 0xbe, 0xa7, 0x02, 0x9d ],
const [ 0x51, 0xdc, 0xa5, 0xc0, 0xf8, 0xe5, 0xd4, 0x95, 0x96, 0xf3, 0x2d, 0x3e, 0xb8, 0x74 ],
const [ 0x3a, 0x36, 0xea, 0x49, 0x68, 0x48, 0x20, 0xa2, 0xad, 0xc7, 0xfc, 0x41, 0x75, 0xba, 0x78 ],
const [ 0x35, 0x52, 0x69, 0x4c, 0xdf, 0x66, 0x3f, 0xd9, 0x4b, 0x22, 0x47, 0x47, 0xac, 0x40, 0x6a, 0xaf ],
const [ 0xf2, 0x16, 0xa1, 0xcb, 0xde, 0x24, 0x46, 0xb1, 0xed, 0xf4, 0x1e, 0x93, 0x48, 0x1d, 0x33, 0xe2, 0xed ],
const [ 0xa3, 0xcf, 0x71, 0x4b, 0xf1, 0x12, 0x64, 0x7e, 0x72, 0x7e, 0x8c, 0xfd, 0x46, 0x49, 0x9a, 0xcd, 0x35, 0xa6 ],
const [ 0x14, 0x8d, 0xe6, 0x40, 0xf3, 0xc1, 0x15, 0x91, 0xa6, 0xf8, 0xc5, 0xc4, 0x86, 0x32, 0xc5, 0xfb, 0x79, 0xd3, 0xb7 ],
const [ 0x63, 0xa3, 0xcc, 0x83, 0xfd, 0x1e, 0xc1, 0xb6, 0x68, 0x0e, 0x99, 0x74, 0xa0, 0x51, 0x4e, 0x1a, 0x9e, 0xce, 0xbb, 0x6a ],
const [ 0x87, 0x5a, 0x90, 0x90, 0x9a, 0x8a, 0xfc, 0x92, 0xfb, 0x70, 0x70, 0x04, 0x7e, 0x9d, 0x08, 0x1e, 0xc9, 0x2f, 0x3d, 0x08, 0xb8 ],
const [ 0x44, 0x4b, 0x25, 0xf9, 0xc9, 0x25, 0x9d, 0xc2, 0x17, 0x77, 0x2c, 0xc4, 0x47, 0x8c, 0x44, 0xb6, 0xfe, 0xff, 0x62, 0x35, 0x36, 0x73 ],
const [ 0x48, 0x73, 0x51, 0xc8, 0xa5, 0xf4, 0x40, 0xe4, 0xd0, 0x33, 0x86, 0x48, 0x3d, 0x5f, 0xe7, 0xbb, 0x66, 0x9d, 0x41, 0xad, 0xcb, 0xfd, 0xb7 ],
const [ 0x46, 0xb0, 0x61, 0xef, 0x13, 0x2b, 0x87, 0xf6, 0xd3, 0xb0, 0xee, 0x24, 0x62, 0xf6, 0x7d, 0x91, 0x09, 0x77, 0xda, 0x20, 0xae, 0xd1, 0x37, 0x05 ],
const [ 0x38, 0x42, 0xb6, 0x13, 0x7b, 0xb9, 0xd2, 0x7f, 0x3c, 0xa5, 0xba, 0xfe, 0x5b, 0xbb, 0x62, 0x85, 0x83, 0x44, 0xfe, 0x4b, 0xa5, 0xc4, 0x15, 0x89, 0xa5 ],
const [ 0x44, 0xd9, 0x1d, 0x3d, 0x46, 0x5a, 0x41, 0x11, 0x46, 0x2b, 0xa0, 0xc7, 0xec, 0x22, 0x3d, 0xa6, 0x73, 0x5f, 0x4f, 0x52, 0x00, 0x45, 0x3c, 0xf1, 0x32, 0xc3 ],
const [ 0xcc, 0xe7, 0x3f, 0x2e, 0xab, 0xcb, 0x52, 0xf7, 0x85, 0xd5, 0xa6, 0xdf, 0x63, 0xc0, 0xa1, 0x05, 0xf3, 0x4a, 0x91, 0xca, 0x23, 0x7f, 0xe5, 0x34, 0xee, 0x39, 0x9d ],
const [ 0x66, 0x4e, 0x6e, 0x79, 0x46, 0x83, 0x92, 0x03, 0x03, 0x7a, 0x65, 0xa1, 0x21, 0x74, 0xb2, 0x44, 0xde, 0x8c, 0xbc, 0x6e, 0xc3, 0xf5, 0x78, 0x96, 0x7a, 0x84, 0xf9, 0xce ],
const [ 0x95, 0x97, 0xf7, 0x14, 0xb2, 0xe4, 0x5e, 0x33, 0x99, 0xa7, 0xf0, 0x2a, 0xec, 0x44, 0x92, 0x1b, 0xd7, 0x8b, 0xe0, 0xfe, 0xfe, 0xe0, 0xc5, 0xe9, 0xb4, 0x99, 0x48, 0x8f, 0x6e ],
const [ 0x75, 0xc5, 0xad, 0x1f, 0x3c, 0xbd, 0x22, 0xe8, 0xa9, 0x5f, 0xc3, 0xb0, 0x89, 0x52, 0x67, 0x88, 0xfb, 0x4e, 0xbc, 0xee, 0xd3, 0xe7, 0xd4, 0x44, 0x3d, 0xa6, 0xe0, 0x81, 0xa3, 0x5e ],
const [ 0xdd, 0x24, 0x5b, 0xff, 0xe6, 0xa6, 0x38, 0x80, 0x66, 0x67, 0x76, 0x83, 0x60, 0xa9, 0x5d, 0x05, 0x74, 0xe1, 0xa0, 0xbd, 0x0d, 0x18, 0x32, 0x9f, 0xdb, 0x91, 0x5c, 0xa4, 0x84, 0xac, 0x0d ],
const [ 0x03, 0x21, 0x79, 0x4b, 0x73, 0x94, 0x18, 0xc2, 0x4e, 0x7c, 0x2e, 0x56, 0x52, 0x74, 0x79, 0x1c, 0x4b, 0xe7, 0x49, 0x75, 0x2a, 0xd2, 0x34, 0xed, 0x56, 0xcb, 0x0a, 0x63, 0x47, 0x43, 0x0c, 0x6b ],
const [ 0x4c, 0x3d, 0xcf, 0x95, 0xc2, 0xf0, 0xb5, 0x25, 0x8c, 0x65, 0x1f, 0xcd, 0x1d, 0x51, 0xbd, 0x10, 0x42, 0x5d, 0x62, 0x03, 0x06, 0x7d, 0x07, 0x48, 0xd3, 0x7d, 0x13, 0x40, 0xd9, 0xdd, 0xda, 0x7d, 0xb3 ],
const [ 0xb8, 0xd1, 0x25, 0x82, 0xd2, 0x5b, 0x45, 0x29, 0x0a, 0x6e, 0x1b, 0xb9, 0x5d, 0xa4, 0x29, 0xbe, 0xfc, 0xfd, 0xbf, 0x5b, 0x4d, 0xd4, 0x1c, 0xdf, 0x33, 0x11, 0xd6, 0x98, 0x8f, 0xa1, 0x7c, 0xec, 0x07, 0x23 ],
const [ 0x6f, 0xda, 0x97, 0x52, 0x7a, 0x66, 0x25, 0x52, 0xbe, 0x15, 0xef, 0xae, 0xba, 0x32, 0xa3, 0xae, 0xa4, 0xed, 0x44, 0x9a, 0xbb, 0x5c, 0x1e, 0xd8, 0xd9, 0xbf, 0xff, 0x54, 0x47, 0x08, 0xa4, 0x25, 0xd6, 0x9b, 0x72 ],
const [ 0x09, 0xfa, 0x27, 0x92, 0xac, 0xbb, 0x24, 0x17, 0xe8, 0xed, 0x26, 0x90, 0x41, 0xcc, 0x03, 0xc7, 0x70, 0x06, 0x46, 0x6e, 0x6e, 0x7a, 0xe0, 0x02, 0xcf, 0x3f, 0x1a, 0xf5, 0x51, 0xe8, 0xce, 0x0b, 0xb5, 0x06, 0xd7, 0x05 ],
const [ 0x5e, 0xfa, 0x29, 0x87, 0xda, 0x0b, 0xaf, 0x0a, 0x54, 0xd8, 0xd7, 0x28, 0x79, 0x2b, 0xcf, 0xa7, 0x07, 0xa1, 0x57, 0x98, 0xdc, 0x66, 0x74, 0x37, 0x54, 0x40, 0x69, 0x14, 0xd1, 0xcf, 0xe3, 0x70, 0x9b, 0x13, 0x74, 0xea, 0xeb ],
const [ 0x28, 0x36, 0xde, 0x99, 0xc0, 0xf6, 0x41, 0xcd, 0x55, 0xe8, 0x9f, 0x5a, 0xf7, 0x66, 0x38, 0x94, 0x7b, 0x82, 0x27, 0x37, 0x7e, 0xf8, 0x8b, 0xfb, 0xa6, 0x62, 0xe5, 0x68, 0x2b, 0xab, 0xc1, 0xec, 0x96, 0xc6, 0x99, 0x2b, 0xc9, 0xa0 ],
const [ 0x42, 0x14, 0x3a, 0x2b, 0x9e, 0x1d, 0x0b, 0x35, 0x4d, 0xf3, 0x26, 0x4d, 0x08, 0xf7, 0xb6, 0x02, 0xf5, 0x4a, 0xad, 0x92, 0x2a, 0x3d, 0x63, 0x00, 0x6d, 0x09, 0x7f, 0x68, 0x3d, 0xc1, 0x1b, 0x90, 0x17, 0x84, 0x23, 0xbf, 0xf2, 0xf7, 0xfe ],
const [ 0xeb, 0x60, 0xc2, 0x8a, 0xd8, 0xae, 0xda, 0x80, 0x7d, 0x69, 0xeb, 0xc8, 0x75, 0x52, 0x02, 0x4a, 0xd8, 0xac, 0xa6, 0x82, 0x04, 0xf1, 0xbc, 0xd2, 0x9d, 0xc5, 0xa8, 0x1d, 0xd2, 0x28, 0xb5, 0x91, 0xe2, 0xef, 0xb7, 0xc4, 0xdf, 0x75, 0xef, 0x03 ],
const [ 0x7d, 0xe4, 0xba, 0x85, 0xec, 0x54, 0x74, 0x7c, 0xdc, 0x42, 0xb1, 0xf2, 0x35, 0x46, 0xb7, 0xe4, 0x90, 0xe3, 0x12, 0x80, 0xf0, 0x66, 0xe5, 0x2f, 0xac, 0x11, 0x7f, 0xd3, 0xb0, 0x79, 0x2e, 0x4d, 0xe6, 0x2d, 0x58, 0x43, 0xee, 0x98, 0xc7, 0x20, 0x15 ],
const [ 0xe7, 0x06, 0x53, 0x63, 0x7b, 0xc5, 0xe3, 0x88, 0xcc, 0xd8, 0xdc, 0x44, 0xe5, 0xea, 0xce, 0x36, 0xf7, 0x39, 0x8f, 0x2b, 0xac, 0x99, 0x30, 0x42, 0xb9, 0xbc, 0x2f, 0x4f, 0xb3, 0xb0, 0xee, 0x7e, 0x23, 0xa9, 0x64, 0x39, 0xdc, 0x01, 0x13, 0x4b, 0x8c, 0x7d ],
const [ 0xdd, 0x37, 0xbc, 0x9f, 0x0b, 0x3a, 0x47, 0x88, 0xf9, 0xb5, 0x49, 0x66, 0xf2, 0x52, 0x17, 0x4c, 0x8c, 0xe4, 0x87, 0xcb, 0xe5, 0x9c, 0x53, 0xc2, 0x2b, 0x81, 0xbf, 0x77, 0x62, 0x1a, 0x7c, 0xe7, 0x61, 0x6d, 0xcb, 0x5b, 0x1e, 0x2e, 0xe6, 0x3c, 0x2c, 0x30, 0x9b ],
const [ 0x5f, 0x48, 0x5c, 0x63, 0x7a, 0xe3, 0x0b, 0x1e, 0x30, 0x49, 0x7f, 0x0f, 0xb7, 0xec, 0x36, 0x4e, 0x13, 0xc9, 0x06, 0xe2, 0x81, 0x3d, 0xaa, 0x34, 0x16, 0x1b, 0x7a, 0xc4, 0xa4, 0xfd, 0x7a, 0x1b, 0xdd, 0xd7, 0x96, 0x01, 0xbb, 0xd2, 0x2c, 0xef, 0x1f, 0x57, 0xcb, 0xc7 ],
const [ 0xf6, 0xc2, 0x37, 0xfb, 0x3c, 0xfe, 0x95, 0xec, 0x84, 0x14, 0xcc, 0x16, 0xd2, 0x03, 0xb4, 0x87, 0x4e, 0x64, 0x4c, 0xc9, 0xa5, 0x43, 0x46, 0x5c, 0xad, 0x2d, 0xc5, 0x63, 0x48, 0x8a, 0x65, 0x9e, 0x8a, 0x2e, 0x7c, 0x98, 0x1e, 0x2a, 0x9f, 0x22, 0xe5, 0xe8, 0x68, 0xff, 0xe1 ],
const [ 0xda, 0x7a, 0xb3, 0x29, 0x15, 0x53, 0xc6, 0x59, 0x87, 0x3c, 0x95, 0x91, 0x37, 0x68, 0x95, 0x3c, 0x6e, 0x52, 0x6d, 0x3a, 0x26, 0x59, 0x08, 0x98, 0xc0, 0xad, 0xe8, 0x9f, 0xf5, 0x6f, 0xbd, 0x11, 0x0f, 0x14, 0x36, 0xaf, 0x59, 0x0b, 0x17, 0xfe, 0xd4, 0x9f, 0x8c, 0x4b, 0x2b, 0x1e ],
const [ 0x8c, 0xfa, 0x5f, 0xd5, 0x6e, 0xe2, 0x39, 0xca, 0x47, 0x73, 0x75, 0x91, 0xcb, 0xa1, 0x03, 0xe4, 0x1a, 0x18, 0xac, 0xf8, 0xe8, 0xd2, 0x57, 0xb0, 0xdb, 0xe8, 0x85, 0x11, 0x34, 0xa8, 0x1f, 0xf6, 0xb2, 0xe9, 0x71, 0x04, 0xb3, 0x9b, 0x76, 0xe1, 0x9d, 0xa2, 0x56, 0xa1, 0x7c, 0xe5, 0x2d ],
const [ 0x57, 0xe8, 0x96, 0x59, 0xd8, 0x78, 0xf3, 0x60, 0xaf, 0x6d, 0xe4, 0x5a, 0x9a, 0x5e, 0x37, 0x2e, 0xf4, 0x0c, 0x38, 0x49, 0x88, 0xe8, 0x26, 0x40, 0xa3, 0xd5, 0xe4, 0xb7, 0x6d, 0x2e, 0xf1, 0x81, 0x78, 0x0b, 0x9a, 0x09, 0x9a, 0xc0, 0x6e, 0xf0, 0xf8, 0xa7, 0xf3, 0xf7, 0x64, 0x20, 0x97, 0x20 ],
const [ 0xb9, 0x1e, 0x64, 0x23, 0x5d, 0xbd, 0x23, 0x4e, 0xea, 0x2a, 0xe1, 0x4a, 0x92, 0xa1, 0x73, 0xeb, 0xe8, 0x35, 0x34, 0x72, 0x39, 0xcf, 0xf8, 0xb0, 0x20, 0x74, 0x41, 0x6f, 0x55, 0xc6, 0xb6, 0x0d, 0xc6, 0xce, 0xd0, 0x6a, 0xe9, 0xf8, 0xd7, 0x05, 0x50, 0x5f, 0x0d, 0x61, 0x7e, 0x4b, 0x29, 0xae, 0xf9 ],
const [ 0xe4, 0x2a, 0x67, 0x36, 0x2a, 0x58, 0x1e, 0x8c, 0xf3, 0xd8, 0x47, 0x50, 0x22, 0x15, 0x75, 0x5d, 0x7a, 0xd4, 0x25, 0xca, 0x03, 0x0c, 0x43, 0x60, 0xb0, 0xf7, 0xef, 0x51, 0x3e, 0x69, 0x80, 0x26, 0x5f, 0x61, 0xc9, 0xfa, 0x18, 0xdd, 0x9c, 0xe6, 0x68, 0xf3, 0x8d, 0xbc, 0x2a, 0x1e, 0xf8, 0xf8, 0x3c, 0xd6 ],
const [ 0x63, 0x4d, 0xb9, 0x2c, 0x22, 0x01, 0x0e, 0x1c, 0xbf, 0x1e, 0x16, 0x23, 0x92, 0x31, 0x80, 0x40, 0x6c, 0x51, 0x52, 0x72, 0x20, 0x9a, 0x8a, 0xcc, 0x42, 0xde, 0x05, 0xcc, 0x2e, 0x96, 0xa1, 0xe9, 0x4c, 0x1f, 0x9f, 0x6b, 0x93, 0x23, 0x4b, 0x7f, 0x4c, 0x55, 0xde, 0x8b, 0x19, 0x61, 0xa3, 0xbf, 0x35, 0x22, 0x59 ],
const [ 0xcc, 0x6c, 0xa3, 0xa8, 0xcb, 0x39, 0x1c, 0xd8, 0xa5, 0xaf, 0xf1, 0xfa, 0xa7, 0xb3, 0xff, 0xbd, 0xd2, 0x1a, 0x5a, 0x3c, 0xe6, 0x6c, 0xfa, 0xdd, 0xbf, 0xe8, 0xb1, 0x79, 0xe4, 0xc8, 0x60, 0xbe, 0x5e, 0xc6, 0x6b, 0xd2, 0xc6, 0xde, 0x6a, 0x39, 0xa2, 0x56, 0x22, 0xf9, 0xf2, 0xfc, 0xb3, 0xfc, 0x05, 0xaf, 0x12, 0xb5 ],
const [ 0x7c, 0x0e, 0x6a, 0x0d, 0x35, 0xf8, 0xac, 0x85, 0x4c, 0x72, 0x45, 0xeb, 0xc7, 0x36, 0x93, 0x73, 0x1b, 0xbb, 0xc3, 0xe6, 0xfa, 0xb6, 0x44, 0x46, 0x6d, 0xe2, 0x7b, 0xb5, 0x22, 0xfc, 0xb9, 0x93, 0x07, 0x12, 0x6a, 0xe7, 0x18, 0xfe, 0x8f, 0x00, 0x74, 0x2e, 0x6e, 0x5c, 0xb7, 0xa6, 0x87, 0xc8, 0x84, 0x47, 0xcb, 0xc9, 0x61 ],
const [ 0xc5, 0x58, 0x1d, 0x40, 0xb3, 0x31, 0xe2, 0x40, 0x03, 0x90, 0x1b, 0xd6, 0xbf, 0x24, 0x4a, 0xca, 0x9e, 0x96, 0x01, 0xb9, 0xd8, 0x12, 0x52, 0xbb, 0x38, 0x04, 0x86, 0x42, 0x73, 0x1f, 0x11, 0x46, 0xb8, 0xa4, 0xc6, 0x9f, 0x88, 0xe1, 0x48, 0xb2, 0xc8, 0xf8, 0xc1, 0x4f, 0x15, 0xe1, 0xd6, 0xda, 0x57, 0xb2, 0xda, 0xa9, 0x99, 0x1e ],
const [ 0xec, 0x6b, 0x4a, 0x88, 0x71, 0x3d, 0xf2, 0x7c, 0x0f, 0x2d, 0x02, 0xe7, 0x38, 0xb6, 0x9d, 0xb4, 0x3a, 0xbd, 0xa3, 0x92, 0x13, 0x17, 0x25, 0x9c, 0x86, 0x4c, 0x1c, 0x38, 0x6e, 0x9a, 0x5a, 0x3f, 0x53, 0x3d, 0xc0, 0x5f, 0x3b, 0xee, 0xb2, 0xbe, 0xc2, 0xaa, 0xc8, 0xe0, 0x6d, 0xb4, 0xc6, 0xcb, 0x3c, 0xdd, 0xcf, 0x69, 0x7e, 0x03, 0xd5 ],
const [ 0x03, 0x21, 0x73, 0x6b, 0xeb, 0xa5, 0x78, 0xe9, 0x0a, 0xbc, 0x1a, 0x90, 0xaa, 0x56, 0x15, 0x7d, 0x87, 0x16, 0x18, 0xf6, 0xde, 0x0d, 0x76, 0x4c, 0xc8, 0xc9, 0x1e, 0x06, 0xc6, 0x8e, 0xcd, 0x3b, 0x9d, 0xe3, 0x82, 0x40, 0x64, 0x50, 0x33, 0x84, 0xdb, 0x67, 0xbe, 0xb7, 0xfe, 0x01, 0x22, 0x32, 0xda, 0xca, 0xef, 0x93, 0xa0, 0x00, 0xfb, 0xa7 ],
const [ 0xd0, 0xa2, 0x49, 0xa9, 0x7b, 0x5f, 0x14, 0x86, 0x72, 0x1a, 0x50, 0xd4, 0xc4, 0xab, 0x3f, 0x5d, 0x67, 0x4a, 0x0e, 0x29, 0x92, 0x5d, 0x5b, 0xf2, 0x67, 0x8e, 0xf6, 0xd8, 0xd5, 0x21, 0xe4, 0x56, 0xbd, 0x84, 0xaa, 0x75, 0x53, 0x28, 0xc8, 0x3f, 0xc8, 0x90, 0x83, 0x77, 0x26, 0xa8, 0xe7, 0x87, 0x7b, 0x57, 0x0d, 0xba, 0x39, 0x57, 0x9a, 0xab, 0xdd ],
const [ 0xc3, 0x21, 0x38, 0x53, 0x11, 0x18, 0xf0, 0x8c, 0x7d, 0xcc, 0x29, 0x24, 0x28, 0xad, 0x20, 0xb4, 0x5a, 0xb2, 0x7d, 0x95, 0x17, 0xa1, 0x84, 0x45, 0xf3, 0x8b, 0x8f, 0x0c, 0x27, 0x95, 0xbc, 0xdf, 0xe3, 0xff, 0xe3, 0x84, 0xe6, 0x5e, 0xcb, 0xf7, 0x4d, 0x2c, 0x9d, 0x0d, 0xa8, 0x83, 0x98, 0x57, 0x53, 0x26, 0x07, 0x49, 0x04, 0xc1, 0x70, 0x9b, 0xa0, 0x72 ],
const [ 0xb0, 0xf4, 0xcf, 0xb9, 0x39, 0xea, 0x78, 0x5e, 0xab, 0xb7, 0xe7, 0xca, 0x7c, 0x47, 0x6c, 0xdd, 0x9b, 0x22, 0x7f, 0x01, 0x5d, 0x90, 0x53, 0x68, 0xba, 0x00, 0xae, 0x96, 0xb9, 0xaa, 0xf7, 0x20, 0x29, 0x74, 0x91, 0xb3, 0x92, 0x12, 0x67, 0x57, 0x6b, 0x72, 0xc8, 0xf5, 0x8d, 0x57, 0x76, 0x17, 0xe8, 0x44, 0xf9, 0xf0, 0x75, 0x9b, 0x39, 0x9c, 0x6b, 0x06, 0x4c ],
const [ 0xbd, 0x02, 0xe5, 0x1b, 0x0c, 0xf2, 0xc2, 0xb8, 0xd2, 0x04, 0xa0, 0x26, 0xb4, 0x1a, 0x66, 0xfb, 0xfc, 0x2a, 0xc3, 0x7e, 0xe9, 0x41, 0x1f, 0xc4, 0x49, 0xc8, 0xd1, 0x19, 0x4a, 0x07, 0x92, 0xa2, 0x8e, 0xe7, 0x31, 0x40, 0x7d, 0xfc, 0x89, 0xb6, 0xdf, 0xc2, 0xb1, 0x0f, 0xaa, 0x27, 0x72, 0x3a, 0x18, 0x4a, 0xfe, 0xf8, 0xfd, 0x83, 0xde, 0xf8, 0x58, 0xa3, 0x2d, 0x3f ],
const [ 0xe3, 0x31, 0x46, 0xb8, 0x3e, 0x4b, 0xb6, 0x71, 0x39, 0x22, 0x18, 0xda, 0x9a, 0x77, 0xf8, 0xd9, 0xf5, 0x97, 0x41, 0x47, 0x18, 0x2f, 0xb9, 0x5b, 0xa6, 0x62, 0xcb, 0x66, 0x01, 0x19, 0x89, 0xc1, 0x6d, 0x9a, 0xf1, 0x04, 0x73, 0x5d, 0x6f, 0x79, 0x84, 0x1a, 0xa4, 0xd1, 0xdf, 0x27, 0x66, 0x15, 0xb5, 0x01, 0x08, 0xdf, 0x8a, 0x29, 0xdb, 0xc9, 0xde, 0x31, 0xf4, 0x26, 0x0d ],
const [ 0x41, 0x1c, 0x13, 0xc7, 0x50, 0x73, 0xc1, 0xe2, 0xd4, 0xb1, 0xec, 0xf1, 0x31, 0x39, 0xba, 0x96, 0x56, 0xcd, 0x35, 0xc1, 0x42, 0x01, 0xf1, 0xc7, 0xc6, 0xf0, 0xee, 0xb5, 0x8d, 0x2d, 0xbf, 0xe3, 0x5b, 0xfd, 0xec, 0xcc, 0x92, 0xc3, 0x96, 0x1c, 0xfa, 0xbb, 0x59, 0x0b, 0xc1, 0xeb, 0x77, 0xea, 0xc1, 0x57, 0x32, 0xfb, 0x02, 0x75, 0x79, 0x86, 0x80, 0xe0, 0xc7, 0x29, 0x2e, 0x50 ],
const [ 0xf2, 0xc7, 0x6e, 0xf6, 0x17, 0xfa, 0x2b, 0xfc, 0x8a, 0x4d, 0x6b, 0xcb, 0xb1, 0x5f, 0xe8, 0x84, 0x36, 0xfd, 0xc2, 0x16, 0x5d, 0x30, 0x74, 0x62, 0x95, 0x79, 0x07, 0x9d, 0x4d, 0x5b, 0x86, 0xf5, 0x08, 0x1a, 0xb1, 0x77, 0xb4, 0xc3, 0xf5, 0x30, 0x37, 0x6c, 0x9c, 0x92, 0x4c, 0xbd, 0x42, 0x1a, 0x8d, 0xaf, 0x88, 0x30, 0xd0, 0x94, 0x0c, 0x4f, 0xb7, 0x58, 0x98, 0x65, 0x83, 0x06, 0x99 ],
const [ 0x45, 0x92, 0x7e, 0x32, 0xdd, 0xf8, 0x01, 0xca, 0xf3, 0x5e, 0x18, 0xe7, 0xb5, 0x07, 0x8b, 0x7f, 0x54, 0x35, 0x27, 0x82, 0x12, 0xec, 0x6b, 0xb9, 0x9d, 0xf8, 0x84, 0xf4, 0x9b, 0x32, 0x7c, 0x64, 0x86, 0xfe, 0xae, 0x46, 0xba, 0x18, 0x7d, 0xc1, 0xcc, 0x91, 0x45, 0x12, 0x1e, 0x14, 0x92, 0xe6, 0xb0, 0x6e, 0x90, 0x07, 0x39, 0x4d, 0xc3, 0x3b, 0x77, 0x48, 0xf8, 0x6a, 0xc3, 0x20, 0x7c, 0xfe ],
];

const sha1_short_mds = const [
'da39a3ee5e6b4b0d3255bfef95601890afd80709',
'c1dfd96eea8cc2b62785275bca38ac261256e278',
'0a1c2d555bbe431ad6288af5a54f93e0449c9232',
'bf36ed5d74727dfd5d7854ec6b1d49468d8ee8aa',
'b78bae6d14338ffccfd5d5b5674a275f6ef9c717',
'60b7d5bb560a1acf6fa45721bd0abb419a841a89',
'a6d338459780c08363090fd8fc7d28dc80e8e01f',
'860328d80509500c1783169ebf0ba0c4b94da5e5',
'24a2c34b976305277ce58c2f42d5092031572520',
'411ccee1f6e3677df12698411eb09d3ff580af97',
'05c915b5ed4e4c4afffc202961f3174371e90b5c',
'af320b42d7785ca6c8dd220463be23a2d2cb5afc',
'9f4e66b6ceea40dcf4b9166c28f1c88474141da9',
'e6c4363c0852951991057f40de27ec0890466f01',
'046a7b396c01379a684a894558779b07d8c7da20',
'd58a262ee7b6577c07228e71ae9b3e04c8abcda9',
'a150de927454202d94e656de4c7c0ca691de955d',
'35a4b39fef560e7ea61246676e1b7e13d587be30',
'7ce69b1acdce52ea7dbd382531fa1a83df13cae7',
'b47be2c64124fa9a124a887af9551a74354ca411',
'8bb8c0d815a9c68a1d2910f39d942603d807fbcc',
'b486f87fb833ebf0328393128646a6f6e660fcb1',
'76159368f99dece30aadcfb9b7b41dab33688858',
'dbc1cb575ce6aeb9dc4ebf0f843ba8aeb1451e89',
'd7a98289679005eb930ab75efd8f650f991ee952',
'fda26fa9b4874ab701ed0bb64d134f89b9c4cc50',
'c2ff7ccde143c8f0601f6974b1903eb8d5741b6e',
'643c9dc20a929608f6caa9709d843ca6fa7a76f4',
'509ef787343d5b5a269229b961b96241864a3d74',
'b61ce538f1a1e6c90432b233d7af5b6524ebfbe3',
'5b7b94076b2fc20d6adb82479e6b28d07c902b75',
'6066db99fc358952cf7fb0ec4d89cb0158ed91d7',
'b89962c94d60f6a332fd60f6f07d4f032a586b76',
'17bda899c13d35413d2546212bcd8a93ceb0657b',
'badcdd53fdc144b8bf2cc1e64d10f676eebe66ed',
'01b4646180f1f6d2e06bbe22c20e50030322673a',
'10016dc3a2719f9034ffcc689426d28292c42fc9',
'9f42fa2bce6ef021d93c6b2d902273797e426535',
'cdf48bacbff6f6152515323f9b43a286e0cb8113',
'b88fb75274b9b0fd57c0045988cfcef6c3ce6554',
'c06d3a6a12d9e8db62e8cff40ca23820d61d8aa7',
'6e40f9e83a4be93874bc97cdebb8da6889ae2c7a',
'3efc940c312ef0dfd4e1143812248db89542f6a5',
'a0cf03f7badd0c3c3c4ea3717f5a4fb7e67b2e56',
'a544e06f1a07ceb175a51d6d9c0111b3e15e9859',
'199d986ed991b99a071f450c6b1121a727e8c735',
'33bac6104b0ad6128d091b5d5e2999099c9f05de',
'76d7db6e18c1f4ae225ce8ccc93c8f9a0dfeb969',
'f652f3b1549f16710c7402895911e2b86a9b2aee',
'63faebb807f32be708cf00fc35519991dc4e7f68',
'0e6730bc4a0e9322ea205f4edfff1fffda26af0a',
'b61a3a6f42e8e6604b93196c43c9e84d5359e6fe',
'32d979ca1b3ed0ed8c890d99ec6dd85e6c16abf4',
'6f18190bd2d02fc93bce64756575cea36d08b1c3',
'68f525feea1d8dbe0117e417ca46708d18d7629a',
'a7272e2308622ff7a339460adc61efd0ea8dabdc',
'aef843b86916c16f66c84d83a6005d23fd005c9e',
'be2cd6f380969be59cde2dff5e848a44e7880bd6',
'e5eb4543deee8f6a5287845af8b593a95a9749a1',
'534c850448dd486787b62bdec2d4a0b140a1b170',
'6fbfa6e4edce4cc85a845bf0d228dc39acefc2fa',
'018872691d9b04e8220e09187df5bc5fa6257cd9',
'd98d512a35572f8bd20de62e9510cc21145c5bf4',
'9f3ea255f6af95c5454e55d7354cabb45352ea0b',
'a70cfbfe7563dd0e665c7c6715a96a8d756950c0',
];
