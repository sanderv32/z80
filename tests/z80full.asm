
                    org 32768

0x8000 F3           |                   DI
0x8001 FD E5        |                   PUSH IY
0x8003 D9           |                   EXX
0x8004 E5           |                   PUSH HL
0x8005 CD 5B 81     |                   CALL $815B
0x8008 CD 60 81     |                   CALL $8160
0x800b 5A           |                   LD E,D
0x800c 38 30        |                   JR C,$30
0x800e 20 66        |                   JR NZ,$66
0x8010 75           |                   LD (HL),L
0x8011 6C           |                   LD L,H
0x8012 6C           |                   LD L,H
0x8013 20 74        |                   JR NZ,$74
0x8015 65           |                   LD H,L
0x8016 73           |                   LD (HL),E
0x8017 74           |                   LD (HL),H
0x8018 17           |                   RLA
0x8019 13           |                   INC DE
0x801a 01 7F 20     |                   LD BC,$207F
0x801d 32 30 31     |                   LD ($3130),A
0x8020 32 20 52     |                   LD ($5220),A
0x8023 41           |                   LD B,C
0x8024 58           |                   LD E,B
0x8025 4F           |                   LD C,A
0x8026 46           |                   LD B,(HL)
0x8027 54           |                   LD D,H
0x8028 0D           |                   DEC C
0x8029 0D           |                   DEC C
0x802a 00           |                   NOP
0x802b 01 00 00     |                   LD BC,$0000
0x802e 21 7A 88     |                   LD HL,$887A
0x8031 18 0A        |                   JR $0A
0x8033 E5           |                   PUSH HL
0x8034 C5           |                   PUSH BC
0x8035 CD 96 80     |                   CALL $8096
0x8038 C1           |                   POP BC
0x8039 E1           |                   POP HL
0x803a 80           |                   AA,B
0x803b 47           |                   LD B,A
0x803c 0C           |                   INC C
0x803d 5E           |                   LD E,(HL)
0x803e 23           |                   INC HL
0x803f 56           |                   LD D,(HL)
0x8040 23           |                   INC HL
0x8041 7A           |                   LD A,D
0x8042 B3           |                   OR E
0x8043 20 EE        |                   JR NZ,$EE
0x8045 CD 60 81     |                   CALL $8160
0x8048 0D           |                   DEC C
0x8049 52           |                   LD D,D
0x804a 65           |                   LD H,L
0x804b 73           |                   LD (HL),E
0x804c 75           |                   LD (HL),L
0x804d 6C           |                   LD L,H
0x804e 74           |                   LD (HL),H
0x804f 3A 20 00     |                   LD A,($0020)
0x8052 78           |                   LD A,B
0x8053 B7           |                   OR A
0x8054 28 24        |                   JR Z,$24
0x8056 CD 6F 81     |                   CALL $816F
0x8059 CD 60 81     |                   CALL $8160
0x805c 20 6F        |                   JR NZ,$6F
0x805e 66           |                   LD H,(HL)
0x805f 20 00        |                   JR NZ,$00
0x8061 79           |                   LD A,C
0x8062 CD 6F 81     |                   CALL $816F
0x8065 CD 60 81     |                   CALL $8160
0x8068 20 74        |                   JR NZ,$74
0x806a 65           |                   LD H,L
0x806b 73           |                   LD (HL),E
0x806c 74           |                   LD (HL),H
0x806d 73           |                   LD (HL),E
0x806e 20 66        |                   JR NZ,$66
0x8070 61           |                   LD H,C
0x8071 69           |                   LD L,C
0x8072 6C           |                   LD L,H
0x8073 65           |                   LD H,L
0x8074 64           |                   LD H,H
0x8075 2E 0D        |                   LD L,$0D
0x8077 00           |                   NOP
0x8078 18 16        |                   JR $16
0x807a CD 60 81     |                   CALL $8160
0x807d 61           |                   LD H,C
0x807e 6C           |                   LD L,H
0x807f 6C           |                   LD L,H
0x8080 20 74        |                   JR NZ,$74
0x8082 65           |                   LD H,L
0x8083 73           |                   LD (HL),E
0x8084 74           |                   LD (HL),H
0x8085 73           |                   LD (HL),E
0x8086 20 70        |                   JR NZ,$70
0x8088 61           |                   LD H,C
0x8089 73           |                   LD (HL),E
0x808a 73           |                   LD (HL),E
0x808b 65           |                   LD H,L
0x808c 64           |                   LD H,H
0x808d 2E 0D        |                   LD L,$0D
0x808f 00           |                   NOP
0x8090 E1           |                   POP HL
0x8091 D9           |                   EXX
0x8092 FD E1        |                   POP IY
0x8094 FB           |                   EI
0x8095 C9           |                   RET
0x8096 C5           |                   PUSH BC
0x8097 79           |                   LD A,C
0x8098 CD 6F 81     |                   CALL $816F
0x809b 3E 20        |                   LD A,$20
0x809d CD A2 81     |                   CALL $81A2
0x80a0 21 41 00     |                   LD HL,$0041
0x80a3 19           |                   ADD HL,DE
0x80a4 CD 66 81     |                   CALL $8166
0x80a7 C1           |                   POP BC
0x80a8 7E           |                   LD A,(HL)
0x80a9 FE 01        |                   CP $01
0x80ab 28 15        |                   JR Z,$15
0x80ad 30 48        |                   JR NC,$48
0x80af B0           |                   OR B
0x80b0 20 45        |                   JR NZ,$45
0x80b2 CD 60 81     |                   CALL $8160
0x80b5 17           |                   RLA
0x80b6 19           |                   ADD HL,DE
0x80b7 01 53 6B     |                   LD BC,$6B53
0x80ba 69           |                   LD L,C
0x80bb 70           |                   LD (HL),B
0x80bc 70           |                   LD (HL),B
0x80bd 65           |                   LD H,L
0x80be 64           |                   LD H,H
0x80bf 0D           |                   DEC C
0x80c0 00           |                   NOP
0x80c1 C9           |                   RET
0x80c2 AF           |                   XOR A
0x80c3 DB FE        |                   IN A,($FE)
0x80c5 FE BF        |                   CP $BF
0x80c7 28 2E        |                   JR Z,$2E
0x80c9 5F           |                   LD E,A
0x80ca CD 60 81     |                   CALL $8160
0x80cd 17           |                   RLA
0x80ce 1A           |                   LD A,(DE)
0x80cf 01 46 41     |                   LD BC,$4146
0x80d2 49           |                   LD C,C
0x80d3 4C           |                   LD C,H
0x80d4 45           |                   LD B,L
0x80d5 44           |                   LD B,H
0x80d6 0D           |                   DEC C
0x80d7 49           |                   LD C,C
0x80d8 4E           |                   LD C,(HL)
0x80d9 20 46        |                   JR NZ,$46
0x80db 45           |                   LD B,L
0x80dc 3A 00 7B     |                   LD A,($7B00)
0x80df CD 92 81     |                   CALL $8192
0x80e2 CD 60 81     |                   CALL $8160
0x80e5 17           |                   RLA
0x80e6 15           |                   DEC D
0x80e7 01 45 78     |                   LD BC,$7845
0x80ea 70           |                   LD (HL),B
0x80eb 65           |                   LD H,L
0x80ec 63           |                   LD H,E
0x80ed 74           |                   LD (HL),H
0x80ee 65           |                   LD H,L
0x80ef 64           |                   LD H,H
0x80f0 3A 42 46     |                   LD A,($4642)
0x80f3 0D           |                   DEC C
0x80f4 00           |                   NOP
0x80f5 3C           |                   INC A
0x80f6 C9           |                   RET
0x80f7 21 3D 00     |                   LD HL,$003D
0x80fa 19           |                   ADD HL,DE
0x80fb E5           |                   PUSH HL
0x80fc EB           |                   EX DE,HL
0x80fd CD 00 82     |                   CALL $8200
0x8100 21 03 88     |                   LD HL,$8803
0x8103 73           |                   LD (HL),E
0x8104 2B           |                   DEC HL
0x8105 72           |                   LD (HL),D
0x8106 2B           |                   DEC HL
0x8107 71           |                   LD (HL),C
0x8108 2B           |                   DEC HL
0x8109 70           |                   LD (HL),B
0x810a D1           |                   POP DE
0x810b 06 04        |                   LD B,$04
0x810d CD 4E 81     |                   CALL $814E
0x8110 20 0B        |                   JR NZ,$0B
0x8112 CD 60 81     |                   CALL $8160
0x8115 17           |                   RLA
0x8116 1E 01        |                   LD E,$01
0x8118 4F           |                   LD C,A
0x8119 4B           |                   LD C,E
0x811a 0D           |                   DEC C
0x811b 00           |                   NOP
0x811c C9           |                   RET
0x811d CD 60 81     |                   CALL $8160
0x8120 17           |                   RLA
0x8121 1A           |                   LD A,(DE)
0x8122 01 46 41     |                   LD BC,$4146
0x8125 49           |                   LD C,C
0x8126 4C           |                   LD C,H
0x8127 45           |                   LD B,L
0x8128 44           |                   LD B,H
0x8129 0D           |                   DEC C
0x812a 43           |                   LD B,E
0x812b 52           |                   LD D,D
0x812c 43           |                   LD B,E
0x812d 3A 00 CD     |                   LD A,($CD00)
0x8130 88           |                   ADC A,B
0x8131 81           |                   AA,C
0x8132 CD 60 81     |                   CALL $8160
0x8135 20 20        |                   JR NZ,$20
0x8137 20 45        |                   JR NZ,$45
0x8139 78           |                   LD A,B
0x813a 70           |                   LD (HL),B
0x813b 65           |                   LD H,L
0x813c 63           |                   LD H,E
0x813d 74           |                   LD (HL),H
0x813e 65           |                   LD H,L
0x813f 64           |                   LD H,H
0x8140 3A 00 EB     |                   LD A,($EB00)
0x8143 CD 88 81     |                   CALL $8188
0x8146 3E 0D        |                   LD A,$0D
0x8148 CD A2 81     |                   CALL $81A2
0x814b 3E 01        |                   LD A,$01
0x814d C9           |                   RET
0x814e E5           |                   PUSH HL
0x814f D5           |                   PUSH DE
0x8150 1A           |                   LD A,(DE)
0x8151 AE           |                   XOR (HL)
0x8152 20 04        |                   JR NZ,$04
0x8154 13           |                   INC DE
0x8155 23           |                   INC HL
0x8156 10 F8        |                   DJNZ $F8
0x8158 D1           |                   POP DE
0x8159 E1           |                   POP HL
0x815a C9           |                   RET
0x815b 3E 02        |                   LD A,$02
0x815d C3 01 16     |                   JP $1601
0x8160 E3           |                   EX (SP),HL
0x8161 CD 66 81     |                   CALL $8166
0x8164 E3           |                   EX (SP),HL
0x8165 C9           |                   RET
0x8166 7E           |                   LD A,(HL)
0x8167 23           |                   INC HL
0x8168 B7           |                   OR A
0x8169 C8           |                   RET Z
0x816a CD A2 81     |                   CALL $81A2
0x816d 18 F7        |                   JR $F7
0x816f 67           |                   LD H,A
0x8170 06 9C        |                   LD B,$9C
0x8172 CD 7C 81     |                   CALL $817C
0x8175 06 F6        |                   LD B,$F6
0x8177 CD 7C 81     |                   CALL $817C
0x817a 06 FF        |                   LD B,$FF
0x817c 7C           |                   LD A,H
0x817d 2E 2F        |                   LD L,$2F
0x817f 2C           |                   INC L
0x8180 80           |                   AA,B
0x8181 38 FC        |                   JR C,$FC
0x8183 90           |                   SUB A,B
0x8184 67           |                   LD H,A
0x8185 7D           |                   LD A,L
0x8186 18 1A        |                   JR $1A
0x8188 06 04        |                   LD B,$04
0x818a 7E           |                   LD A,(HL)
0x818b 23           |                   INC HL
0x818c CD 92 81     |                   CALL $8192
0x818f 10 F9        |                   DJNZ $F9
0x8191 C9           |                   RET
0x8192 F5           |                   PUSH AF
0x8193 0F           |                   RRCA
0x8194 0F           |                   RRCA
0x8195 0F           |                   RRCA
0x8196 0F           |                   RRCA
0x8197 CD 9B 81     |                   CALL $819B
0x819a F1           |                   POP AF
0x819b F6 F0        |                   OR $F0
0x819d 27           |                   DAA
0x819e C6 A0        |                   ADD A,$A0
0x81a0 CE 40        |                   ADC A,$40
0x81a2 FD E5        |                   PUSH IY
0x81a4 FD 21 3A 5C  |                   LD IY,$5C3A
0x81a8 D5           |                   PUSH DE
0x81a9 C5           |                   PUSH BC
0x81aa D9           |                   EXX
0x81ab FB           |                   EI
0x81ac D7           |                   RST $10
0x81ad F3           |                   DI
0x81ae D9           |                   EXX
0x81af C1           |                   POP BC
0x81b0 D1           |                   POP DE
0x81b1 FD E1        |                   POP IY
0x81b3 C9           |                   RET
0x81b4 00           |                   NOP
0x81b5 00           |                   NOP
0x81b6 00           |                   NOP
0x81b7 00           |                   NOP
0x81b8 00           |                   NOP
0x81b9 00           |                   NOP
0x81ba 00           |                   NOP
0x81bb 00           |                   NOP
0x81bc 00           |                   NOP
0x81bd 00           |                   NOP
0x81be 00           |                   NOP
0x81bf 00           |                   NOP
0x81c0 00           |                   NOP
0x81c1 00           |                   NOP
0x81c2 00           |                   NOP
0x81c3 00           |                   NOP
0x81c4 00           |                   NOP
0x81c5 00           |                   NOP
0x81c6 00           |                   NOP
0x81c7 00           |                   NOP
0x81c8 00           |                   NOP
0x81c9 00           |                   NOP
0x81ca 00           |                   NOP
0x81cb 00           |                   NOP
0x81cc 00           |                   NOP
0x81cd 00           |                   NOP
0x81ce 00           |                   NOP
0x81cf 00           |                   NOP
0x81d0 00           |                   NOP
0x81d1 00           |                   NOP
0x81d2 00           |                   NOP
0x81d3 00           |                   NOP
0x81d4 00           |                   NOP
0x81d5 00           |                   NOP
0x81d6 00           |                   NOP
0x81d7 00           |                   NOP
0x81d8 00           |                   NOP
0x81d9 00           |                   NOP
0x81da 00           |                   NOP
0x81db 00           |                   NOP
0x81dc 00           |                   NOP
0x81dd 00           |                   NOP
0x81de 00           |                   NOP
0x81df 00           |                   NOP
0x81e0 00           |                   NOP
0x81e1 00           |                   NOP
0x81e2 00           |                   NOP
0x81e3 00           |                   NOP
0x81e4 00           |                   NOP
0x81e5 00           |                   NOP
0x81e6 00           |                   NOP
0x81e7 00           |                   NOP
0x81e8 00           |                   NOP
0x81e9 00           |                   NOP
0x81ea 00           |                   NOP
0x81eb 00           |                   NOP
0x81ec 00           |                   NOP
0x81ed 00           |                   NOP
0x81ee 00           |                   NOP
0x81ef 00           |                   NOP
0x81f0 00           |                   NOP
0x81f1 00           |                   NOP
0x81f2 00           |                   NOP
0x81f3 00           |                   NOP
0x81f4 00           |                   NOP
0x81f5 00           |                   NOP
0x81f6 00           |                   NOP
0x81f7 00           |                   NOP
0x81f8 00           |                   NOP
0x81f9 00           |                   NOP
0x81fa 00           |                   NOP
0x81fb 00           |                   NOP
0x81fc 00           |                   NOP
0x81fd 00           |                   NOP
0x81fe 00           |                   NOP
0x81ff 00           |                   NOP
0x8200 ED 73 9D 83  |                   LD ($839D),SP
0x8204 23           |                   INC HL
0x8205 11 14 88     |                   LD DE,$8814
0x8208 01 14 00     |                   LD BC,$0014
0x820b CD A0 83     |                   CALL $83A0
0x820e 09           |                   ADD HL,BC
0x820f CD A0 83     |                   CALL $83A0
0x8212 CD A0 83     |                   CALL $83A0
0x8215 09           |                   ADD HL,BC
0x8216 ED 53 76 83  |                   LD ($8376),DE
0x821a 13           |                   INC DE
0x821b CD A7 83     |                   CALL $83A7
0x821e ED 53 73 83  |                   LD ($8373),DE
0x8222 AF           |                   XOR A
0x8223 12           |                   LD (DE),A
0x8224 13           |                   INC DE
0x8225 CD A0 83     |                   CALL $83A0
0x8228 3E 07        |                   LD A,$07
0x822a D3 FE        |                   OUT ($FE),A
0x822c 3E A9        |                   LD A,$A9
0x822e ED 47        |                   LD I,A
0x8230 ED 4F        |                   LD R,A
0x8232 B7           |                   OR A
0x8233 08           |                   EX AF,AF'
0x8234 01 FF FF     |                   LD BC,$FFFF
0x8237 50           |                   LD D,B
0x8238 59           |                   LD E,C
0x8239 D9           |                   EXX
0x823a 31 00 88     |                   LD SP,$8800
0x823d 21 28 88     |                   LD HL,$8828
0x8240 11 51 88     |                   LD DE,$8851
0x8243 01 14 88     |                   LD BC,$8814
0x8246 0A           |                   LD A,(BC)
0x8247 AE           |                   XOR (HL)
0x8248 EB           |                   EX DE,HL
0x8249 AE           |                   XOR (HL)
0x824a FE 76        |                   CP $76
0x824c CA 5A 83     |                   JP Z,$835A
0x824f 32 2B 83     |                   LD ($832B),A
0x8252 0C           |                   INC C
0x8253 1C           |                   INC E
0x8254 2C           |                   INC L
0x8255 0A           |                   LD A,(BC)
0x8256 AE           |                   XOR (HL)
0x8257 EB           |                   EX DE,HL
0x8258 AE           |                   XOR (HL)
0x8259 32 2C 83     |                   LD ($832C),A
0x825c FE 76        |                   CP $76
0x825e C2 6B 82     |                   JP NZ,$826B
0x8261 3A 2B 83     |                   LD A,($832B)
0x8264 E6 DF        |                   AND $DF
0x8266 FE DD        |                   CP $DD
0x8268 CA 5A 83     |                   JP Z,$835A
0x826b 0C           |                   INC C
0x826c 1C           |                   INC E
0x826d 2C           |                   INC L
0x826e 0A           |                   LD A,(BC)
0x826f AE           |                   XOR (HL)
0x8270 EB           |                   EX DE,HL
0x8271 AE           |                   XOR (HL)
0x8272 32 2D 83     |                   LD ($832D),A
0x8275 0C           |                   INC C
0x8276 1C           |                   INC E
0x8277 2C           |                   INC L
0x8278 0A           |                   LD A,(BC)
0x8279 AE           |                   XOR (HL)
0x827a EB           |                   EX DE,HL
0x827b AE           |                   XOR (HL)
0x827c 32 2E 83     |                   LD ($832E),A
0x827f 0C           |                   INC C
0x8280 1C           |                   INC E
0x8281 2C           |                   INC L
0x8282 0A           |                   LD A,(BC)
0x8283 AE           |                   XOR (HL)
0x8284 EB           |                   EX DE,HL
0x8285 AE           |                   XOR (HL)
0x8286 32 00 88     |                   LD ($8800),A
0x8289 0C           |                   INC C
0x828a 1C           |                   INC E
0x828b 2C           |                   INC L
0x828c 0A           |                   LD A,(BC)
0x828d AE           |                   XOR (HL)
0x828e EB           |                   EX DE,HL
0x828f AE           |                   XOR (HL)
0x8290 32 01 88     |                   LD ($8801),A
0x8293 0C           |                   INC C
0x8294 1C           |                   INC E
0x8295 2C           |                   INC L
0x8296 0A           |                   LD A,(BC)
0x8297 AE           |                   XOR (HL)
0x8298 EB           |                   EX DE,HL
0x8299 AE           |                   XOR (HL)
0x829a 32 02 88     |                   LD ($8802),A
0x829d 0C           |                   INC C
0x829e 1C           |                   INC E
0x829f 2C           |                   INC L
0x82a0 0A           |                   LD A,(BC)
0x82a1 AE           |                   XOR (HL)
0x82a2 EB           |                   EX DE,HL
0x82a3 AE           |                   XOR (HL)
0x82a4 32 03 88     |                   LD ($8803),A
0x82a7 0C           |                   INC C
0x82a8 1C           |                   INC E
0x82a9 2C           |                   INC L
0x82aa 0A           |                   LD A,(BC)
0x82ab AE           |                   XOR (HL)
0x82ac EB           |                   EX DE,HL
0x82ad AE           |                   XOR (HL)
0x82ae 32 04 88     |                   LD ($8804),A
0x82b1 0C           |                   INC C
0x82b2 1C           |                   INC E
0x82b3 2C           |                   INC L
0x82b4 0A           |                   LD A,(BC)
0x82b5 AE           |                   XOR (HL)
0x82b6 EB           |                   EX DE,HL
0x82b7 AE           |                   XOR (HL)
0x82b8 32 05 88     |                   LD ($8805),A
0x82bb 0C           |                   INC C
0x82bc 1C           |                   INC E
0x82bd 2C           |                   INC L
0x82be 0A           |                   LD A,(BC)
0x82bf AE           |                   XOR (HL)
0x82c0 EB           |                   EX DE,HL
0x82c1 AE           |                   XOR (HL)
0x82c2 32 06 88     |                   LD ($8806),A
0x82c5 0C           |                   INC C
0x82c6 1C           |                   INC E
0x82c7 2C           |                   INC L
0x82c8 0A           |                   LD A,(BC)
0x82c9 AE           |                   XOR (HL)
0x82ca EB           |                   EX DE,HL
0x82cb AE           |                   XOR (HL)
0x82cc 32 07 88     |                   LD ($8807),A
0x82cf 0C           |                   INC C
0x82d0 1C           |                   INC E
0x82d1 2C           |                   INC L
0x82d2 0A           |                   LD A,(BC)
0x82d3 AE           |                   XOR (HL)
0x82d4 EB           |                   EX DE,HL
0x82d5 AE           |                   XOR (HL)
0x82d6 32 08 88     |                   LD ($8808),A
0x82d9 0C           |                   INC C
0x82da 1C           |                   INC E
0x82db 2C           |                   INC L
0x82dc 0A           |                   LD A,(BC)
0x82dd AE           |                   XOR (HL)
0x82de EB           |                   EX DE,HL
0x82df AE           |                   XOR (HL)
0x82e0 32 09 88     |                   LD ($8809),A
0x82e3 0C           |                   INC C
0x82e4 1C           |                   INC E
0x82e5 2C           |                   INC L
0x82e6 0A           |                   LD A,(BC)
0x82e7 AE           |                   XOR (HL)
0x82e8 EB           |                   EX DE,HL
0x82e9 AE           |                   XOR (HL)
0x82ea 32 0A 88     |                   LD ($880A),A
0x82ed 0C           |                   INC C
0x82ee 1C           |                   INC E
0x82ef 2C           |                   INC L
0x82f0 0A           |                   LD A,(BC)
0x82f1 AE           |                   XOR (HL)
0x82f2 EB           |                   EX DE,HL
0x82f3 AE           |                   XOR (HL)
0x82f4 32 0B 88     |                   LD ($880B),A
0x82f7 0C           |                   INC C
0x82f8 1C           |                   INC E
0x82f9 2C           |                   INC L
0x82fa 0A           |                   LD A,(BC)
0x82fb AE           |                   XOR (HL)
0x82fc EB           |                   EX DE,HL
0x82fd AE           |                   XOR (HL)
0x82fe 32 0C 88     |                   LD ($880C),A
0x8301 0C           |                   INC C
0x8302 1C           |                   INC E
0x8303 2C           |                   INC L
0x8304 0A           |                   LD A,(BC)
0x8305 AE           |                   XOR (HL)
0x8306 EB           |                   EX DE,HL
0x8307 AE           |                   XOR (HL)
0x8308 32 0D 88     |                   LD ($880D),A
0x830b 0C           |                   INC C
0x830c 1C           |                   INC E
0x830d 2C           |                   INC L
0x830e 0A           |                   LD A,(BC)
0x830f AE           |                   XOR (HL)
0x8310 EB           |                   EX DE,HL
0x8311 AE           |                   XOR (HL)
0x8312 32 0E 88     |                   LD ($880E),A
0x8315 0C           |                   INC C
0x8316 1C           |                   INC E
0x8317 2C           |                   INC L
0x8318 0A           |                   LD A,(BC)
0x8319 AE           |                   XOR (HL)
0x831a EB           |                   EX DE,HL
0x831b AE           |                   XOR (HL)
0x831c 32 0F 88     |                   LD ($880F),A
0x831f F1           |                   POP AF
0x8320 C1           |                   POP BC
0x8321 D1           |                   POP DE
0x8322 E1           |                   POP HL
0x8323 DD E1        |                   POP IX
0x8325 FD E1        |                   POP IY
0x8327 ED 7B 0E 88  |                   LD SP,($880E)
0x832b 00           |                   NOP
0x832c 00           |                   NOP
0x832d 00           |                   NOP
0x832e 00           |                   NOP
0x832f ED 73 0E 88  |                   LD ($880E),SP
0x8333 31 0C 88     |                   LD SP,$880C
0x8336 FD E5        |                   PUSH IY
0x8338 DD E5        |                   PUSH IX
0x833a E5           |                   PUSH HL
0x833b D5           |                   PUSH DE
0x833c C5           |                   PUSH BC
0x833d F5           |                   PUSH AF
0x833e 21 00 88     |                   LD HL,$8800
0x8341 06 10        |                   LD B,$10
0x8343 7E           |                   LD A,(HL)
0x8344 D9           |                   EXX
0x8345 AB           |                   XOR E
0x8346 6F           |                   LD L,A
0x8347 26 84        |                   LD H,$84
0x8349 7E           |                   LD A,(HL)
0x834a AA           |                   XOR D
0x834b 5F           |                   LD E,A
0x834c 24           |                   INC H
0x834d 7E           |                   LD A,(HL)
0x834e A9           |                   XOR C
0x834f 57           |                   LD D,A
0x8350 24           |                   INC H
0x8351 7E           |                   LD A,(HL)
0x8352 A8           |                   XOR B
0x8353 4F           |                   LD C,A
0x8354 24           |                   INC H
0x8355 46           |                   LD B,(HL)
0x8356 D9           |                   EXX
0x8357 23           |                   INC HL
0x8358 10 E9        |                   DJNZ $E9
0x835a 21 3C 88     |                   LD HL,$883C
0x835d 11 28 88     |                   LD DE,$8828
0x8360 06 14        |                   LD B,$14
0x8362 1A           |                   LD A,(DE)
0x8363 B7           |                   OR A
0x8364 28 06        |                   JR Z,$06
0x8366 3D           |                   DEC A
0x8367 A6           |                   AND (HL)
0x8368 12           |                   LD (DE),A
0x8369 C3 3D 82     |                   JP $823D
0x836c 7E           |                   LD A,(HL)
0x836d 12           |                   LD (DE),A
0x836e 2C           |                   INC L
0x836f 1C           |                   INC E
0x8370 10 F0        |                   DJNZ $F0
0x8372 21 65 88     |                   LD HL,$8865
0x8375 11 50 88     |                   LD DE,$8850
0x8378 1A           |                   LD A,(DE)
0x8379 87           |                   AA,A
0x837a ED 44        |                   NEG
0x837c 86           |                   AA,(HL)
0x837d AE           |                   XOR (HL)
0x837e A6           |                   AND (HL)
0x837f 12           |                   LD (DE),A
0x8380 C2 3D 82     |                   JP NZ,$823D
0x8383 2C           |                   INC L
0x8384 1C           |                   INC E
0x8385 7B           |                   LD A,E
0x8386 FE 65        |                   CP $65
0x8388 28 11        |                   JR Z,$11
0x838a 7E           |                   LD A,(HL)
0x838b 3D           |                   DEC A
0x838c AE           |                   XOR (HL)
0x838d A6           |                   AND (HL)
0x838e 28 F3        |                   JR Z,$F3
0x8390 12           |                   LD (DE),A
0x8391 22 73 83     |                   LD ($8373),HL
0x8394 ED 53 76 83  |                   LD ($8376),DE
0x8398 C3 3D 82     |                   JP $823D
0x839b D9           |                   EXX
0x839c 31 00 00     |                   LD SP,$0000
0x839f C9           |                   RET
0x83a0 E5           |                   PUSH HL
0x83a1 C5           |                   PUSH BC
0x83a2 ED B0        |                   LDIR
0x83a4 C1           |                   POP BC
0x83a5 E1           |                   POP HL
0x83a6 C9           |                   RET
0x83a7 E5           |                   PUSH HL
0x83a8 C5           |                   PUSH BC
0x83a9 62           |                   LD H,D
0x83aa 6B           |                   LD L,E
0x83ab 36 00        |                   LD (HL),$00
0x83ad 13           |                   INC DE
0x83ae 0B           |                   DEC BC
0x83af ED B0        |                   LDIR
0x83b1 C1           |                   POP BC
0x83b2 E1           |                   POP HL
0x83b3 C9           |                   RET
0x83b4 00           |                   NOP
0x83b5 00           |                   NOP
0x83b6 00           |                   NOP
0x83b7 00           |                   NOP
0x83b8 00           |                   NOP
0x83b9 00           |                   NOP
0x83ba 00           |                   NOP
0x83bb 00           |                   NOP
0x83bc 00           |                   NOP
0x83bd 00           |                   NOP
0x83be 00           |                   NOP
0x83bf 00           |                   NOP
0x83c0 00           |                   NOP
0x83c1 00           |                   NOP
0x83c2 00           |                   NOP
0x83c3 00           |                   NOP
0x83c4 00           |                   NOP
0x83c5 00           |                   NOP
0x83c6 00           |                   NOP
0x83c7 00           |                   NOP
0x83c8 00           |                   NOP
0x83c9 00           |                   NOP
0x83ca 00           |                   NOP
0x83cb 00           |                   NOP
0x83cc 00           |                   NOP
0x83cd 00           |                   NOP
0x83ce 00           |                   NOP
0x83cf 00           |                   NOP
0x83d0 00           |                   NOP
0x83d1 00           |                   NOP
0x83d2 00           |                   NOP
0x83d3 00           |                   NOP
0x83d4 00           |                   NOP
0x83d5 00           |                   NOP
0x83d6 00           |                   NOP
0x83d7 00           |                   NOP
0x83d8 00           |                   NOP
0x83d9 00           |                   NOP
0x83da 00           |                   NOP
0x83db 00           |                   NOP
0x83dc 00           |                   NOP
0x83dd 00           |                   NOP
0x83de 00           |                   NOP
0x83df 00           |                   NOP
0x83e0 00           |                   NOP
0x83e1 00           |                   NOP
0x83e2 00           |                   NOP
0x83e3 00           |                   NOP
0x83e4 00           |                   NOP
0x83e5 00           |                   NOP
0x83e6 00           |                   NOP
0x83e7 00           |                   NOP
0x83e8 00           |                   NOP
0x83e9 00           |                   NOP
0x83ea 00           |                   NOP
0x83eb 00           |                   NOP
0x83ec 00           |                   NOP
0x83ed 00           |                   NOP
0x83ee 00           |                   NOP
0x83ef 00           |                   NOP
0x83f0 00           |                   NOP
0x83f1 00           |                   NOP
0x83f2 00           |                   NOP
0x83f3 00           |                   NOP
0x83f4 00           |                   NOP
0x83f5 00           |                   NOP
0x83f6 00           |                   NOP
0x83f7 00           |                   NOP
0x83f8 00           |                   NOP
0x83f9 00           |                   NOP
0x83fa 00           |                   NOP
0x83fb 00           |                   NOP
0x83fc 00           |                   NOP
0x83fd 00           |                   NOP
0x83fe 00           |                   NOP
0x83ff 00           |                   NOP
0x8400 00           |                   NOP
0x8401 96           |                   SUB A,(HL)
0x8402 2C           |                   INC L
0x8403 BA           |                   CP D
0x8404 19           |                   ADD HL,DE
0x8405 8F           |                   ADC A,A
0x8406 35           |                   DEC (HL)
0x8407 A3           |                   AND E
0x8408 32 A4 1E     |                   LD ($1EA4),A
0x840b 88           |                   ADC A,B
0x840c 2B           |                   DEC HL
0x840d BD           |                   CP L
0x840e 07           |                   RLCA
0x840f 91           |                   SUB A,C
0x8410 64           |                   LD H,H
0x8411 F2 48 DE     |                   JP P,$DE48
0x8414 7D           |                   LD A,L
0x8415 EB           |                   EX DE,HL
0x8416 51           |                   LD D,C
0x8417 C7           |                   RST $00
0x8418 56           |                   LD D,(HL)
0x8419 C0           |                   RET NZ
0x841a 7A           |                   LD A,D
0x841b EC 4F D9     |                   CALL P,$D94F
0x841e 63           |                   LD H,E
0x841f F5           |                   PUSH AF
0x8420 C8           |                   RET Z
0x8421 5E           |                   LD E,(HL)
0x8422 E4 72 D1     |                   CALL PO,$D172
0x8425 47           |                   LD B,A
0x8426 FD 6B        |                   LD IYL,E
0x8428 FA 6C D6     |                   JP M,$D66C
0x842b 40           |                   LD B,B
0x842c E3           |                   EX (SP),HL
0x842d 75           |                   LD (HL),L
0x842e CF           |                   RST $08
0x842f 59           |                   LD E,C
0x8430 AC           |                   XOR H
0x8431 3A 80 16     |                   LD A,($1680)
0x8434 B5           |                   OR L
0x8435 23           |                   INC HL
0x8436 99           |                   SBC A,C
0x8437 0F           |                   RRCA
0x8438 9E           |                   SBC A,(HL)
0x8439 08           |                   EX AF,AF'
0x843a B2           |                   OR D
0x843b 24           |                   INC H
0x843c 87           |                   AA,A
0x843d 11 AB 3D     |                   LD DE,$3DAB
0x8440 90           |                   SUB A,B
0x8441 06 BC        |                   LD B,$BC
0x8443 2A 89 1F     |                   LD HL,($1F89)
0x8446 A5           |                   AND L
0x8447 33           |                   INC SP
0x8448 A2           |                   AND D
0x8449 34           |                   INC (HL)
0x844a 8E           |                   ADC A,(HL)
0x844b 18 BB        |                   JR $BB
0x844d 2D           |                   DEC L
0x844e 97           |                   SUB A,A
0x844f 01 F4 62     |                   LD BC,$62F4
0x8452 D8           |                   RET C
0x8453 4E           |                   LD C,(HL)
0x8454 ED 7B C1 57  |                   LD SP,($57C1)
0x8458 C6 50        |                   ADD A,$50
0x845a EA 7C DF     |                   JP PE,$DF7C
0x845d 49           |                   LD C,C
0x845e F3           |                   DI
0x845f 65           |                   LD H,L
0x8460 58           |                   LD E,B
0x8461 CE 74        |                   ADC A,$74
0x8463 E2 41 D7     |                   JP PO,$D741
0x8466 6D           |                   LD L,L
0x8467 FB           |                   EI
0x8468 6A           |                   LD L,D
0x8469 FC 46 D0     |                   CALL M,$D046
0x846c 73           |                   LD (HL),E
0x846d E5           |                   PUSH HL
0x846e 5F           |                   LD E,A
0x846f C9           |                   RET
0x8470 3C           |                   INC A
0x8471 AA           |                   XOR D
0x8472 10 86        |                   DJNZ $86
0x8474 25           |                   DEC H
0x8475 B3           |                   OR E
0x8476 09           |                   ADD HL,BC
0x8477 9F           |                   SBC A,A
0x8478 0E 98        |                   LD C,$98
0x847a 22 B4 17     |                   LD ($17B4),HL
0x847d 81           |                   AA,C
0x847e 3B           |                   DEC SP
0x847f AD           |                   XOR L
0x8480 20 B6        |                   JR NZ,$B6
0x8482 0C           |                   INC C
0x8483 9A           |                   SBC A,D
0x8484 39           |                   ADD HL,SP
0x8485 AF           |                   XOR A
0x8486 15           |                   DEC D
0x8487 83           |                   AA,E
0x8488 12           |                   LD (DE),A
0x8489 84           |                   AA,H
0x848a 3E A8        |                   LD A,$A8
0x848c 0B           |                   DEC BC
0x848d 9D           |                   SBC A,L
0x848e 27           |                   DAA
0x848f B1           |                   OR C
0x8490 44           |                   LD B,H
0x8491 D2 68 FE     |                   JP NC,$FE68
0x8494 5D           |                   LD E,L
0x8495 CB 71        |                   BIT 6,C
0x8497 E7           |                   RST $20
0x8498 76           |                   HALT
0x8499 E0           |                   RET PO
0x849a 5A           |                   LD E,D
0x849b CC 6F F9     |                   CALL Z,$F96F
0x849e 43           |                   LD B,E
0x849f D5           |                   PUSH DE
0x84a0 E8           |                   RET PE
0x84a1 7E           |                   LD A,(HL)
0x84a2 C4 52 F1     |                   CALL NZ,$F152
0x84a5 67           |                   LD H,A
0x84a6 DD           |                   *ILLEGAL*
0x84a7 4B           |                   LD C,E
0x84a8 DA 4C F6     |                   JP C,$F64C
0x84ab 60           |                   LD H,B
0x84ac C3 55 EF     |                   JP $EF55
0x84af 79           |                   LD A,C
0x84b0 8C           |                   ADC A,H
0x84b1 1A           |                   LD A,(DE)
0x84b2 A0           |                   AND B
0x84b3 36 95        |                   LD (HL),$95
0x84b5 03           |                   INC BC
0x84b6 B9           |                   CP C
0x84b7 2F           |                   CPL
0x84b8 BE           |                   CP (HL)
0x84b9 28 92        |                   JR Z,$92
0x84bb 04           |                   INC B
0x84bc A7           |                   AND A
0x84bd 31 8B 1D     |                   LD SP,$1D8B
0x84c0 B0           |                   OR B
0x84c1 26 9C        |                   LD H,$9C
0x84c3 0A           |                   LD A,(BC)
0x84c4 A9           |                   XOR C
0x84c5 3F           |                   CCF
0x84c6 85           |                   AA,L
0x84c7 13           |                   INC DE
0x84c8 82           |                   AA,D
0x84c9 14           |                   INC D
0x84ca AE           |                   XOR (HL)
0x84cb 38 9B        |                   JR C,$9B
0x84cd 0D           |                   DEC C
0x84ce B7           |                   OR A
0x84cf 21 D4 42     |                   LD HL,$42D4
0x84d2 F8           |                   RET M
0x84d3 6E           |                   LD L,(HL)
0x84d4 CD 5B E1     |                   CALL $E15B
0x84d7 77           |                   LD (HL),A
0x84d8 E6 70        |                   AND $70
0x84da CA 5C FF     |                   JP Z,$FF5C
0x84dd 69           |                   LD L,C
0x84de D3 45        |                   OUT ($45),A
0x84e0 78           |                   LD A,B
0x84e1 EE 54        |                   XOR $54
0x84e3 C2 61 F7     |                   JP NZ,$F761
0x84e6 4D           |                   LD C,L
0x84e7 DB 4A        |                   IN A,($4A)
0x84e9 DC 66 F0     |                   CALL C,$F066
0x84ec 53           |                   LD D,E
0x84ed C5           |                   PUSH BC
0x84ee 7F           |                   LD A,A
0x84ef E9           |                   JP (HL)
0x84f0 1C           |                   INC E
0x84f1 8A           |                   ADC A,D
0x84f2 30 A6        |                   JR NC,$A6
0x84f4 05           |                   DEC B
0x84f5 93           |                   SUB A,E
0x84f6 29           |                   ADD HL,HL
0x84f7 BF           |                   CP A
0x84f8 2E B8        |                   LD L,$B8
0x84fa 02           |                   LD (BC),A
0x84fb 94           |                   SUB A,H
0x84fc 37           |                   SCF
0x84fd A1           |                   AND C
0x84fe 1B           |                   DEC DE
0x84ff 8D           |                   ADC A,L
0x8500 00           |                   NOP
0x8501 30 61        |                   JR NC,$61
0x8503 51           |                   LD D,C
0x8504 C4 F4 A5     |                   CALL NZ,$A5F4
0x8507 95           |                   SUB A,L
0x8508 88           |                   ADC A,B
0x8509 B8           |                   CP B
0x850a E9           |                   JP (HL)
0x850b D9           |                   EXX
0x850c 4C           |                   LD C,H
0x850d 7C           |                   LD A,H
0x850e 2D           |                   DEC L
0x850f 1D           |                   DEC E
0x8510 10 20        |                   DJNZ $20
0x8512 71           |                   LD (HL),C
0x8513 41           |                   LD B,C
0x8514 D4 E4 B5     |                   CALL NC,$B5E4
0x8517 85           |                   AA,L
0x8518 98           |                   SBC A,B
0x8519 A8           |                   XOR B
0x851a F9           |                   LD SP,HL
0x851b C9           |                   RET
0x851c 5C           |                   LD E,H
0x851d 6C           |                   LD L,H
0x851e 3D           |                   DEC A
0x851f 0D           |                   DEC C
0x8520 20 10        |                   JR NZ,$10
0x8522 41           |                   LD B,C
0x8523 71           |                   LD (HL),C
0x8524 E4 D4 85     |                   CALL PO,$85D4
0x8527 B5           |                   OR L
0x8528 A8           |                   XOR B
0x8529 98           |                   SBC A,B
0x852a C9           |                   RET
0x852b F9           |                   LD SP,HL
0x852c 6C           |                   LD L,H
0x852d 5C           |                   LD E,H
0x852e 0D           |                   DEC C
0x852f 3D           |                   DEC A
0x8530 30 00        |                   JR NC,$00
0x8532 51           |                   LD D,C
0x8533 61           |                   LD H,C
0x8534 F4 C4 95     |                   CALL P,$95C4
0x8537 A5           |                   AND L
0x8538 B8           |                   CP B
0x8539 88           |                   ADC A,B
0x853a D9           |                   EXX
0x853b E9           |                   JP (HL)
0x853c 7C           |                   LD A,H
0x853d 4C           |                   LD C,H
0x853e 1D           |                   DEC E
0x853f 2D           |                   DEC L
0x8540 41           |                   LD B,C
0x8541 71           |                   LD (HL),C
0x8542 20 10        |                   JR NZ,$10
0x8544 85           |                   AA,L
0x8545 B5           |                   OR L
0x8546 E4 D4 C9     |                   CALL PO,$C9D4
0x8549 F9           |                   LD SP,HL
0x854a A8           |                   XOR B
0x854b 98           |                   SBC A,B
0x854c 0D           |                   DEC C
0x854d 3D           |                   DEC A
0x854e 6C           |                   LD L,H
0x854f 5C           |                   LD E,H
0x8550 51           |                   LD D,C
0x8551 61           |                   LD H,C
0x8552 30 00        |                   JR NC,$00
0x8554 95           |                   SUB A,L
0x8555 A5           |                   AND L
0x8556 F4 C4 D9     |                   CALL P,$D9C4
0x8559 E9           |                   JP (HL)
0x855a B8           |                   CP B
0x855b 88           |                   ADC A,B
0x855c 1D           |                   DEC E
0x855d 2D           |                   DEC L
0x855e 7C           |                   LD A,H
0x855f 4C           |                   LD C,H
0x8560 61           |                   LD H,C
0x8561 51           |                   LD D,C
0x8562 00           |                   NOP
0x8563 30 A5        |                   JR NC,$A5
0x8565 95           |                   SUB A,L
0x8566 C4 F4 E9     |                   CALL NZ,$E9F4
0x8569 D9           |                   EXX
0x856a 88           |                   ADC A,B
0x856b B8           |                   CP B
0x856c 2D           |                   DEC L
0x856d 1D           |                   DEC E
0x856e 4C           |                   LD C,H
0x856f 7C           |                   LD A,H
0x8570 71           |                   LD (HL),C
0x8571 41           |                   LD B,C
0x8572 10 20        |                   DJNZ $20
0x8574 B5           |                   OR L
0x8575 85           |                   AA,L
0x8576 D4 E4 F9     |                   CALL NC,$F9E4
0x8579 C9           |                   RET
0x857a 98           |                   SBC A,B
0x857b A8           |                   XOR B
0x857c 3D           |                   DEC A
0x857d 0D           |                   DEC C
0x857e 5C           |                   LD E,H
0x857f 6C           |                   LD L,H
0x8580 83           |                   AA,E
0x8581 B3           |                   OR E
0x8582 E2 D2 47     |                   JP PO,$47D2
0x8585 77           |                   LD (HL),A
0x8586 26 16        |                   LD H,$16
0x8588 0B           |                   DEC BC
0x8589 3B           |                   DEC SP
0x858a 6A           |                   LD L,D
0x858b 5A           |                   LD E,D
0x858c CF           |                   RST $08
0x858d FF           |                   RST $38
0x858e AE           |                   XOR (HL)
0x858f 9E           |                   SBC A,(HL)
0x8590 93           |                   SUB A,E
0x8591 A3           |                   AND E
0x8592 F2 C2 57     |                   JP P,$57C2
0x8595 67           |                   LD H,A
0x8596 36 06        |                   LD (HL),$06
0x8598 1B           |                   DEC DE
0x8599 2B           |                   DEC HL
0x859a 7A           |                   LD A,D
0x859b 4A           |                   LD C,D
0x859c DF           |                   RST $18
0x859d EF           |                   RST $28
0x859e BE           |                   CP (HL)
0x859f 8E           |                   ADC A,(HL)
0x85a0 A3           |                   AND E
0x85a1 93           |                   SUB A,E
0x85a2 C2 F2 67     |                   JP NZ,$67F2
0x85a5 57           |                   LD D,A
0x85a6 06 36        |                   LD B,$36
0x85a8 2B           |                   DEC HL
0x85a9 1B           |                   DEC DE
0x85aa 4A           |                   LD C,D
0x85ab 7A           |                   LD A,D
0x85ac EF           |                   RST $28
0x85ad DF           |                   RST $18
0x85ae 8E           |                   ADC A,(HL)
0x85af BE           |                   CP (HL)
0x85b0 B3           |                   OR E
0x85b1 83           |                   AA,E
0x85b2 D2 E2 77     |                   JP NC,$77E2
0x85b5 47           |                   LD B,A
0x85b6 16 26        |                   LD D,$26
0x85b8 3B           |                   DEC SP
0x85b9 0B           |                   DEC BC
0x85ba 5A           |                   LD E,D
0x85bb 6A           |                   LD L,D
0x85bc FF           |                   RST $38
0x85bd CF           |                   RST $08
0x85be 9E           |                   SBC A,(HL)
0x85bf AE           |                   XOR (HL)
0x85c0 C2 F2 A3     |                   JP NZ,$A3F2
0x85c3 93           |                   SUB A,E
0x85c4 06 36        |                   LD B,$36
0x85c6 67           |                   LD H,A
0x85c7 57           |                   LD D,A
0x85c8 4A           |                   LD C,D
0x85c9 7A           |                   LD A,D
0x85ca 2B           |                   DEC HL
0x85cb 1B           |                   DEC DE
0x85cc 8E           |                   ADC A,(HL)
0x85cd BE           |                   CP (HL)
0x85ce EF           |                   RST $28
0x85cf DF           |                   RST $18
0x85d0 D2 E2 B3     |                   JP NC,$B3E2
0x85d3 83           |                   AA,E
0x85d4 16 26        |                   LD D,$26
0x85d6 77           |                   LD (HL),A
0x85d7 47           |                   LD B,A
0x85d8 5A           |                   LD E,D
0x85d9 6A           |                   LD L,D
0x85da 3B           |                   DEC SP
0x85db 0B           |                   DEC BC
0x85dc 9E           |                   SBC A,(HL)
0x85dd AE           |                   XOR (HL)
0x85de FF           |                   RST $38
0x85df CF           |                   RST $08
0x85e0 E2 D2 83     |                   JP PO,$83D2
0x85e3 B3           |                   OR E
0x85e4 26 16        |                   LD H,$16
0x85e6 47           |                   LD B,A
0x85e7 77           |                   LD (HL),A
0x85e8 6A           |                   LD L,D
0x85e9 5A           |                   LD E,D
0x85ea 0B           |                   DEC BC
0x85eb 3B           |                   DEC SP
0x85ec AE           |                   XOR (HL)
0x85ed 9E           |                   SBC A,(HL)
0x85ee CF           |                   RST $08
0x85ef FF           |                   RST $38
0x85f0 F2 C2 93     |                   JP P,$93C2
0x85f3 A3           |                   AND E
0x85f4 36 06        |                   LD (HL),$06
0x85f6 57           |                   LD D,A
0x85f7 67           |                   LD H,A
0x85f8 7A           |                   LD A,D
0x85f9 4A           |                   LD C,D
0x85fa 1B           |                   DEC DE
0x85fb 2B           |                   DEC HL
0x85fc BE           |                   CP (HL)
0x85fd 8E           |                   ADC A,(HL)
0x85fe DF           |                   RST $18
0x85ff EF           |                   RST $28
0x8600 00           |                   NOP
0x8601 07           |                   RLCA
0x8602 0E 09        |                   LD C,$09
0x8604 6D           |                   LD L,L
0x8605 6A           |                   LD L,D
0x8606 63           |                   LD H,E
0x8607 64           |                   LD H,H
0x8608 DB DC        |                   IN A,($DC)
0x860a D5           |                   PUSH DE
0x860b D2 B6 B1     |                   JP NC,$B1B6
0x860e B8           |                   CP B
0x860f BF           |                   CP A
0x8610 B7           |                   OR A
0x8611 B0           |                   OR B
0x8612 B9           |                   CP C
0x8613 BE           |                   CP (HL)
0x8614 DA DD D4     |                   JP C,$D4DD
0x8617 D3 6C        |                   OUT ($6C),A
0x8619 6B           |                   LD L,E
0x861a 62           |                   LD H,D
0x861b 65           |                   LD H,L
0x861c 01 06 0F     |                   LD BC,$0F06
0x861f 08           |                   EX AF,AF'
0x8620 6E           |                   LD L,(HL)
0x8621 69           |                   LD L,C
0x8622 60           |                   LD H,B
0x8623 67           |                   LD H,A
0x8624 03           |                   INC BC
0x8625 04           |                   INC B
0x8626 0D           |                   DEC C
0x8627 0A           |                   LD A,(BC)
0x8628 B5           |                   OR L
0x8629 B2           |                   OR D
0x862a BB           |                   CP E
0x862b BC           |                   CP H
0x862c D8           |                   RET C
0x862d DF           |                   RST $18
0x862e D6 D1        |                   SUB A,$D1
0x8630 D9           |                   EXX
0x8631 DE D7        |                   SBC A,$D7
0x8633 D0           |                   RET NC
0x8634 B4           |                   OR H
0x8635 B3           |                   OR E
0x8636 BA           |                   CP D
0x8637 BD           |                   CP L
0x8638 02           |                   LD (BC),A
0x8639 05           |                   DEC B
0x863a 0C           |                   INC C
0x863b 0B           |                   DEC BC
0x863c 6F           |                   LD L,A
0x863d 68           |                   LD L,B
0x863e 61           |                   LD H,C
0x863f 66           |                   LD H,(HL)
0x8640 DC DB D2     |                   CALL C,$D2DB
0x8643 D5           |                   PUSH DE
0x8644 B1           |                   OR C
0x8645 B6           |                   OR (HL)
0x8646 BF           |                   CP A
0x8647 B8           |                   CP B
0x8648 07           |                   RLCA
0x8649 00           |                   NOP
0x864a 09           |                   ADD HL,BC
0x864b 0E 6A        |                   LD C,$6A
0x864d 6D           |                   LD L,L
0x864e 64           |                   LD H,H
0x864f 63           |                   LD H,E
0x8650 6B           |                   LD L,E
0x8651 6C           |                   LD L,H
0x8652 65           |                   LD H,L
0x8653 62           |                   LD H,D
0x8654 06 01        |                   LD B,$01
0x8656 08           |                   EX AF,AF'
0x8657 0F           |                   RRCA
0x8658 B0           |                   OR B
0x8659 B7           |                   OR A
0x865a BE           |                   CP (HL)
0x865b B9           |                   CP C
0x865c DD           |                   *ILLEGAL*
0x865d DA D3 D4     |                   JP C,$D4D3
0x8660 B2           |                   OR D
0x8661 B5           |                   OR L
0x8662 BC           |                   CP H
0x8663 BB           |                   CP E
0x8664 DF           |                   RST $18
0x8665 D8           |                   RET C
0x8666 D1           |                   POP DE
0x8667 D6 69        |                   SUB A,$69
0x8669 6E           |                   LD L,(HL)
0x866a 67           |                   LD H,A
0x866b 60           |                   LD H,B
0x866c 04           |                   INC B
0x866d 03           |                   INC BC
0x866e 0A           |                   LD A,(BC)
0x866f 0D           |                   DEC C
0x8670 05           |                   DEC B
0x8671 02           |                   LD (BC),A
0x8672 0B           |                   DEC BC
0x8673 0C           |                   INC C
0x8674 68           |                   LD L,B
0x8675 6F           |                   LD L,A
0x8676 66           |                   LD H,(HL)
0x8677 61           |                   LD H,C
0x8678 DE D9        |                   SBC A,$D9
0x867a D0           |                   RET NC
0x867b D7           |                   RST $10
0x867c B3           |                   OR E
0x867d B4           |                   OR H
0x867e BD           |                   CP L
0x867f BA           |                   CP D
0x8680 B8           |                   CP B
0x8681 BF           |                   CP A
0x8682 B6           |                   OR (HL)
0x8683 B1           |                   OR C
0x8684 D5           |                   PUSH DE
0x8685 D2 DB DC     |                   JP NC,$DCDB
0x8688 63           |                   LD H,E
0x8689 64           |                   LD H,H
0x868a 6D           |                   LD L,L
0x868b 6A           |                   LD L,D
0x868c 0E 09        |                   LD C,$09
0x868e 00           |                   NOP
0x868f 07           |                   RLCA
0x8690 0F           |                   RRCA
0x8691 08           |                   EX AF,AF'
0x8692 01 06 62     |                   LD BC,$6206
0x8695 65           |                   LD H,L
0x8696 6C           |                   LD L,H
0x8697 6B           |                   LD L,E
0x8698 D4 D3 DA     |                   CALL NC,$DAD3
0x869b DD           |                   *ILLEGAL*
0x869c B9           |                   CP C
0x869d BE           |                   CP (HL)
0x869e B7           |                   OR A
0x869f B0           |                   OR B
0x86a0 D6 D1        |                   SUB A,$D1
0x86a2 D8           |                   RET C
0x86a3 DF           |                   RST $18
0x86a4 BB           |                   CP E
0x86a5 BC           |                   CP H
0x86a6 B5           |                   OR L
0x86a7 B2           |                   OR D
0x86a8 0D           |                   DEC C
0x86a9 0A           |                   LD A,(BC)
0x86aa 03           |                   INC BC
0x86ab 04           |                   INC B
0x86ac 60           |                   LD H,B
0x86ad 67           |                   LD H,A
0x86ae 6E           |                   LD L,(HL)
0x86af 69           |                   LD L,C
0x86b0 61           |                   LD H,C
0x86b1 66           |                   LD H,(HL)
0x86b2 6F           |                   LD L,A
0x86b3 68           |                   LD L,B
0x86b4 0C           |                   INC C
0x86b5 0B           |                   DEC BC
0x86b6 02           |                   LD (BC),A
0x86b7 05           |                   DEC B
0x86b8 BA           |                   CP D
0x86b9 BD           |                   CP L
0x86ba B4           |                   OR H
0x86bb B3           |                   OR E
0x86bc D7           |                   RST $10
0x86bd D0           |                   RET NC
0x86be D9           |                   EXX
0x86bf DE 64        |                   SBC A,$64
0x86c1 63           |                   LD H,E
0x86c2 6A           |                   LD L,D
0x86c3 6D           |                   LD L,L
0x86c4 09           |                   ADD HL,BC
0x86c5 0E 07        |                   LD C,$07
0x86c7 00           |                   NOP
0x86c8 BF           |                   CP A
0x86c9 B8           |                   CP B
0x86ca B1           |                   OR C
0x86cb B6           |                   OR (HL)
0x86cc D2 D5 DC     |                   JP NC,$DCD5
0x86cf DB D3        |                   IN A,($D3)
0x86d1 D4 DD DA     |                   CALL NC,$DADD
0x86d4 BE           |                   CP (HL)
0x86d5 B9           |                   CP C
0x86d6 B0           |                   OR B
0x86d7 B7           |                   OR A
0x86d8 08           |                   EX AF,AF'
0x86d9 0F           |                   RRCA
0x86da 06 01        |                   LD B,$01
0x86dc 65           |                   LD H,L
0x86dd 62           |                   LD H,D
0x86de 6B           |                   LD L,E
0x86df 6C           |                   LD L,H
0x86e0 0A           |                   LD A,(BC)
0x86e1 0D           |                   DEC C
0x86e2 04           |                   INC B
0x86e3 03           |                   INC BC
0x86e4 67           |                   LD H,A
0x86e5 60           |                   LD H,B
0x86e6 69           |                   LD L,C
0x86e7 6E           |                   LD L,(HL)
0x86e8 D1           |                   POP DE
0x86e9 D6 DF        |                   SUB A,$DF
0x86eb D8           |                   RET C
0x86ec BC           |                   CP H
0x86ed BB           |                   CP E
0x86ee B2           |                   OR D
0x86ef B5           |                   OR L
0x86f0 BD           |                   CP L
0x86f1 BA           |                   CP D
0x86f2 B3           |                   OR E
0x86f3 B4           |                   OR H
0x86f4 D0           |                   RET NC
0x86f5 D7           |                   RST $10
0x86f6 DE D9        |                   SBC A,$D9
0x86f8 66           |                   LD H,(HL)
0x86f9 61           |                   LD H,C
0x86fa 68           |                   LD L,B
0x86fb 6F           |                   LD L,A
0x86fc 0B           |                   DEC BC
0x86fd 0C           |                   INC C
0x86fe 05           |                   DEC B
0x86ff 02           |                   LD (BC),A
0x8700 00           |                   NOP
0x8701 77           |                   LD (HL),A
0x8702 EE 99        |                   XOR $99
0x8704 07           |                   RLCA
0x8705 70           |                   LD (HL),B
0x8706 E9           |                   JP (HL)
0x8707 9E           |                   SBC A,(HL)
0x8708 0E 79        |                   LD C,$79
0x870a E0           |                   RET PO
0x870b 97           |                   SUB A,A
0x870c 09           |                   ADD HL,BC
0x870d 7E           |                   LD A,(HL)
0x870e E7           |                   RST $20
0x870f 90           |                   SUB A,B
0x8710 1D           |                   DEC E
0x8711 6A           |                   LD L,D
0x8712 F3           |                   DI
0x8713 84           |                   AA,H
0x8714 1A           |                   LD A,(DE)
0x8715 6D           |                   LD L,L
0x8716 F4 83 13     |                   CALL P,$1383
0x8719 64           |                   LD H,H
0x871a FD           |                   *ILLEGAL*
0x871b 8A           |                   ADC A,D
0x871c 14           |                   INC D
0x871d 63           |                   LD H,E
0x871e FA 8D 3B     |                   JP M,$3B8D
0x8721 4C           |                   LD C,H
0x8722 D5           |                   PUSH DE
0x8723 A2           |                   AND D
0x8724 3C           |                   INC A
0x8725 4B           |                   LD C,E
0x8726 D2 A5 35     |                   JP NC,$35A5
0x8729 42           |                   LD B,D
0x872a DB AC        |                   IN A,($AC)
0x872c 32 45 DC     |                   LD ($DC45),A
0x872f AB           |                   XOR E
0x8730 26 51        |                   LD H,$51
0x8732 C8           |                   RET Z
0x8733 BF           |                   CP A
0x8734 21 56 CF     |                   LD HL,$CF56
0x8737 B8           |                   CP B
0x8738 28 5F        |                   JR Z,$5F
0x873a C6 B1        |                   ADD A,$B1
0x873c 2F           |                   CPL
0x873d 58           |                   LD E,B
0x873e C1           |                   POP BC
0x873f B6           |                   OR (HL)
0x8740 76           |                   HALT
0x8741 01 98 EF     |                   LD BC,$EF98
0x8744 71           |                   LD (HL),C
0x8745 06 9F        |                   LD B,$9F
0x8747 E8           |                   RET PE
0x8748 78           |                   LD A,B
0x8749 0F           |                   RRCA
0x874a 96           |                   SUB A,(HL)
0x874b E1           |                   POP HL
0x874c 7F           |                   LD A,A
0x874d 08           |                   EX AF,AF'
0x874e 91           |                   SUB A,C
0x874f E6 6B        |                   AND $6B
0x8751 1C           |                   INC E
0x8752 85           |                   AA,L
0x8753 F2 6C 1B     |                   JP P,$1B6C
0x8756 82           |                   AA,D
0x8757 F5           |                   PUSH AF
0x8758 65           |                   LD H,L
0x8759 12           |                   LD (DE),A
0x875a 8B           |                   ADC A,E
0x875b FC 62 15     |                   CALL M,$1562
0x875e 8C           |                   ADC A,H
0x875f FB           |                   EI
0x8760 4D           |                   LD C,L
0x8761 3A A3 D4     |                   LD A,($D4A3)
0x8764 4A           |                   LD C,D
0x8765 3D           |                   DEC A
0x8766 A4           |                   AND H
0x8767 D3 43        |                   OUT ($43),A
0x8769 34           |                   INC (HL)
0x876a AD           |                   XOR L
0x876b DA 44 33     |                   JP C,$3344
0x876e AA           |                   XOR D
0x876f DD           |                   *ILLEGAL*
0x8770 50           |                   LD D,B
0x8771 27           |                   DAA
0x8772 BE           |                   CP (HL)
0x8773 C9           |                   RET
0x8774 57           |                   LD D,A
0x8775 20 B9        |                   JR NZ,$B9
0x8777 CE 5E        |                   ADC A,$5E
0x8779 29           |                   ADD HL,HL
0x877a B0           |                   OR B
0x877b C7           |                   RST $00
0x877c 59           |                   LD E,C
0x877d 2E B7        |                   LD L,$B7
0x877f C0           |                   RET NZ
0x8780 ED           |                   *ILLEGAL*
0x8781 9A           |                   SBC A,D
0x8782 03           |                   INC BC
0x8783 74           |                   LD (HL),H
0x8784 EA 9D 04     |                   JP PE,$049D
0x8787 73           |                   LD (HL),E
0x8788 E3           |                   EX (SP),HL
0x8789 94           |                   SUB A,H
0x878a 0D           |                   DEC C
0x878b 7A           |                   LD A,D
0x878c E4 93 0A     |                   CALL PO,$0A93
0x878f 7D           |                   LD A,L
0x8790 F0           |                   RET P
0x8791 87           |                   AA,A
0x8792 1E 69        |                   LD E,$69
0x8794 F7           |                   RST $30
0x8795 80           |                   AA,B
0x8796 19           |                   ADD HL,DE
0x8797 6E           |                   LD L,(HL)
0x8798 FE 89        |                   CP $89
0x879a 10 67        |                   DJNZ $67
0x879c F9           |                   LD SP,HL
0x879d 8E           |                   ADC A,(HL)
0x879e 17           |                   RLA
0x879f 60           |                   LD H,B
0x87a0 D6 A1        |                   SUB A,$A1
0x87a2 38 4F        |                   JR C,$4F
0x87a4 D1           |                   POP DE
0x87a5 A6           |                   AND (HL)
0x87a6 3F           |                   CCF
0x87a7 48           |                   LD C,B
0x87a8 D8           |                   RET C
0x87a9 AF           |                   XOR A
0x87aa 36 41        |                   LD (HL),$41
0x87ac DF           |                   RST $18
0x87ad A8           |                   XOR B
0x87ae 31 46 CB     |                   LD SP,$CB46
0x87b1 BC           |                   CP H
0x87b2 25           |                   DEC H
0x87b3 52           |                   LD D,D
0x87b4 CC BB 22     |                   CALL Z,$22BB
0x87b7 55           |                   LD D,L
0x87b8 C5           |                   PUSH BC
0x87b9 B2           |                   OR D
0x87ba 2B           |                   DEC HL
0x87bb 5C           |                   LD E,H
0x87bc C2 B5 2C     |                   JP NZ,$2CB5
0x87bf 5B           |                   LD E,E
0x87c0 9B           |                   SBC A,E
0x87c1 EC 75 02     |                   CALL P,$0275
0x87c4 9C           |                   SBC A,H
0x87c5 EB           |                   EX DE,HL
0x87c6 72           |                   LD (HL),D
0x87c7 05           |                   DEC B
0x87c8 95           |                   SUB A,L
0x87c9 E2 7B 0C     |                   JP PO,$0C7B
0x87cc 92           |                   SUB A,D
0x87cd E5           |                   PUSH HL
0x87ce 7C           |                   LD A,H
0x87cf 0B           |                   DEC BC
0x87d0 86           |                   AA,(HL)
0x87d1 F1           |                   POP AF
0x87d2 68           |                   LD L,B
0x87d3 1F           |                   RRA
0x87d4 81           |                   AA,C
0x87d5 F6 6F        |                   OR $6F
0x87d7 18 88        |                   JR $88
0x87d9 FF           |                   RST $38
0x87da 66           |                   LD H,(HL)
0x87db 11 8F F8     |                   LD DE,$F88F
0x87de 61           |                   LD H,C
0x87df 16 A0        |                   LD D,$A0
0x87e1 D7           |                   RST $10
0x87e2 4E           |                   LD C,(HL)
0x87e3 39           |                   ADD HL,SP
0x87e4 A7           |                   AND A
0x87e5 D0           |                   RET NC
0x87e6 49           |                   LD C,C
0x87e7 3E AE        |                   LD A,$AE
0x87e9 D9           |                   EXX
0x87ea 40           |                   LD B,B
0x87eb 37           |                   SCF
0x87ec A9           |                   XOR C
0x87ed DE 47        |                   SBC A,$47
0x87ef 30 BD        |                   JR NC,$BD
0x87f1 CA 53 24     |                   JP Z,$2453
0x87f4 BA           |                   CP D
0x87f5 CD 54 23     |                   CALL $2354
0x87f8 B3           |                   OR E
0x87f9 C4 5D 2A     |                   CALL NZ,$2A5D
0x87fc B4           |                   OR H
0x87fd C3 5A 2D     |                   JP $2D5A
0x8800 00           |                   NOP
0x8801 00           |                   NOP
0x8802 00           |                   NOP
0x8803 00           |                   NOP
0x8804 00           |                   NOP
0x8805 00           |                   NOP
0x8806 00           |                   NOP
0x8807 00           |                   NOP
0x8808 00           |                   NOP
0x8809 00           |                   NOP
0x880a 00           |                   NOP
0x880b 00           |                   NOP
0x880c 00           |                   NOP
0x880d 00           |                   NOP
0x880e 00           |                   NOP
0x880f 00           |                   NOP
0x8810 03           |                   INC BC
0x8811 C3 2F 83     |                   JP $832F
0x8814 00           |                   NOP
0x8815 00           |                   NOP
0x8816 00           |                   NOP
0x8817 00           |                   NOP
0x8818 00           |                   NOP
0x8819 00           |                   NOP
0x881a 00           |                   NOP
0x881b 00           |                   NOP
0x881c 00           |                   NOP
0x881d 00           |                   NOP
0x881e 00           |                   NOP
0x881f 00           |                   NOP
0x8820 00           |                   NOP
0x8821 00           |                   NOP
0x8822 00           |                   NOP
0x8823 00           |                   NOP
0x8824 00           |                   NOP
0x8825 00           |                   NOP
0x8826 00           |                   NOP
0x8827 00           |                   NOP
0x8828 00           |                   NOP
0x8829 00           |                   NOP
0x882a 00           |                   NOP
0x882b 00           |                   NOP
0x882c 00           |                   NOP
0x882d 00           |                   NOP
0x882e 00           |                   NOP
0x882f 00           |                   NOP
0x8830 00           |                   NOP
0x8831 00           |                   NOP
0x8832 00           |                   NOP
0x8833 00           |                   NOP
0x8834 00           |                   NOP
0x8835 00           |                   NOP
0x8836 00           |                   NOP
0x8837 00           |                   NOP
0x8838 00           |                   NOP
0x8839 00           |                   NOP
0x883a 00           |                   NOP
0x883b 00           |                   NOP
0x883c 00           |                   NOP
0x883d 00           |                   NOP
0x883e 00           |                   NOP
0x883f 00           |                   NOP
0x8840 00           |                   NOP
0x8841 00           |                   NOP
0x8842 00           |                   NOP
0x8843 00           |                   NOP
0x8844 00           |                   NOP
0x8845 00           |                   NOP
0x8846 00           |                   NOP
0x8847 00           |                   NOP
0x8848 00           |                   NOP
0x8849 00           |                   NOP
0x884a 00           |                   NOP
0x884b 00           |                   NOP
0x884c 00           |                   NOP
0x884d 00           |                   NOP
0x884e 00           |                   NOP
0x884f 00           |                   NOP
0x8850 00           |                   NOP
0x8851 00           |                   NOP
0x8852 00           |                   NOP
0x8853 00           |                   NOP
0x8854 00           |                   NOP
0x8855 00           |                   NOP
0x8856 00           |                   NOP
0x8857 00           |                   NOP
0x8858 00           |                   NOP
0x8859 00           |                   NOP
0x885a 00           |                   NOP
0x885b 00           |                   NOP
0x885c 00           |                   NOP
0x885d 00           |                   NOP
0x885e 00           |                   NOP
0x885f 00           |                   NOP
0x8860 00           |                   NOP
0x8861 00           |                   NOP
0x8862 00           |                   NOP
0x8863 00           |                   NOP
0x8864 00           |                   NOP
0x8865 00           |                   NOP
0x8866 00           |                   NOP
0x8867 00           |                   NOP
0x8868 00           |                   NOP
0x8869 00           |                   NOP
0x886a 00           |                   NOP
0x886b 00           |                   NOP
0x886c 00           |                   NOP
0x886d 00           |                   NOP
0x886e 00           |                   NOP
0x886f 00           |                   NOP
0x8870 00           |                   NOP
0x8871 00           |                   NOP
0x8872 00           |                   NOP
0x8873 00           |                   NOP
0x8874 00           |                   NOP
0x8875 00           |                   NOP
0x8876 00           |                   NOP
0x8877 00           |                   NOP
0x8878 00           |                   NOP
0x8879 00           |                   NOP
0x887a BC           |                   CP H
0x887b 89           |                   ADC A,C
0x887c 07           |                   RLCA
0x887d 8A           |                   ADC A,D
0x887e 4C           |                   LD C,H
0x887f 8A           |                   ADC A,D
0x8880 91           |                   SUB A,C
0x8881 8A           |                   ADC A,D
0x8882 DD           |                   *ILLEGAL*
0x8883 8A           |                   ADC A,D
0x8884 29           |                   ADD HL,HL
0x8885 8B           |                   ADC A,E
0x8886 74           |                   LD (HL),H
0x8887 8B           |                   ADC A,E
0x8888 BF           |                   CP A
0x8889 8B           |                   ADC A,E
0x888a 08           |                   EX AF,AF'
0x888b 8C           |                   ADC A,H
0x888c 51           |                   LD D,C
0x888d 8C           |                   ADC A,H
0x888e 96           |                   SUB A,(HL)
0x888f 8C           |                   ADC A,H
0x8890 DB 8C        |                   IN A,($8C)
0x8892 20 8D        |                   JR NZ,$8D
0x8894 66           |                   LD H,(HL)
0x8895 8D           |                   ADC A,L
0x8896 AF           |                   XOR A
0x8897 8D           |                   ADC A,L
0x8898 F8           |                   RET M
0x8899 8D           |                   ADC A,L
0x889a 41           |                   LD B,C
0x889b 8E           |                   ADC A,(HL)
0x889c 8A           |                   ADC A,D
0x889d 8E           |                   ADC A,(HL)
0x889e D1           |                   POP DE
0x889f 8E           |                   ADC A,(HL)
0x88a0 18 8F        |                   JR $8F
0x88a2 5E           |                   LD E,(HL)
0x88a3 8F           |                   ADC A,A
0x88a4 A4           |                   AND H
0x88a5 8F           |                   ADC A,A
0x88a6 ED           |                   *ILLEGAL*
0x88a7 8F           |                   ADC A,A
0x88a8 3A 90 87     |                   LD A,($8790)
0x88ab 90           |                   SUB A,B
0x88ac D4 90 20     |                   CALL NC,$2090
0x88af 91           |                   SUB A,C
0x88b0 6F           |                   LD L,A
0x88b1 91           |                   SUB A,C
0x88b2 BE           |                   CP (HL)
0x88b3 91           |                   SUB A,C
0x88b4 0A           |                   LD A,(BC)
0x88b5 92           |                   SUB A,D
0x88b6 50           |                   LD D,B
0x88b7 92           |                   SUB A,D
0x88b8 96           |                   SUB A,(HL)
0x88b9 92           |                   SUB A,D
0x88ba DB 92        |                   IN A,($92)
0x88bc 20 93        |                   JR NZ,$93
0x88be 65           |                   LD H,L
0x88bf 93           |                   SUB A,E
0x88c0 AA           |                   XOR D
0x88c1 93           |                   SUB A,E
0x88c2 F1           |                   POP AF
0x88c3 93           |                   SUB A,E
0x88c4 38 94        |                   JR C,$94
0x88c6 7E           |                   LD A,(HL)
0x88c7 94           |                   SUB A,H
0x88c8 C4 94 0B     |                   CALL NZ,$0B94
0x88cb 95           |                   SUB A,L
0x88cc 52           |                   LD D,D
0x88cd 95           |                   SUB A,L
0x88ce 9A           |                   SBC A,D
0x88cf 95           |                   SUB A,L
0x88d0 E1           |                   POP HL
0x88d1 95           |                   SUB A,L
0x88d2 2F           |                   CPL
0x88d3 96           |                   SUB A,(HL)
0x88d4 7D           |                   LD A,L
0x88d5 96           |                   SUB A,(HL)
0x88d6 CA 96 17     |                   JP Z,$1796
0x88d9 97           |                   SUB A,A
0x88da 65           |                   LD H,L
0x88db 97           |                   SUB A,A
0x88dc B3           |                   OR E
0x88dd 97           |                   SUB A,A
0x88de 02           |                   LD (BC),A
0x88df 98           |                   SBC A,B
0x88e0 50           |                   LD D,B
0x88e1 98           |                   SBC A,B
0x88e2 9A           |                   SBC A,D
0x88e3 98           |                   SBC A,B
0x88e4 E6 98        |                   AND $98
0x88e6 2D           |                   DEC L
0x88e7 99           |                   SBC A,C
0x88e8 74           |                   LD (HL),H
0x88e9 99           |                   SBC A,C
0x88ea C2 99 10     |                   JP NZ,$1099
0x88ed 9A           |                   SBC A,D
0x88ee 57           |                   LD D,A
0x88ef 9A           |                   SBC A,D
0x88f0 9E           |                   SBC A,(HL)
0x88f1 9A           |                   SBC A,D
0x88f2 E8           |                   RET PE
0x88f3 9A           |                   SBC A,D
0x88f4 32 9B 7A     |                   LD ($7A9B),A
0x88f7 9B           |                   SBC A,E
0x88f8 C2 9B 0A     |                   JP NZ,$0A9B
0x88fb 9C           |                   SBC A,H
0x88fc 52           |                   LD D,D
0x88fd 9C           |                   SBC A,H
0x88fe 9D           |                   SBC A,L
0x88ff 9C           |                   SBC A,H
0x8900 E8           |                   RET PE
0x8901 9C           |                   SBC A,H
0x8902 33           |                   INC SP
0x8903 9D           |                   SBC A,L
0x8904 7E           |                   LD A,(HL)
0x8905 9D           |                   SBC A,L
0x8906 C9           |                   RET
0x8907 9D           |                   SBC A,L
0x8908 12           |                   LD (DE),A
0x8909 9E           |                   SBC A,(HL)
0x890a 5E           |                   LD E,(HL)
0x890b 9E           |                   SBC A,(HL)
0x890c AE           |                   XOR (HL)
0x890d 9E           |                   SBC A,(HL)
0x890e FA 9E 48     |                   JP M,$489E
0x8911 9F           |                   SBC A,A
0x8912 91           |                   SUB A,C
0x8913 9F           |                   SBC A,A
0x8914 DD           |                   *ILLEGAL*
0x8915 9F           |                   SBC A,A
0x8916 2D           |                   DEC L
0x8917 A0           |                   AND B
0x8918 79           |                   LD A,C
0x8919 A0           |                   AND B
0x891a C7           |                   RST $00
0x891b A0           |                   AND B
0x891c 10 A1        |                   DJNZ $A1
0x891e 5C           |                   LD E,H
0x891f A1           |                   AND C
0x8920 AC           |                   XOR H
0x8921 A1           |                   AND C
0x8922 F8           |                   RET M
0x8923 A1           |                   AND C
0x8924 46           |                   LD B,(HL)
0x8925 A2           |                   AND D
0x8926 8B           |                   ADC A,E
0x8927 A2           |                   AND D
0x8928 D0           |                   RET NC
0x8929 A2           |                   AND D
0x892a 16 A3        |                   LD D,$A3
0x892c 5C           |                   LD E,H
0x892d A3           |                   AND E
0x892e A8           |                   XOR B
0x892f A3           |                   AND E
0x8930 F4 A3 39     |                   CALL P,$39A3
0x8933 A4           |                   AND H
0x8934 7E           |                   LD A,(HL)
0x8935 A4           |                   AND H
0x8936 C4 A4 0A     |                   CALL NZ,$0AA4
0x8939 A5           |                   AND L
0x893a 55           |                   LD D,L
0x893b A5           |                   AND L
0x893c A0           |                   AND B
0x893d A5           |                   AND L
0x893e E9           |                   JP (HL)
0x893f A5           |                   AND L
0x8940 2F           |                   CPL
0x8941 A6           |                   AND (HL)
0x8942 75           |                   LD (HL),L
0x8943 A6           |                   AND (HL)
0x8944 BC           |                   CP H
0x8945 A6           |                   AND (HL)
0x8946 03           |                   INC BC
0x8947 A7           |                   AND A
0x8948 50           |                   LD D,B
0x8949 A7           |                   AND A
0x894a 9D           |                   SBC A,L
0x894b A7           |                   AND A
0x894c E8           |                   RET PE
0x894d A7           |                   AND A
0x894e 33           |                   INC SP
0x894f A8           |                   XOR B
0x8950 7E           |                   LD A,(HL)
0x8951 A8           |                   XOR B
0x8952 C4 A8 0A     |                   CALL NZ,$0AA8
0x8955 A9           |                   XOR C
0x8956 50           |                   LD D,B
0x8957 A9           |                   XOR C
0x8958 96           |                   SUB A,(HL)
0x8959 A9           |                   XOR C
0x895a DD           |                   *ILLEGAL*
0x895b A9           |                   XOR C
0x895c 27           |                   DAA
0x895d AA           |                   XOR D
0x895e 70           |                   LD (HL),B
0x895f AA           |                   XOR D
0x8960 B9           |                   CP C
0x8961 AA           |                   XOR D
0x8962 FF           |                   RST $38
0x8963 AA           |                   XOR D
0x8964 48           |                   LD C,B
0x8965 AB           |                   XOR E
0x8966 90           |                   SUB A,B
0x8967 AB           |                   XOR E
0x8968 D9           |                   EXX
0x8969 AB           |                   XOR E
0x896a 25           |                   DEC H
0x896b AC           |                   XOR H
0x896c 6A           |                   LD L,D
0x896d AC           |                   XOR H
0x896e B2           |                   OR D
0x896f AC           |                   XOR H
0x8970 F8           |                   RET M
0x8971 AC           |                   XOR H
0x8972 3E AD        |                   LD A,$AD
0x8974 89           |                   ADC A,C
0x8975 AD           |                   XOR L
0x8976 D6 AD        |                   SUB A,$AD
0x8978 23           |                   INC HL
0x8979 AE           |                   XOR (HL)
0x897a 70           |                   LD (HL),B
0x897b AE           |                   XOR (HL)
0x897c BA           |                   CP D
0x897d AE           |                   XOR (HL)
0x897e 05           |                   DEC B
0x897f AF           |                   XOR A
0x8980 4A           |                   LD C,D
0x8981 AF           |                   XOR A
0x8982 96           |                   SUB A,(HL)
0x8983 AF           |                   XOR A
0x8984 E2 AF 38     |                   JP PO,$38AF
0x8987 B0           |                   OR B
0x8988 8E           |                   ADC A,(HL)
0x8989 B0           |                   OR B
0x898a D9           |                   EXX
0x898b B0           |                   OR B
0x898c 24           |                   INC H
0x898d B1           |                   OR C
0x898e 73           |                   LD (HL),E
0x898f B1           |                   OR C
0x8990 BB           |                   CP E
0x8991 B1           |                   OR C
0x8992 06 B2        |                   LD B,$B2
0x8994 56           |                   LD D,(HL)
0x8995 B2           |                   OR D
0x8996 A6           |                   AND (HL)
0x8997 B2           |                   OR D
0x8998 F1           |                   POP AF
0x8999 B2           |                   OR D
0x899a 3C           |                   INC A
0x899b B3           |                   OR E
0x899c 86           |                   AA,(HL)
0x899d B3           |                   OR E
0x899e D0           |                   RET NC
0x899f B3           |                   OR E
0x89a0 1C           |                   INC E
0x89a1 B4           |                   OR H
0x89a2 68           |                   LD L,B
0x89a3 B4           |                   OR H
0x89a4 B4           |                   OR H
0x89a5 B4           |                   OR H
0x89a6 00           |                   NOP
0x89a7 B5           |                   OR L
0x89a8 4C           |                   LD C,H
0x89a9 B5           |                   OR L
0x89aa 98           |                   SBC A,B
0x89ab B5           |                   OR L
0x89ac E2 B5 2C     |                   JP PO,$2CB5
0x89af B6           |                   OR (HL)
0x89b0 74           |                   LD (HL),H
0x89b1 B6           |                   OR (HL)
0x89b2 BC           |                   CP H
0x89b3 B6           |                   OR (HL)
0x89b4 04           |                   INC B
0x89b5 B7           |                   OR A
0x89b6 4C           |                   LD C,H
0x89b7 B7           |                   OR A
0x89b8 93           |                   SUB A,E
0x89b9 B7           |                   OR A
0x89ba 00           |                   NOP
0x89bb 00           |                   NOP
0x89bc FF           |                   RST $38
0x89bd 00           |                   NOP
0x89be 00           |                   NOP
0x89bf 00           |                   NOP
0x89c0 00           |                   NOP
0x89c1 FF           |                   RST $38
0x89c2 AA           |                   XOR D
0x89c3 CC BB EE     |                   CALL Z,$EEBB
0x89c6 DD           |                   *ILLEGAL*
0x89c7 11 44 88     |                   LD DE,$8844
0x89ca DD 77 FD     |                   LD (IX+$FD),A
0x89cd 34           |                   INC (HL)
0x89ce 12           |                   LD (DE),A
0x89cf 00           |                   NOP
0x89d0 C0           |                   RET NZ
0x89d1 00           |                   NOP
0x89d2 00           |                   NOP
0x89d3 00           |                   NOP
0x89d4 00           |                   NOP
0x89d5 20 00        |                   JR NZ,$00
0x89d7 00           |                   NOP
0x89d8 00           |                   NOP
0x89d9 00           |                   NOP
0x89da 00           |                   NOP
0x89db 00           |                   NOP
0x89dc 00           |                   NOP
0x89dd 00           |                   NOP
0x89de 00           |                   NOP
0x89df 00           |                   NOP
0x89e0 00           |                   NOP
0x89e1 00           |                   NOP
0x89e2 00           |                   NOP
0x89e3 00           |                   NOP
0x89e4 00           |                   NOP
0x89e5 00           |                   NOP
0x89e6 00           |                   NOP
0x89e7 00           |                   NOP
0x89e8 00           |                   NOP
0x89e9 08           |                   EX AF,AF'
0x89ea 00           |                   NOP
0x89eb 00           |                   NOP
0x89ec 00           |                   NOP
0x89ed 00           |                   NOP
0x89ee 00           |                   NOP
0x89ef 00           |                   NOP
0x89f0 00           |                   NOP
0x89f1 00           |                   NOP
0x89f2 00           |                   NOP
0x89f3 00           |                   NOP
0x89f4 00           |                   NOP
0x89f5 00           |                   NOP
0x89f6 00           |                   NOP
0x89f7 00           |                   NOP
0x89f8 00           |                   NOP
0x89f9 10 52        |                   DJNZ $52
0x89fb D0           |                   RET NC
0x89fc 99           |                   SBC A,C
0x89fd 53           |                   LD D,E
0x89fe 45           |                   LD B,L
0x89ff 4C           |                   LD C,H
0x8a00 46           |                   LD B,(HL)
0x8a01 20 54        |                   JR NZ,$54
0x8a03 45           |                   LD B,L
0x8a04 53           |                   LD D,E
0x8a05 54           |                   LD D,H
0x8a06 00           |                   NOP
0x8a07 FF           |                   RST $38
0x8a08 37           |                   SCF
0x8a09 00           |                   NOP
0x8a0a 00           |                   NOP
0x8a0b 00           |                   NOP
0x8a0c FF           |                   RST $38
0x8a0d AA           |                   XOR D
0x8a0e CC BB EE     |                   CALL Z,$EEBB
0x8a11 DD           |                   *ILLEGAL*
0x8a12 11 44 88     |                   LD DE,$8844
0x8a15 DD 77 FD     |                   LD (IX+$FD),A
0x8a18 34           |                   INC (HL)
0x8a19 12           |                   LD (DE),A
0x8a1a 00           |                   NOP
0x8a1b C0           |                   RET NZ
0x8a1c 00           |                   NOP
0x8a1d 00           |                   NOP
0x8a1e 00           |                   NOP
0x8a1f 00           |                   NOP
0x8a20 FF           |                   RST $38
0x8a21 28 00        |                   JR Z,$00
0x8a23 00           |                   NOP
0x8a24 00           |                   NOP
0x8a25 00           |                   NOP
0x8a26 00           |                   NOP
0x8a27 00           |                   NOP
0x8a28 00           |                   NOP
0x8a29 00           |                   NOP
0x8a2a 00           |                   NOP
0x8a2b 00           |                   NOP
0x8a2c 00           |                   NOP
0x8a2d 00           |                   NOP
0x8a2e 00           |                   NOP
0x8a2f 00           |                   NOP
0x8a30 00           |                   NOP
0x8a31 00           |                   NOP
0x8a32 00           |                   NOP
0x8a33 00           |                   NOP
0x8a34 00           |                   NOP
0x8a35 D7           |                   RST $10
0x8a36 00           |                   NOP
0x8a37 00           |                   NOP
0x8a38 00           |                   NOP
0x8a39 00           |                   NOP
0x8a3a 00           |                   NOP
0x8a3b 00           |                   NOP
0x8a3c 00           |                   NOP
0x8a3d 00           |                   NOP
0x8a3e 00           |                   NOP
0x8a3f 00           |                   NOP
0x8a40 00           |                   NOP
0x8a41 00           |                   NOP
0x8a42 00           |                   NOP
0x8a43 00           |                   NOP
0x8a44 D8           |                   RET C
0x8a45 41           |                   LD B,C
0x8a46 BD           |                   CP L
0x8a47 8A           |                   ADC A,D
0x8a48 53           |                   LD D,E
0x8a49 43           |                   LD B,E
0x8a4a 46           |                   LD B,(HL)
0x8a4b 00           |                   NOP
0x8a4c FF           |                   RST $38
0x8a4d 3F           |                   CCF
0x8a4e 00           |                   NOP
0x8a4f 00           |                   NOP
0x8a50 00           |                   NOP
0x8a51 FF           |                   RST $38
0x8a52 AA           |                   XOR D
0x8a53 CC BB EE     |                   CALL Z,$EEBB
0x8a56 DD           |                   *ILLEGAL*
0x8a57 11 44 88     |                   LD DE,$8844
0x8a5a DD 77 FD     |                   LD (IX+$FD),A
0x8a5d 34           |                   INC (HL)
0x8a5e 12           |                   LD (DE),A
0x8a5f 00           |                   NOP
0x8a60 C0           |                   RET NZ
0x8a61 00           |                   NOP
0x8a62 00           |                   NOP
0x8a63 00           |                   NOP
0x8a64 00           |                   NOP
0x8a65 FF           |                   RST $38
0x8a66 28 00        |                   JR Z,$00
0x8a68 00           |                   NOP
0x8a69 00           |                   NOP
0x8a6a 00           |                   NOP
0x8a6b 00           |                   NOP
0x8a6c 00           |                   NOP
0x8a6d 00           |                   NOP
0x8a6e 00           |                   NOP
0x8a6f 00           |                   NOP
0x8a70 00           |                   NOP
0x8a71 00           |                   NOP
0x8a72 00           |                   NOP
0x8a73 00           |                   NOP
0x8a74 00           |                   NOP
0x8a75 00           |                   NOP
0x8a76 00           |                   NOP
0x8a77 00           |                   NOP
0x8a78 00           |                   NOP
0x8a79 00           |                   NOP
0x8a7a D7           |                   RST $10
0x8a7b 00           |                   NOP
0x8a7c 00           |                   NOP
0x8a7d 00           |                   NOP
0x8a7e 00           |                   NOP
0x8a7f 00           |                   NOP
0x8a80 00           |                   NOP
0x8a81 00           |                   NOP
0x8a82 00           |                   NOP
0x8a83 00           |                   NOP
0x8a84 00           |                   NOP
0x8a85 00           |                   NOP
0x8a86 00           |                   NOP
0x8a87 00           |                   NOP
0x8a88 00           |                   NOP
0x8a89 3F           |                   CCF
0x8a8a BB           |                   CP E
0x8a8b 71           |                   LD (HL),C
0x8a8c DC 43 43     |                   CALL C,$4343
0x8a8f 46           |                   LD B,(HL)
0x8a90 00           |                   NOP
0x8a91 FF           |                   RST $38
0x8a92 37           |                   SCF
0x8a93 00           |                   NOP
0x8a94 00           |                   NOP
0x8a95 00           |                   NOP
0x8a96 FF           |                   RST $38
0x8a97 AA           |                   XOR D
0x8a98 CC BB EE     |                   CALL Z,$EEBB
0x8a9b DD           |                   *ILLEGAL*
0x8a9c 11 44 88     |                   LD DE,$8844
0x8a9f DD 77 FD     |                   LD (IX+$FD),A
0x8aa2 34           |                   INC (HL)
0x8aa3 12           |                   LD (DE),A
0x8aa4 00           |                   NOP
0x8aa5 C0           |                   RET NZ
0x8aa6 00           |                   NOP
0x8aa7 00           |                   NOP
0x8aa8 00           |                   NOP
0x8aa9 00           |                   NOP
0x8aaa FF           |                   RST $38
0x8aab 28 00        |                   JR Z,$00
0x8aad 00           |                   NOP
0x8aae 00           |                   NOP
0x8aaf 00           |                   NOP
0x8ab0 00           |                   NOP
0x8ab1 00           |                   NOP
0x8ab2 00           |                   NOP
0x8ab3 00           |                   NOP
0x8ab4 00           |                   NOP
0x8ab5 00           |                   NOP
0x8ab6 00           |                   NOP
0x8ab7 00           |                   NOP
0x8ab8 00           |                   NOP
0x8ab9 00           |                   NOP
0x8aba 00           |                   NOP
0x8abb 00           |                   NOP
0x8abc 00           |                   NOP
0x8abd 00           |                   NOP
0x8abe 00           |                   NOP
0x8abf D7           |                   RST $10
0x8ac0 00           |                   NOP
0x8ac1 00           |                   NOP
0x8ac2 00           |                   NOP
0x8ac3 00           |                   NOP
0x8ac4 00           |                   NOP
0x8ac5 00           |                   NOP
0x8ac6 00           |                   NOP
0x8ac7 00           |                   NOP
0x8ac8 00           |                   NOP
0x8ac9 00           |                   NOP
0x8aca 00           |                   NOP
0x8acb 00           |                   NOP
0x8acc 00           |                   NOP
0x8acd 00           |                   NOP
0x8ace 45           |                   LD B,L
0x8acf FC 79 B5     |                   CALL M,$B579
0x8ad2 53           |                   LD D,E
0x8ad3 43           |                   LD B,E
0x8ad4 46           |                   LD B,(HL)
0x8ad5 20 28        |                   JR NZ,$28
0x8ad7 4E           |                   LD C,(HL)
0x8ad8 45           |                   LD B,L
0x8ad9 43           |                   LD B,E
0x8ada 29           |                   ADD HL,HL
0x8adb 00           |                   NOP
0x8adc 00           |                   NOP
0x8add FF           |                   RST $38
0x8ade 3F           |                   CCF
0x8adf 00           |                   NOP
0x8ae0 00           |                   NOP
0x8ae1 00           |                   NOP
0x8ae2 FF           |                   RST $38
0x8ae3 AA           |                   XOR D
0x8ae4 CC BB EE     |                   CALL Z,$EEBB
0x8ae7 DD           |                   *ILLEGAL*
0x8ae8 11 44 88     |                   LD DE,$8844
0x8aeb DD 77 FD     |                   LD (IX+$FD),A
0x8aee 34           |                   INC (HL)
0x8aef 12           |                   LD (DE),A
0x8af0 00           |                   NOP
0x8af1 C0           |                   RET NZ
0x8af2 00           |                   NOP
0x8af3 00           |                   NOP
0x8af4 00           |                   NOP
0x8af5 00           |                   NOP
0x8af6 FF           |                   RST $38
0x8af7 28 00        |                   JR Z,$00
0x8af9 00           |                   NOP
0x8afa 00           |                   NOP
0x8afb 00           |                   NOP
0x8afc 00           |                   NOP
0x8afd 00           |                   NOP
0x8afe 00           |                   NOP
0x8aff 00           |                   NOP
0x8b00 00           |                   NOP
0x8b01 00           |                   NOP
0x8b02 00           |                   NOP
0x8b03 00           |                   NOP
0x8b04 00           |                   NOP
0x8b05 00           |                   NOP
0x8b06 00           |                   NOP
0x8b07 00           |                   NOP
0x8b08 00           |                   NOP
0x8b09 00           |                   NOP
0x8b0a 00           |                   NOP
0x8b0b D7           |                   RST $10
0x8b0c 00           |                   NOP
0x8b0d 00           |                   NOP
0x8b0e 00           |                   NOP
0x8b0f 00           |                   NOP
0x8b10 00           |                   NOP
0x8b11 00           |                   NOP
0x8b12 00           |                   NOP
0x8b13 00           |                   NOP
0x8b14 00           |                   NOP
0x8b15 00           |                   NOP
0x8b16 00           |                   NOP
0x8b17 00           |                   NOP
0x8b18 00           |                   NOP
0x8b19 00           |                   NOP
0x8b1a A2           |                   AND D
0x8b1b 06 B5        |                   LD B,$B5
0x8b1d E3           |                   EX (SP),HL
0x8b1e 43           |                   LD B,E
0x8b1f 43           |                   LD B,E
0x8b20 46           |                   LD B,(HL)
0x8b21 20 28        |                   JR NZ,$28
0x8b23 4E           |                   LD C,(HL)
0x8b24 45           |                   LD B,L
0x8b25 43           |                   LD B,E
0x8b26 29           |                   ADD HL,HL
0x8b27 00           |                   NOP
0x8b28 00           |                   NOP
0x8b29 FF           |                   RST $38
0x8b2a 37           |                   SCF
0x8b2b 00           |                   NOP
0x8b2c 00           |                   NOP
0x8b2d 00           |                   NOP
0x8b2e FF           |                   RST $38
0x8b2f AA           |                   XOR D
0x8b30 CC BB EE     |                   CALL Z,$EEBB
0x8b33 DD           |                   *ILLEGAL*
0x8b34 11 44 88     |                   LD DE,$8844
0x8b37 DD 77 FD     |                   LD (IX+$FD),A
0x8b3a 34           |                   INC (HL)
0x8b3b 12           |                   LD (DE),A
0x8b3c 00           |                   NOP
0x8b3d C0           |                   RET NZ
0x8b3e 00           |                   NOP
0x8b3f 00           |                   NOP
0x8b40 00           |                   NOP
0x8b41 00           |                   NOP
0x8b42 FF           |                   RST $38
0x8b43 28 00        |                   JR Z,$00
0x8b45 00           |                   NOP
0x8b46 00           |                   NOP
0x8b47 00           |                   NOP
0x8b48 00           |                   NOP
0x8b49 00           |                   NOP
0x8b4a 00           |                   NOP
0x8b4b 00           |                   NOP
0x8b4c 00           |                   NOP
0x8b4d 00           |                   NOP
0x8b4e 00           |                   NOP
0x8b4f 00           |                   NOP
0x8b50 00           |                   NOP
0x8b51 00           |                   NOP
0x8b52 00           |                   NOP
0x8b53 00           |                   NOP
0x8b54 00           |                   NOP
0x8b55 00           |                   NOP
0x8b56 00           |                   NOP
0x8b57 D7           |                   RST $10
0x8b58 00           |                   NOP
0x8b59 00           |                   NOP
0x8b5a 00           |                   NOP
0x8b5b 00           |                   NOP
0x8b5c 00           |                   NOP
0x8b5d 00           |                   NOP
0x8b5e 00           |                   NOP
0x8b5f 00           |                   NOP
0x8b60 00           |                   NOP
0x8b61 00           |                   NOP
0x8b62 00           |                   NOP
0x8b63 00           |                   NOP
0x8b64 00           |                   NOP
0x8b65 00           |                   NOP
0x8b66 58           |                   LD E,B
0x8b67 E9           |                   JP (HL)
0x8b68 50           |                   LD D,B
0x8b69 E4 53 43     |                   CALL PO,$4353
0x8b6c 46           |                   LD B,(HL)
0x8b6d 20 28        |                   JR NZ,$28
0x8b6f 53           |                   LD D,E
0x8b70 54           |                   LD D,H
0x8b71 29           |                   ADD HL,HL
0x8b72 00           |                   NOP
0x8b73 00           |                   NOP
0x8b74 FF           |                   RST $38
0x8b75 3F           |                   CCF
0x8b76 00           |                   NOP
0x8b77 00           |                   NOP
0x8b78 00           |                   NOP
0x8b79 FF           |                   RST $38
0x8b7a AA           |                   XOR D
0x8b7b CC BB EE     |                   CALL Z,$EEBB
0x8b7e DD           |                   *ILLEGAL*
0x8b7f 11 44 88     |                   LD DE,$8844
0x8b82 DD 77 FD     |                   LD (IX+$FD),A
0x8b85 34           |                   INC (HL)
0x8b86 12           |                   LD (DE),A
0x8b87 00           |                   NOP
0x8b88 C0           |                   RET NZ
0x8b89 00           |                   NOP
0x8b8a 00           |                   NOP
0x8b8b 00           |                   NOP
0x8b8c 00           |                   NOP
0x8b8d FF           |                   RST $38
0x8b8e 28 00        |                   JR Z,$00
0x8b90 00           |                   NOP
0x8b91 00           |                   NOP
0x8b92 00           |                   NOP
0x8b93 00           |                   NOP
0x8b94 00           |                   NOP
0x8b95 00           |                   NOP
0x8b96 00           |                   NOP
0x8b97 00           |                   NOP
0x8b98 00           |                   NOP
0x8b99 00           |                   NOP
0x8b9a 00           |                   NOP
0x8b9b 00           |                   NOP
0x8b9c 00           |                   NOP
0x8b9d 00           |                   NOP
0x8b9e 00           |                   NOP
0x8b9f 00           |                   NOP
0x8ba0 00           |                   NOP
0x8ba1 00           |                   NOP
0x8ba2 D7           |                   RST $10
0x8ba3 00           |                   NOP
0x8ba4 00           |                   NOP
0x8ba5 00           |                   NOP
0x8ba6 00           |                   NOP
0x8ba7 00           |                   NOP
0x8ba8 00           |                   NOP
0x8ba9 00           |                   NOP
0x8baa 00           |                   NOP
0x8bab 00           |                   NOP
0x8bac 00           |                   NOP
0x8bad 00           |                   NOP
0x8bae 00           |                   NOP
0x8baf 00           |                   NOP
0x8bb0 00           |                   NOP
0x8bb1 BF           |                   CP A
0x8bb2 13           |                   INC DE
0x8bb3 9C           |                   SBC A,H
0x8bb4 B2           |                   OR D
0x8bb5 43           |                   LD B,E
0x8bb6 43           |                   LD B,E
0x8bb7 46           |                   LD B,(HL)
0x8bb8 20 28        |                   JR NZ,$28
0x8bba 53           |                   LD D,E
0x8bbb 54           |                   LD D,H
0x8bbc 29           |                   ADD HL,HL
0x8bbd 00           |                   NOP
0x8bbe 00           |                   NOP
0x8bbf FF           |                   RST $38
0x8bc0 37           |                   SCF
0x8bc1 3F           |                   CCF
0x8bc2 00           |                   NOP
0x8bc3 00           |                   NOP
0x8bc4 FF           |                   RST $38
0x8bc5 AA           |                   XOR D
0x8bc6 CC BB EE     |                   CALL Z,$EEBB
0x8bc9 DD           |                   *ILLEGAL*
0x8bca 11 44 88     |                   LD DE,$8844
0x8bcd DD 77 FD     |                   LD (IX+$FD),A
0x8bd0 34           |                   INC (HL)
0x8bd1 12           |                   LD (DE),A
0x8bd2 00           |                   NOP
0x8bd3 C0           |                   RET NZ
0x8bd4 00           |                   NOP
0x8bd5 00           |                   NOP
0x8bd6 00           |                   NOP
0x8bd7 00           |                   NOP
0x8bd8 FF           |                   RST $38
0x8bd9 28 00        |                   JR Z,$00
0x8bdb 00           |                   NOP
0x8bdc 00           |                   NOP
0x8bdd 00           |                   NOP
0x8bde 00           |                   NOP
0x8bdf 00           |                   NOP
0x8be0 00           |                   NOP
0x8be1 00           |                   NOP
0x8be2 00           |                   NOP
0x8be3 00           |                   NOP
0x8be4 00           |                   NOP
0x8be5 00           |                   NOP
0x8be6 00           |                   NOP
0x8be7 00           |                   NOP
0x8be8 00           |                   NOP
0x8be9 00           |                   NOP
0x8bea 00           |                   NOP
0x8beb 00           |                   NOP
0x8bec 00           |                   NOP
0x8bed D7           |                   RST $10
0x8bee 00           |                   NOP
0x8bef 00           |                   NOP
0x8bf0 00           |                   NOP
0x8bf1 00           |                   NOP
0x8bf2 00           |                   NOP
0x8bf3 00           |                   NOP
0x8bf4 00           |                   NOP
0x8bf5 00           |                   NOP
0x8bf6 00           |                   NOP
0x8bf7 00           |                   NOP
0x8bf8 00           |                   NOP
0x8bf9 00           |                   NOP
0x8bfa 00           |                   NOP
0x8bfb 00           |                   NOP
0x8bfc 90           |                   SUB A,B
0x8bfd 86           |                   AA,(HL)
0x8bfe 49           |                   LD C,C
0x8bff 6C           |                   LD L,H
0x8c00 53           |                   LD D,E
0x8c01 43           |                   LD B,E
0x8c02 46           |                   LD B,(HL)
0x8c03 2B           |                   DEC HL
0x8c04 43           |                   LD B,E
0x8c05 43           |                   LD B,E
0x8c06 46           |                   LD B,(HL)
0x8c07 00           |                   NOP
0x8c08 FF           |                   RST $38
0x8c09 3F           |                   CCF
0x8c0a 37           |                   SCF
0x8c0b 00           |                   NOP
0x8c0c 00           |                   NOP
0x8c0d FF           |                   RST $38
0x8c0e AA           |                   XOR D
0x8c0f CC BB EE     |                   CALL Z,$EEBB
0x8c12 DD           |                   *ILLEGAL*
0x8c13 11 44 88     |                   LD DE,$8844
0x8c16 DD 77 FD     |                   LD (IX+$FD),A
0x8c19 34           |                   INC (HL)
0x8c1a 12           |                   LD (DE),A
0x8c1b 00           |                   NOP
0x8c1c C0           |                   RET NZ
0x8c1d 00           |                   NOP
0x8c1e 00           |                   NOP
0x8c1f 00           |                   NOP
0x8c20 00           |                   NOP
0x8c21 FF           |                   RST $38
0x8c22 28 00        |                   JR Z,$00
0x8c24 00           |                   NOP
0x8c25 00           |                   NOP
0x8c26 00           |                   NOP
0x8c27 00           |                   NOP
0x8c28 00           |                   NOP
0x8c29 00           |                   NOP
0x8c2a 00           |                   NOP
0x8c2b 00           |                   NOP
0x8c2c 00           |                   NOP
0x8c2d 00           |                   NOP
0x8c2e 00           |                   NOP
0x8c2f 00           |                   NOP
0x8c30 00           |                   NOP
0x8c31 00           |                   NOP
0x8c32 00           |                   NOP
0x8c33 00           |                   NOP
0x8c34 00           |                   NOP
0x8c35 00           |                   NOP
0x8c36 D7           |                   RST $10
0x8c37 00           |                   NOP
0x8c38 00           |                   NOP
0x8c39 00           |                   NOP
0x8c3a 00           |                   NOP
0x8c3b 00           |                   NOP
0x8c3c 00           |                   NOP
0x8c3d 00           |                   NOP
0x8c3e 00           |                   NOP
0x8c3f 00           |                   NOP
0x8c40 00           |                   NOP
0x8c41 00           |                   NOP
0x8c42 00           |                   NOP
0x8c43 00           |                   NOP
0x8c44 00           |                   NOP
0x8c45 45           |                   LD B,L
0x8c46 FC 79 B5     |                   CALL M,$B579
0x8c49 43           |                   LD B,E
0x8c4a 43           |                   LD B,E
0x8c4b 46           |                   LD B,(HL)
0x8c4c 2B           |                   DEC HL
0x8c4d 53           |                   LD D,E
0x8c4e 43           |                   LD B,E
0x8c4f 46           |                   LD B,(HL)
0x8c50 00           |                   NOP
0x8c51 FF           |                   RST $38
0x8c52 27           |                   DAA
0x8c53 00           |                   NOP
0x8c54 00           |                   NOP
0x8c55 00           |                   NOP
0x8c56 FF           |                   RST $38
0x8c57 AA           |                   XOR D
0x8c58 CC BB EE     |                   CALL Z,$EEBB
0x8c5b DD           |                   *ILLEGAL*
0x8c5c 11 44 88     |                   LD DE,$8844
0x8c5f DD 77 FD     |                   LD (IX+$FD),A
0x8c62 34           |                   INC (HL)
0x8c63 12           |                   LD (DE),A
0x8c64 00           |                   NOP
0x8c65 C0           |                   RET NZ
0x8c66 00           |                   NOP
0x8c67 00           |                   NOP
0x8c68 00           |                   NOP
0x8c69 00           |                   NOP
0x8c6a 13           |                   INC DE
0x8c6b FF           |                   RST $38
0x8c6c 00           |                   NOP
0x8c6d 00           |                   NOP
0x8c6e 00           |                   NOP
0x8c6f 00           |                   NOP
0x8c70 00           |                   NOP
0x8c71 00           |                   NOP
0x8c72 00           |                   NOP
0x8c73 00           |                   NOP
0x8c74 00           |                   NOP
0x8c75 00           |                   NOP
0x8c76 00           |                   NOP
0x8c77 00           |                   NOP
0x8c78 00           |                   NOP
0x8c79 00           |                   NOP
0x8c7a 00           |                   NOP
0x8c7b 00           |                   NOP
0x8c7c 00           |                   NOP
0x8c7d 00           |                   NOP
0x8c7e EC 00 00     |                   CALL P,$0000
0x8c81 00           |                   NOP
0x8c82 00           |                   NOP
0x8c83 00           |                   NOP
0x8c84 00           |                   NOP
0x8c85 00           |                   NOP
0x8c86 00           |                   NOP
0x8c87 00           |                   NOP
0x8c88 00           |                   NOP
0x8c89 00           |                   NOP
0x8c8a 00           |                   NOP
0x8c8b 00           |                   NOP
0x8c8c 00           |                   NOP
0x8c8d 00           |                   NOP
0x8c8e E9           |                   JP (HL)
0x8c8f 94           |                   SUB A,H
0x8c90 C6 C4        |                   ADD A,$C4
0x8c92 44           |                   LD B,H
0x8c93 41           |                   LD B,C
0x8c94 41           |                   LD B,C
0x8c95 00           |                   NOP
0x8c96 FF           |                   RST $38
0x8c97 2F           |                   CPL
0x8c98 00           |                   NOP
0x8c99 00           |                   NOP
0x8c9a 00           |                   NOP
0x8c9b FF           |                   RST $38
0x8c9c AA           |                   XOR D
0x8c9d CC BB EE     |                   CALL Z,$EEBB
0x8ca0 DD           |                   *ILLEGAL*
0x8ca1 11 44 88     |                   LD DE,$8844
0x8ca4 DD 77 FD     |                   LD (IX+$FD),A
0x8ca7 34           |                   INC (HL)
0x8ca8 12           |                   LD (DE),A
0x8ca9 00           |                   NOP
0x8caa C0           |                   RET NZ
0x8cab 00           |                   NOP
0x8cac 00           |                   NOP
0x8cad 00           |                   NOP
0x8cae 00           |                   NOP
0x8caf 00           |                   NOP
0x8cb0 FF           |                   RST $38
0x8cb1 00           |                   NOP
0x8cb2 00           |                   NOP
0x8cb3 00           |                   NOP
0x8cb4 00           |                   NOP
0x8cb5 00           |                   NOP
0x8cb6 00           |                   NOP
0x8cb7 00           |                   NOP
0x8cb8 00           |                   NOP
0x8cb9 00           |                   NOP
0x8cba 00           |                   NOP
0x8cbb 00           |                   NOP
0x8cbc 00           |                   NOP
0x8cbd 00           |                   NOP
0x8cbe 00           |                   NOP
0x8cbf 00           |                   NOP
0x8cc0 00           |                   NOP
0x8cc1 00           |                   NOP
0x8cc2 00           |                   NOP
0x8cc3 FF           |                   RST $38
0x8cc4 00           |                   NOP
0x8cc5 00           |                   NOP
0x8cc6 00           |                   NOP
0x8cc7 00           |                   NOP
0x8cc8 00           |                   NOP
0x8cc9 00           |                   NOP
0x8cca 00           |                   NOP
0x8ccb 00           |                   NOP
0x8ccc 00           |                   NOP
0x8ccd 00           |                   NOP
0x8cce 00           |                   NOP
0x8ccf 00           |                   NOP
0x8cd0 00           |                   NOP
0x8cd1 00           |                   NOP
0x8cd2 00           |                   NOP
0x8cd3 E3           |                   EX (SP),HL
0x8cd4 99           |                   SBC A,C
0x8cd5 27           |                   DAA
0x8cd6 D0           |                   RET NC
0x8cd7 43           |                   LD B,E
0x8cd8 50           |                   LD D,B
0x8cd9 4C           |                   LD C,H
0x8cda 00           |                   NOP
0x8cdb FF           |                   RST $38
0x8cdc ED 44        |                   NEG
0x8cde 00           |                   NOP
0x8cdf 00           |                   NOP
0x8ce0 FF           |                   RST $38
0x8ce1 AA           |                   XOR D
0x8ce2 CC BB EE     |                   CALL Z,$EEBB
0x8ce5 DD           |                   *ILLEGAL*
0x8ce6 11 44 88     |                   LD DE,$8844
0x8ce9 DD 77 FD     |                   LD (IX+$FD),A
0x8cec 34           |                   INC (HL)
0x8ced 12           |                   LD (DE),A
0x8cee 00           |                   NOP
0x8cef C0           |                   RET NZ
0x8cf0 00           |                   NOP
0x8cf1 00           |                   NOP
0x8cf2 00           |                   NOP
0x8cf3 00           |                   NOP
0x8cf4 00           |                   NOP
0x8cf5 FF           |                   RST $38
0x8cf6 00           |                   NOP
0x8cf7 00           |                   NOP
0x8cf8 00           |                   NOP
0x8cf9 00           |                   NOP
0x8cfa 00           |                   NOP
0x8cfb 00           |                   NOP
0x8cfc 00           |                   NOP
0x8cfd 00           |                   NOP
0x8cfe 00           |                   NOP
0x8cff 00           |                   NOP
0x8d00 00           |                   NOP
0x8d01 00           |                   NOP
0x8d02 00           |                   NOP
0x8d03 00           |                   NOP
0x8d04 00           |                   NOP
0x8d05 00           |                   NOP
0x8d06 00           |                   NOP
0x8d07 00           |                   NOP
0x8d08 FF           |                   RST $38
0x8d09 00           |                   NOP
0x8d0a 00           |                   NOP
0x8d0b 00           |                   NOP
0x8d0c 00           |                   NOP
0x8d0d 00           |                   NOP
0x8d0e 00           |                   NOP
0x8d0f 00           |                   NOP
0x8d10 00           |                   NOP
0x8d11 00           |                   NOP
0x8d12 00           |                   NOP
0x8d13 00           |                   NOP
0x8d14 00           |                   NOP
0x8d15 00           |                   NOP
0x8d16 00           |                   NOP
0x8d17 00           |                   NOP
0x8d18 95           |                   SUB A,L
0x8d19 3A 76 50     |                   LD A,($5076)
0x8d1c 4E           |                   LD C,(HL)
0x8d1d 45           |                   LD B,L
0x8d1e 47           |                   LD B,A
0x8d1f 00           |                   NOP
0x8d20 FF           |                   RST $38
0x8d21 ED 44        |                   NEG
0x8d23 00           |                   NOP
0x8d24 00           |                   NOP
0x8d25 FF           |                   RST $38
0x8d26 AA           |                   XOR D
0x8d27 CC BB EE     |                   CALL Z,$EEBB
0x8d2a DD           |                   *ILLEGAL*
0x8d2b 11 44 88     |                   LD DE,$8844
0x8d2e DD 77 FD     |                   LD (IX+$FD),A
0x8d31 34           |                   INC (HL)
0x8d32 12           |                   LD (DE),A
0x8d33 00           |                   NOP
0x8d34 C0           |                   RET NZ
0x8d35 00           |                   NOP
0x8d36 38 00        |                   JR C,$00
0x8d38 00           |                   NOP
0x8d39 00           |                   NOP
0x8d3a 00           |                   NOP
0x8d3b 00           |                   NOP
0x8d3c 00           |                   NOP
0x8d3d 00           |                   NOP
0x8d3e 00           |                   NOP
0x8d3f 00           |                   NOP
0x8d40 00           |                   NOP
0x8d41 00           |                   NOP
0x8d42 00           |                   NOP
0x8d43 00           |                   NOP
0x8d44 00           |                   NOP
0x8d45 00           |                   NOP
0x8d46 00           |                   NOP
0x8d47 00           |                   NOP
0x8d48 00           |                   NOP
0x8d49 00           |                   NOP
0x8d4a 00           |                   NOP
0x8d4b 00           |                   NOP
0x8d4c 00           |                   NOP
0x8d4d FF           |                   RST $38
0x8d4e FF           |                   RST $38
0x8d4f 00           |                   NOP
0x8d50 00           |                   NOP
0x8d51 00           |                   NOP
0x8d52 00           |                   NOP
0x8d53 00           |                   NOP
0x8d54 00           |                   NOP
0x8d55 00           |                   NOP
0x8d56 00           |                   NOP
0x8d57 00           |                   NOP
0x8d58 00           |                   NOP
0x8d59 00           |                   NOP
0x8d5a 00           |                   NOP
0x8d5b 00           |                   NOP
0x8d5c 00           |                   NOP
0x8d5d F5           |                   PUSH AF
0x8d5e EE 4F        |                   XOR $4F
0x8d60 9E           |                   SBC A,(HL)
0x8d61 4E           |                   LD C,(HL)
0x8d62 45           |                   LD B,L
0x8d63 47           |                   LD B,A
0x8d64 27           |                   DAA
0x8d65 00           |                   NOP
0x8d66 FF           |                   RST $38
0x8d67 C6 00        |                   ADD A,$00
0x8d69 00           |                   NOP
0x8d6a 00           |                   NOP
0x8d6b FF           |                   RST $38
0x8d6c AA           |                   XOR D
0x8d6d CC BB EE     |                   CALL Z,$EEBB
0x8d70 DD           |                   *ILLEGAL*
0x8d71 11 44 88     |                   LD DE,$8844
0x8d74 DD 77 FD     |                   LD (IX+$FD),A
0x8d77 34           |                   INC (HL)
0x8d78 12           |                   LD (DE),A
0x8d79 00           |                   NOP
0x8d7a C0           |                   RET NZ
0x8d7b 00           |                   NOP
0x8d7c 00           |                   NOP
0x8d7d 00           |                   NOP
0x8d7e 00           |                   NOP
0x8d7f 00           |                   NOP
0x8d80 FF           |                   RST $38
0x8d81 00           |                   NOP
0x8d82 00           |                   NOP
0x8d83 00           |                   NOP
0x8d84 00           |                   NOP
0x8d85 00           |                   NOP
0x8d86 00           |                   NOP
0x8d87 00           |                   NOP
0x8d88 00           |                   NOP
0x8d89 00           |                   NOP
0x8d8a 00           |                   NOP
0x8d8b 00           |                   NOP
0x8d8c 00           |                   NOP
0x8d8d 00           |                   NOP
0x8d8e 00           |                   NOP
0x8d8f 00           |                   NOP
0x8d90 FF           |                   RST $38
0x8d91 00           |                   NOP
0x8d92 00           |                   NOP
0x8d93 FF           |                   RST $38
0x8d94 00           |                   NOP
0x8d95 00           |                   NOP
0x8d96 00           |                   NOP
0x8d97 00           |                   NOP
0x8d98 00           |                   NOP
0x8d99 00           |                   NOP
0x8d9a 00           |                   NOP
0x8d9b 00           |                   NOP
0x8d9c 00           |                   NOP
0x8d9d 00           |                   NOP
0x8d9e 00           |                   NOP
0x8d9f 00           |                   NOP
0x8da0 00           |                   NOP
0x8da1 00           |                   NOP
0x8da2 00           |                   NOP
0x8da3 E5           |                   PUSH HL
0x8da4 16 6F        |                   LD D,$6F
0x8da6 9D           |                   SBC A,L
0x8da7 41           |                   LD B,C
0x8da8 44           |                   LD B,H
0x8da9 44           |                   LD B,H
0x8daa 20 41        |                   JR NZ,$41
0x8dac 2C           |                   INC L
0x8dad 4E           |                   LD C,(HL)
0x8dae 00           |                   NOP
0x8daf FF           |                   RST $38
0x8db0 CE 00        |                   ADC A,$00
0x8db2 00           |                   NOP
0x8db3 00           |                   NOP
0x8db4 FF           |                   RST $38
0x8db5 AA           |                   XOR D
0x8db6 CC BB EE     |                   CALL Z,$EEBB
0x8db9 DD           |                   *ILLEGAL*
0x8dba 11 44 88     |                   LD DE,$8844
0x8dbd DD 77 FD     |                   LD (IX+$FD),A
0x8dc0 34           |                   INC (HL)
0x8dc1 12           |                   LD (DE),A
0x8dc2 00           |                   NOP
0x8dc3 C0           |                   RET NZ
0x8dc4 00           |                   NOP
0x8dc5 00           |                   NOP
0x8dc6 00           |                   NOP
0x8dc7 00           |                   NOP
0x8dc8 01 FF 00     |                   LD BC,$00FF
0x8dcb 00           |                   NOP
0x8dcc 00           |                   NOP
0x8dcd 00           |                   NOP
0x8dce 00           |                   NOP
0x8dcf 00           |                   NOP
0x8dd0 00           |                   NOP
0x8dd1 00           |                   NOP
0x8dd2 00           |                   NOP
0x8dd3 00           |                   NOP
0x8dd4 00           |                   NOP
0x8dd5 00           |                   NOP
0x8dd6 00           |                   NOP
0x8dd7 00           |                   NOP
0x8dd8 00           |                   NOP
0x8dd9 FF           |                   RST $38
0x8dda 00           |                   NOP
0x8ddb 00           |                   NOP
0x8ddc FE 00        |                   CP $00
0x8dde 00           |                   NOP
0x8ddf 00           |                   NOP
0x8de0 00           |                   NOP
0x8de1 00           |                   NOP
0x8de2 00           |                   NOP
0x8de3 00           |                   NOP
0x8de4 00           |                   NOP
0x8de5 00           |                   NOP
0x8de6 00           |                   NOP
0x8de7 00           |                   NOP
0x8de8 00           |                   NOP
0x8de9 00           |                   NOP
0x8dea 00           |                   NOP
0x8deb 00           |                   NOP
0x8dec 08           |                   EX AF,AF'
0x8ded BB           |                   CP E
0x8dee C9           |                   RET
0x8def 2B           |                   DEC HL
0x8df0 41           |                   LD B,C
0x8df1 44           |                   LD B,H
0x8df2 43           |                   LD B,E
0x8df3 20 41        |                   JR NZ,$41
0x8df5 2C           |                   INC L
0x8df6 4E           |                   LD C,(HL)
0x8df7 00           |                   NOP
0x8df8 FF           |                   RST $38
0x8df9 D6 00        |                   SUB A,$00
0x8dfb 00           |                   NOP
0x8dfc 00           |                   NOP
0x8dfd FF           |                   RST $38
0x8dfe AA           |                   XOR D
0x8dff CC BB EE     |                   CALL Z,$EEBB
0x8e02 DD           |                   *ILLEGAL*
0x8e03 11 44 88     |                   LD DE,$8844
0x8e06 DD 77 FD     |                   LD (IX+$FD),A
0x8e09 34           |                   INC (HL)
0x8e0a 12           |                   LD (DE),A
0x8e0b 00           |                   NOP
0x8e0c C0           |                   RET NZ
0x8e0d 00           |                   NOP
0x8e0e 00           |                   NOP
0x8e0f 00           |                   NOP
0x8e10 00           |                   NOP
0x8e11 00           |                   NOP
0x8e12 FF           |                   RST $38
0x8e13 00           |                   NOP
0x8e14 00           |                   NOP
0x8e15 00           |                   NOP
0x8e16 00           |                   NOP
0x8e17 00           |                   NOP
0x8e18 00           |                   NOP
0x8e19 00           |                   NOP
0x8e1a 00           |                   NOP
0x8e1b 00           |                   NOP
0x8e1c 00           |                   NOP
0x8e1d 00           |                   NOP
0x8e1e 00           |                   NOP
0x8e1f 00           |                   NOP
0x8e20 00           |                   NOP
0x8e21 00           |                   NOP
0x8e22 FF           |                   RST $38
0x8e23 00           |                   NOP
0x8e24 00           |                   NOP
0x8e25 FF           |                   RST $38
0x8e26 00           |                   NOP
0x8e27 00           |                   NOP
0x8e28 00           |                   NOP
0x8e29 00           |                   NOP
0x8e2a 00           |                   NOP
0x8e2b 00           |                   NOP
0x8e2c 00           |                   NOP
0x8e2d 00           |                   NOP
0x8e2e 00           |                   NOP
0x8e2f 00           |                   NOP
0x8e30 00           |                   NOP
0x8e31 00           |                   NOP
0x8e32 00           |                   NOP
0x8e33 00           |                   NOP
0x8e34 00           |                   NOP
0x8e35 7A           |                   LD A,D
0x8e36 32 A5 65     |                   LD ($65A5),A
0x8e39 53           |                   LD D,E
0x8e3a 55           |                   LD D,L
0x8e3b 42           |                   LD B,D
0x8e3c 20 41        |                   JR NZ,$41
0x8e3e 2C           |                   INC L
0x8e3f 4E           |                   LD C,(HL)
0x8e40 00           |                   NOP
0x8e41 FF           |                   RST $38
0x8e42 DE 00        |                   SBC A,$00
0x8e44 00           |                   NOP
0x8e45 00           |                   NOP
0x8e46 FF           |                   RST $38
0x8e47 AA           |                   XOR D
0x8e48 CC BB EE     |                   CALL Z,$EEBB
0x8e4b DD           |                   *ILLEGAL*
0x8e4c 11 44 88     |                   LD DE,$8844
0x8e4f DD 77 FD     |                   LD (IX+$FD),A
0x8e52 34           |                   INC (HL)
0x8e53 12           |                   LD (DE),A
0x8e54 00           |                   NOP
0x8e55 C0           |                   RET NZ
0x8e56 00           |                   NOP
0x8e57 00           |                   NOP
0x8e58 00           |                   NOP
0x8e59 00           |                   NOP
0x8e5a 01 FF 00     |                   LD BC,$00FF
0x8e5d 00           |                   NOP
0x8e5e 00           |                   NOP
0x8e5f 00           |                   NOP
0x8e60 00           |                   NOP
0x8e61 00           |                   NOP
0x8e62 00           |                   NOP
0x8e63 00           |                   NOP
0x8e64 00           |                   NOP
0x8e65 00           |                   NOP
0x8e66 00           |                   NOP
0x8e67 00           |                   NOP
0x8e68 00           |                   NOP
0x8e69 00           |                   NOP
0x8e6a 00           |                   NOP
0x8e6b FF           |                   RST $38
0x8e6c 00           |                   NOP
0x8e6d 00           |                   NOP
0x8e6e FE 00        |                   CP $00
0x8e70 00           |                   NOP
0x8e71 00           |                   NOP
0x8e72 00           |                   NOP
0x8e73 00           |                   NOP
0x8e74 00           |                   NOP
0x8e75 00           |                   NOP
0x8e76 00           |                   NOP
0x8e77 00           |                   NOP
0x8e78 00           |                   NOP
0x8e79 00           |                   NOP
0x8e7a 00           |                   NOP
0x8e7b 00           |                   NOP
0x8e7c 00           |                   NOP
0x8e7d 00           |                   NOP
0x8e7e 15           |                   DEC D
0x8e7f 15           |                   DEC D
0x8e80 8A           |                   ADC A,D
0x8e81 3A 53 42     |                   LD A,($4253)
0x8e84 43           |                   LD B,E
0x8e85 20 41        |                   JR NZ,$41
0x8e87 2C           |                   INC L
0x8e88 4E           |                   LD C,(HL)
0x8e89 00           |                   NOP
0x8e8a FF           |                   RST $38
0x8e8b E6 00        |                   AND $00
0x8e8d 00           |                   NOP
0x8e8e 00           |                   NOP
0x8e8f FF           |                   RST $38
0x8e90 AA           |                   XOR D
0x8e91 CC BB EE     |                   CALL Z,$EEBB
0x8e94 DD           |                   *ILLEGAL*
0x8e95 11 44 88     |                   LD DE,$8844
0x8e98 DD 77 FD     |                   LD (IX+$FD),A
0x8e9b 34           |                   INC (HL)
0x8e9c 12           |                   LD (DE),A
0x8e9d 00           |                   NOP
0x8e9e C0           |                   RET NZ
0x8e9f 00           |                   NOP
0x8ea0 00           |                   NOP
0x8ea1 00           |                   NOP
0x8ea2 00           |                   NOP
0x8ea3 00           |                   NOP
0x8ea4 FF           |                   RST $38
0x8ea5 00           |                   NOP
0x8ea6 00           |                   NOP
0x8ea7 00           |                   NOP
0x8ea8 00           |                   NOP
0x8ea9 00           |                   NOP
0x8eaa 00           |                   NOP
0x8eab 00           |                   NOP
0x8eac 00           |                   NOP
0x8ead 00           |                   NOP
0x8eae 00           |                   NOP
0x8eaf 00           |                   NOP
0x8eb0 00           |                   NOP
0x8eb1 00           |                   NOP
0x8eb2 00           |                   NOP
0x8eb3 00           |                   NOP
0x8eb4 FF           |                   RST $38
0x8eb5 00           |                   NOP
0x8eb6 00           |                   NOP
0x8eb7 FF           |                   RST $38
0x8eb8 00           |                   NOP
0x8eb9 00           |                   NOP
0x8eba 00           |                   NOP
0x8ebb 00           |                   NOP
0x8ebc 00           |                   NOP
0x8ebd 00           |                   NOP
0x8ebe 00           |                   NOP
0x8ebf 00           |                   NOP
0x8ec0 00           |                   NOP
0x8ec1 00           |                   NOP
0x8ec2 00           |                   NOP
0x8ec3 00           |                   NOP
0x8ec4 00           |                   NOP
0x8ec5 00           |                   NOP
0x8ec6 00           |                   NOP
0x8ec7 34           |                   INC (HL)
0x8ec8 4D           |                   LD C,L
0x8ec9 B4           |                   OR H
0x8eca 9A           |                   SBC A,D
0x8ecb 41           |                   LD B,C
0x8ecc 4E           |                   LD C,(HL)
0x8ecd 44           |                   LD B,H
0x8ece 20 4E        |                   JR NZ,$4E
0x8ed0 00           |                   NOP
0x8ed1 FF           |                   RST $38
0x8ed2 EE 00        |                   XOR $00
0x8ed4 00           |                   NOP
0x8ed5 00           |                   NOP
0x8ed6 FF           |                   RST $38
0x8ed7 AA           |                   XOR D
0x8ed8 CC BB EE     |                   CALL Z,$EEBB
0x8edb DD           |                   *ILLEGAL*
0x8edc 11 44 88     |                   LD DE,$8844
0x8edf DD 77 FD     |                   LD (IX+$FD),A
0x8ee2 34           |                   INC (HL)
0x8ee3 12           |                   LD (DE),A
0x8ee4 00           |                   NOP
0x8ee5 C0           |                   RET NZ
0x8ee6 00           |                   NOP
0x8ee7 00           |                   NOP
0x8ee8 00           |                   NOP
0x8ee9 00           |                   NOP
0x8eea 00           |                   NOP
0x8eeb FF           |                   RST $38
0x8eec 00           |                   NOP
0x8eed 00           |                   NOP
0x8eee 00           |                   NOP
0x8eef 00           |                   NOP
0x8ef0 00           |                   NOP
0x8ef1 00           |                   NOP
0x8ef2 00           |                   NOP
0x8ef3 00           |                   NOP
0x8ef4 00           |                   NOP
0x8ef5 00           |                   NOP
0x8ef6 00           |                   NOP
0x8ef7 00           |                   NOP
0x8ef8 00           |                   NOP
0x8ef9 00           |                   NOP
0x8efa 00           |                   NOP
0x8efb FF           |                   RST $38
0x8efc 00           |                   NOP
0x8efd 00           |                   NOP
0x8efe FF           |                   RST $38
0x8eff 00           |                   NOP
0x8f00 00           |                   NOP
0x8f01 00           |                   NOP
0x8f02 00           |                   NOP
0x8f03 00           |                   NOP
0x8f04 00           |                   NOP
0x8f05 00           |                   NOP
0x8f06 00           |                   NOP
0x8f07 00           |                   NOP
0x8f08 00           |                   NOP
0x8f09 00           |                   NOP
0x8f0a 00           |                   NOP
0x8f0b 00           |                   NOP
0x8f0c 00           |                   NOP
0x8f0d 00           |                   NOP
0x8f0e 0E 8A        |                   LD C,$8A
0x8f10 64           |                   LD H,H
0x8f11 F8           |                   RET M
0x8f12 58           |                   LD E,B
0x8f13 4F           |                   LD C,A
0x8f14 52           |                   LD D,D
0x8f15 20 4E        |                   JR NZ,$4E
0x8f17 00           |                   NOP
0x8f18 FF           |                   RST $38
0x8f19 F6 00        |                   OR $00
0x8f1b 00           |                   NOP
0x8f1c 00           |                   NOP
0x8f1d FF           |                   RST $38
0x8f1e AA           |                   XOR D
0x8f1f CC BB EE     |                   CALL Z,$EEBB
0x8f22 DD           |                   *ILLEGAL*
0x8f23 11 44 88     |                   LD DE,$8844
0x8f26 DD 77 FD     |                   LD (IX+$FD),A
0x8f29 34           |                   INC (HL)
0x8f2a 12           |                   LD (DE),A
0x8f2b 00           |                   NOP
0x8f2c C0           |                   RET NZ
0x8f2d 00           |                   NOP
0x8f2e 00           |                   NOP
0x8f2f 00           |                   NOP
0x8f30 00           |                   NOP
0x8f31 00           |                   NOP
0x8f32 FF           |                   RST $38
0x8f33 00           |                   NOP
0x8f34 00           |                   NOP
0x8f35 00           |                   NOP
0x8f36 00           |                   NOP
0x8f37 00           |                   NOP
0x8f38 00           |                   NOP
0x8f39 00           |                   NOP
0x8f3a 00           |                   NOP
0x8f3b 00           |                   NOP
0x8f3c 00           |                   NOP
0x8f3d 00           |                   NOP
0x8f3e 00           |                   NOP
0x8f3f 00           |                   NOP
0x8f40 00           |                   NOP
0x8f41 00           |                   NOP
0x8f42 FF           |                   RST $38
0x8f43 00           |                   NOP
0x8f44 00           |                   NOP
0x8f45 FF           |                   RST $38
0x8f46 00           |                   NOP
0x8f47 00           |                   NOP
0x8f48 00           |                   NOP
0x8f49 00           |                   NOP
0x8f4a 00           |                   NOP
0x8f4b 00           |                   NOP
0x8f4c 00           |                   NOP
0x8f4d 00           |                   NOP
0x8f4e 00           |                   NOP
0x8f4f 00           |                   NOP
0x8f50 00           |                   NOP
0x8f51 00           |                   NOP
0x8f52 00           |                   NOP
0x8f53 00           |                   NOP
0x8f54 00           |                   NOP
0x8f55 98           |                   SBC A,B
0x8f56 4E           |                   LD C,(HL)
0x8f57 7D           |                   LD A,L
0x8f58 2F           |                   CPL
0x8f59 4F           |                   LD C,A
0x8f5a 52           |                   LD D,D
0x8f5b 20 4E        |                   JR NZ,$4E
0x8f5d 00           |                   NOP
0x8f5e FF           |                   RST $38
0x8f5f FE 00        |                   CP $00
0x8f61 00           |                   NOP
0x8f62 00           |                   NOP
0x8f63 FF           |                   RST $38
0x8f64 AA           |                   XOR D
0x8f65 CC BB EE     |                   CALL Z,$EEBB
0x8f68 DD           |                   *ILLEGAL*
0x8f69 11 44 88     |                   LD DE,$8844
0x8f6c DD 77 FD     |                   LD (IX+$FD),A
0x8f6f 34           |                   INC (HL)
0x8f70 12           |                   LD (DE),A
0x8f71 00           |                   NOP
0x8f72 C0           |                   RET NZ
0x8f73 00           |                   NOP
0x8f74 00           |                   NOP
0x8f75 00           |                   NOP
0x8f76 00           |                   NOP
0x8f77 00           |                   NOP
0x8f78 FF           |                   RST $38
0x8f79 00           |                   NOP
0x8f7a 00           |                   NOP
0x8f7b 00           |                   NOP
0x8f7c 00           |                   NOP
0x8f7d 00           |                   NOP
0x8f7e 00           |                   NOP
0x8f7f 00           |                   NOP
0x8f80 00           |                   NOP
0x8f81 00           |                   NOP
0x8f82 00           |                   NOP
0x8f83 00           |                   NOP
0x8f84 00           |                   NOP
0x8f85 00           |                   NOP
0x8f86 00           |                   NOP
0x8f87 00           |                   NOP
0x8f88 FF           |                   RST $38
0x8f89 00           |                   NOP
0x8f8a 00           |                   NOP
0x8f8b FF           |                   RST $38
0x8f8c 00           |                   NOP
0x8f8d 00           |                   NOP
0x8f8e 00           |                   NOP
0x8f8f 00           |                   NOP
0x8f90 00           |                   NOP
0x8f91 00           |                   NOP
0x8f92 00           |                   NOP
0x8f93 00           |                   NOP
0x8f94 00           |                   NOP
0x8f95 00           |                   NOP
0x8f96 00           |                   NOP
0x8f97 00           |                   NOP
0x8f98 00           |                   NOP
0x8f99 00           |                   NOP
0x8f9a 00           |                   NOP
0x8f9b D7           |                   RST $10
0x8f9c 14           |                   INC D
0x8f9d 63           |                   LD H,E
0x8f9e 9B           |                   SBC A,E
0x8f9f 43           |                   LD B,E
0x8fa0 50           |                   LD D,B
0x8fa1 20 4E        |                   JR NZ,$4E
0x8fa3 00           |                   NOP
0x8fa4 FF           |                   RST $38
0x8fa5 87           |                   AA,A
0x8fa6 00           |                   NOP
0x8fa7 00           |                   NOP
0x8fa8 00           |                   NOP
0x8fa9 FF           |                   RST $38
0x8faa 00           |                   NOP
0x8fab CC BB EE     |                   CALL Z,$EEBB
0x8fae DD           |                   *ILLEGAL*
0x8faf 11 44 88     |                   LD DE,$8844
0x8fb2 DD 77 FD     |                   LD (IX+$FD),A
0x8fb5 34           |                   INC (HL)
0x8fb6 12           |                   LD (DE),A
0x8fb7 00           |                   NOP
0x8fb8 C0           |                   RET NZ
0x8fb9 38 00        |                   JR C,$00
0x8fbb 00           |                   NOP
0x8fbc 00           |                   NOP
0x8fbd 00           |                   NOP
0x8fbe FF           |                   RST $38
0x8fbf 00           |                   NOP
0x8fc0 00           |                   NOP
0x8fc1 00           |                   NOP
0x8fc2 00           |                   NOP
0x8fc3 00           |                   NOP
0x8fc4 00           |                   NOP
0x8fc5 00           |                   NOP
0x8fc6 00           |                   NOP
0x8fc7 00           |                   NOP
0x8fc8 00           |                   NOP
0x8fc9 00           |                   NOP
0x8fca 00           |                   NOP
0x8fcb 00           |                   NOP
0x8fcc 00           |                   NOP
0x8fcd 00           |                   NOP
0x8fce 00           |                   NOP
0x8fcf 00           |                   NOP
0x8fd0 00           |                   NOP
0x8fd1 FF           |                   RST $38
0x8fd2 00           |                   NOP
0x8fd3 00           |                   NOP
0x8fd4 00           |                   NOP
0x8fd5 00           |                   NOP
0x8fd6 00           |                   NOP
0x8fd7 00           |                   NOP
0x8fd8 00           |                   NOP
0x8fd9 00           |                   NOP
0x8fda 00           |                   NOP
0x8fdb 00           |                   NOP
0x8fdc 00           |                   NOP
0x8fdd 00           |                   NOP
0x8fde 00           |                   NOP
0x8fdf 00           |                   NOP
0x8fe0 00           |                   NOP
0x8fe1 81           |                   AA,C
0x8fe2 97           |                   SUB A,A
0x8fe3 40           |                   LD B,B
0x8fe4 DB 41        |                   IN A,($41)
0x8fe6 4C           |                   LD C,H
0x8fe7 4F           |                   LD C,A
0x8fe8 20 41        |                   JR NZ,$41
0x8fea 2C           |                   INC L
0x8feb 41           |                   LD B,C
0x8fec 00           |                   NOP
0x8fed FF           |                   RST $38
0x8fee 80           |                   AA,B
0x8fef 00           |                   NOP
0x8ff0 00           |                   NOP
0x8ff1 00           |                   NOP
0x8ff2 FF           |                   RST $38
0x8ff3 00           |                   NOP
0x8ff4 00           |                   NOP
0x8ff5 00           |                   NOP
0x8ff6 EE DD        |                   XOR $DD
0x8ff8 11 44 88     |                   LD DE,$8844
0x8ffb DD 77 FD     |                   LD (IX+$FD),A
0x8ffe 34           |                   INC (HL)
0x8fff 12           |                   LD (DE),A
0x9000 00           |                   NOP
0x9001 C0           |                   RET NZ
0x9002 39           |                   ADD HL,SP
0x9003 00           |                   NOP
0x9004 00           |                   NOP
0x9005 00           |                   NOP
0x9006 00           |                   NOP
0x9007 C8           |                   RET Z
0x9008 00           |                   NOP
0x9009 00           |                   NOP
0x900a 00           |                   NOP
0x900b 00           |                   NOP
0x900c 00           |                   NOP
0x900d 00           |                   NOP
0x900e 00           |                   NOP
0x900f 00           |                   NOP
0x9010 00           |                   NOP
0x9011 00           |                   NOP
0x9012 00           |                   NOP
0x9013 00           |                   NOP
0x9014 00           |                   NOP
0x9015 00           |                   NOP
0x9016 00           |                   NOP
0x9017 00           |                   NOP
0x9018 00           |                   NOP
0x9019 00           |                   NOP
0x901a FF           |                   RST $38
0x901b 37           |                   SCF
0x901c FF           |                   RST $38
0x901d FF           |                   RST $38
0x901e 00           |                   NOP
0x901f 00           |                   NOP
0x9020 00           |                   NOP
0x9021 00           |                   NOP
0x9022 00           |                   NOP
0x9023 00           |                   NOP
0x9024 00           |                   NOP
0x9025 00           |                   NOP
0x9026 00           |                   NOP
0x9027 00           |                   NOP
0x9028 00           |                   NOP
0x9029 00           |                   NOP
0x902a 3B           |                   DEC SP
0x902b 2D           |                   DEC L
0x902c 5D           |                   LD E,L
0x902d 84           |                   AA,H
0x902e 41           |                   LD B,C
0x902f 4C           |                   LD C,H
0x9030 4F           |                   LD C,A
0x9031 20 41        |                   JR NZ,$41
0x9033 2C           |                   INC L
0x9034 5B           |                   LD E,E
0x9035 42           |                   LD B,D
0x9036 2C           |                   INC L
0x9037 43           |                   LD B,E
0x9038 5D           |                   LD E,L
0x9039 00           |                   NOP
0x903a FF           |                   RST $38
0x903b 82           |                   AA,D
0x903c 00           |                   NOP
0x903d 00           |                   NOP
0x903e 00           |                   NOP
0x903f FF           |                   RST $38
0x9040 00           |                   NOP
0x9041 CC BB 00     |                   CALL Z,$00BB
0x9044 00           |                   NOP
0x9045 11 44 88     |                   LD DE,$8844
0x9048 DD 77 FD     |                   LD (IX+$FD),A
0x904b 34           |                   INC (HL)
0x904c 12           |                   LD (DE),A
0x904d 00           |                   NOP
0x904e C0           |                   RET NZ
0x904f 39           |                   ADD HL,SP
0x9050 00           |                   NOP
0x9051 00           |                   NOP
0x9052 00           |                   NOP
0x9053 00           |                   NOP
0x9054 C8           |                   RET Z
0x9055 00           |                   NOP
0x9056 00           |                   NOP
0x9057 00           |                   NOP
0x9058 00           |                   NOP
0x9059 00           |                   NOP
0x905a 00           |                   NOP
0x905b 00           |                   NOP
0x905c 00           |                   NOP
0x905d 00           |                   NOP
0x905e 00           |                   NOP
0x905f 00           |                   NOP
0x9060 00           |                   NOP
0x9061 00           |                   NOP
0x9062 00           |                   NOP
0x9063 00           |                   NOP
0x9064 00           |                   NOP
0x9065 00           |                   NOP
0x9066 00           |                   NOP
0x9067 FF           |                   RST $38
0x9068 37           |                   SCF
0x9069 00           |                   NOP
0x906a 00           |                   NOP
0x906b FF           |                   RST $38
0x906c FF           |                   RST $38
0x906d 00           |                   NOP
0x906e 00           |                   NOP
0x906f 00           |                   NOP
0x9070 00           |                   NOP
0x9071 00           |                   NOP
0x9072 00           |                   NOP
0x9073 00           |                   NOP
0x9074 00           |                   NOP
0x9075 00           |                   NOP
0x9076 00           |                   NOP
0x9077 48           |                   LD C,B
0x9078 BE           |                   CP (HL)
0x9079 C1           |                   POP BC
0x907a D5           |                   PUSH DE
0x907b 41           |                   LD B,C
0x907c 4C           |                   LD C,H
0x907d 4F           |                   LD C,A
0x907e 20 41        |                   JR NZ,$41
0x9080 2C           |                   INC L
0x9081 5B           |                   LD E,E
0x9082 44           |                   LD B,H
0x9083 2C           |                   INC L
0x9084 45           |                   LD B,L
0x9085 5D           |                   LD E,L
0x9086 00           |                   NOP
0x9087 FF           |                   RST $38
0x9088 84           |                   AA,H
0x9089 00           |                   NOP
0x908a 00           |                   NOP
0x908b 00           |                   NOP
0x908c FF           |                   RST $38
0x908d 00           |                   NOP
0x908e CC BB EE     |                   CALL Z,$EEBB
0x9091 DD           |                   *ILLEGAL*
0x9092 00           |                   NOP
0x9093 00           |                   NOP
0x9094 88           |                   ADC A,B
0x9095 DD 77 FD     |                   LD (IX+$FD),A
0x9098 34           |                   INC (HL)
0x9099 12           |                   LD (DE),A
0x909a 00           |                   NOP
0x909b C0           |                   RET NZ
0x909c 39           |                   ADD HL,SP
0x909d 00           |                   NOP
0x909e 00           |                   NOP
0x909f 00           |                   NOP
0x90a0 00           |                   NOP
0x90a1 C8           |                   RET Z
0x90a2 00           |                   NOP
0x90a3 00           |                   NOP
0x90a4 00           |                   NOP
0x90a5 00           |                   NOP
0x90a6 00           |                   NOP
0x90a7 00           |                   NOP
0x90a8 00           |                   NOP
0x90a9 00           |                   NOP
0x90aa 00           |                   NOP
0x90ab 00           |                   NOP
0x90ac 00           |                   NOP
0x90ad 00           |                   NOP
0x90ae 00           |                   NOP
0x90af 00           |                   NOP
0x90b0 00           |                   NOP
0x90b1 00           |                   NOP
0x90b2 00           |                   NOP
0x90b3 00           |                   NOP
0x90b4 FF           |                   RST $38
0x90b5 37           |                   SCF
0x90b6 00           |                   NOP
0x90b7 00           |                   NOP
0x90b8 00           |                   NOP
0x90b9 00           |                   NOP
0x90ba FF           |                   RST $38
0x90bb FF           |                   RST $38
0x90bc 00           |                   NOP
0x90bd 00           |                   NOP
0x90be 00           |                   NOP
0x90bf 00           |                   NOP
0x90c0 00           |                   NOP
0x90c1 00           |                   NOP
0x90c2 00           |                   NOP
0x90c3 00           |                   NOP
0x90c4 31 7A DA     |                   LD SP,$DA7A
0x90c7 1E 41        |                   LD E,$41
0x90c9 4C           |                   LD C,H
0x90ca 4F           |                   LD C,A
0x90cb 20 41        |                   JR NZ,$41
0x90cd 2C           |                   INC L
0x90ce 5B           |                   LD E,E
0x90cf 48           |                   LD C,B
0x90d0 2C           |                   INC L
0x90d1 4C           |                   LD C,H
0x90d2 5D           |                   LD E,L
0x90d3 00           |                   NOP
0x90d4 FF           |                   RST $38
0x90d5 86           |                   AA,(HL)
0x90d6 00           |                   NOP
0x90d7 00           |                   NOP
0x90d8 00           |                   NOP
0x90d9 FF           |                   RST $38
0x90da 00           |                   NOP
0x90db CC BB EE     |                   CALL Z,$EEBB
0x90de DD           |                   *ILLEGAL*
0x90df 0C           |                   INC C
0x90e0 88           |                   ADC A,B
0x90e1 88           |                   ADC A,B
0x90e2 DD 77 FD     |                   LD (IX+$FD),A
0x90e5 00           |                   NOP
0x90e6 12           |                   LD (DE),A
0x90e7 00           |                   NOP
0x90e8 C0           |                   RET NZ
0x90e9 38 00        |                   JR C,$00
0x90eb 00           |                   NOP
0x90ec 00           |                   NOP
0x90ed 00           |                   NOP
0x90ee C8           |                   RET Z
0x90ef 00           |                   NOP
0x90f0 00           |                   NOP
0x90f1 00           |                   NOP
0x90f2 00           |                   NOP
0x90f3 00           |                   NOP
0x90f4 00           |                   NOP
0x90f5 00           |                   NOP
0x90f6 00           |                   NOP
0x90f7 00           |                   NOP
0x90f8 00           |                   NOP
0x90f9 00           |                   NOP
0x90fa 00           |                   NOP
0x90fb 00           |                   NOP
0x90fc 00           |                   NOP
0x90fd 00           |                   NOP
0x90fe 00           |                   NOP
0x90ff 00           |                   NOP
0x9100 00           |                   NOP
0x9101 FF           |                   RST $38
0x9102 37           |                   SCF
0x9103 00           |                   NOP
0x9104 00           |                   NOP
0x9105 00           |                   NOP
0x9106 00           |                   NOP
0x9107 01 00 00     |                   LD BC,$0000
0x910a 00           |                   NOP
0x910b 00           |                   NOP
0x910c 00           |                   NOP
0x910d FF           |                   RST $38
0x910e 00           |                   NOP
0x910f 00           |                   NOP
0x9110 00           |                   NOP
0x9111 D6 DA        |                   SUB A,$DA
0x9113 14           |                   INC D
0x9114 B8           |                   CP B
0x9115 41           |                   LD B,C
0x9116 4C           |                   LD C,H
0x9117 4F           |                   LD C,A
0x9118 20 41        |                   JR NZ,$41
0x911a 2C           |                   INC L
0x911b 28 48        |                   JR Z,$48
0x911d 4C           |                   LD C,H
0x911e 29           |                   ADD HL,HL
0x911f 00           |                   NOP
0x9120 FF           |                   RST $38
0x9121 DD 84        |                   ADD A,IXH
0x9123 00           |                   NOP
0x9124 00           |                   NOP
0x9125 FF           |                   RST $38
0x9126 00           |                   NOP
0x9127 CC BB EE     |                   CALL Z,$EEBB
0x912a DD           |                   *ILLEGAL*
0x912b 11 44 00     |                   LD DE,$0044
0x912e 00           |                   NOP
0x912f 77           |                   LD (HL),A
0x9130 FD 34 12     |                   INC (IY+$12)
0x9133 00           |                   NOP
0x9134 C0           |                   RET NZ
0x9135 00           |                   NOP
0x9136 39           |                   ADD HL,SP
0x9137 00           |                   NOP
0x9138 00           |                   NOP
0x9139 00           |                   NOP
0x913a C8           |                   RET Z
0x913b 00           |                   NOP
0x913c 00           |                   NOP
0x913d 00           |                   NOP
0x913e 00           |                   NOP
0x913f 00           |                   NOP
0x9140 00           |                   NOP
0x9141 00           |                   NOP
0x9142 00           |                   NOP
0x9143 00           |                   NOP
0x9144 00           |                   NOP
0x9145 00           |                   NOP
0x9146 00           |                   NOP
0x9147 00           |                   NOP
0x9148 00           |                   NOP
0x9149 00           |                   NOP
0x914a 00           |                   NOP
0x914b 00           |                   NOP
0x914c 00           |                   NOP
0x914d FF           |                   RST $38
0x914e 37           |                   SCF
0x914f 00           |                   NOP
0x9150 00           |                   NOP
0x9151 00           |                   NOP
0x9152 00           |                   NOP
0x9153 00           |                   NOP
0x9154 00           |                   NOP
0x9155 FF           |                   RST $38
0x9156 FF           |                   RST $38
0x9157 00           |                   NOP
0x9158 00           |                   NOP
0x9159 00           |                   NOP
0x915a 00           |                   NOP
0x915b 00           |                   NOP
0x915c 00           |                   NOP
0x915d 0F           |                   RRCA
0x915e E8           |                   RET PE
0x915f 3F           |                   CCF
0x9160 FA 41 4C     |                   JP M,$4C41
0x9163 4F           |                   LD C,A
0x9164 20 41        |                   JR NZ,$41
0x9166 2C           |                   INC L
0x9167 5B           |                   LD E,E
0x9168 48           |                   LD C,B
0x9169 58           |                   LD E,B
0x916a 2C           |                   INC L
0x916b 4C           |                   LD C,H
0x916c 58           |                   LD E,B
0x916d 5D           |                   LD E,L
0x916e 00           |                   NOP
0x916f FF           |                   RST $38
0x9170 FD 84        |                   ADD A,IYH
0x9172 00           |                   NOP
0x9173 00           |                   NOP
0x9174 FF           |                   RST $38
0x9175 00           |                   NOP
0x9176 CC BB EE     |                   CALL Z,$EEBB
0x9179 DD           |                   *ILLEGAL*
0x917a 11 44 88     |                   LD DE,$8844
0x917d DD           |                   *ILLEGAL*
0x917e 00           |                   NOP
0x917f 00           |                   NOP
0x9180 34           |                   INC (HL)
0x9181 12           |                   LD (DE),A
0x9182 00           |                   NOP
0x9183 C0           |                   RET NZ
0x9184 00           |                   NOP
0x9185 39           |                   ADD HL,SP
0x9186 00           |                   NOP
0x9187 00           |                   NOP
0x9188 00           |                   NOP
0x9189 C8           |                   RET Z
0x918a 00           |                   NOP
0x918b 00           |                   NOP
0x918c 00           |                   NOP
0x918d 00           |                   NOP
0x918e 00           |                   NOP
0x918f 00           |                   NOP
0x9190 00           |                   NOP
0x9191 00           |                   NOP
0x9192 00           |                   NOP
0x9193 00           |                   NOP
0x9194 00           |                   NOP
0x9195 00           |                   NOP
0x9196 00           |                   NOP
0x9197 00           |                   NOP
0x9198 00           |                   NOP
0x9199 00           |                   NOP
0x919a 00           |                   NOP
0x919b 00           |                   NOP
0x919c FF           |                   RST $38
0x919d 37           |                   SCF
0x919e 00           |                   NOP
0x919f 00           |                   NOP
0x91a0 00           |                   NOP
0x91a1 00           |                   NOP
0x91a2 00           |                   NOP
0x91a3 00           |                   NOP
0x91a4 00           |                   NOP
0x91a5 00           |                   NOP
0x91a6 FF           |                   RST $38
0x91a7 FF           |                   RST $38
0x91a8 00           |                   NOP
0x91a9 00           |                   NOP
0x91aa 00           |                   NOP
0x91ab 00           |                   NOP
0x91ac 57           |                   LD D,A
0x91ad FE 30        |                   CP $30
0x91af 9A           |                   SBC A,D
0x91b0 41           |                   LD B,C
0x91b1 4C           |                   LD C,H
0x91b2 4F           |                   LD C,A
0x91b3 20 41        |                   JR NZ,$41
0x91b5 2C           |                   INC L
0x91b6 5B           |                   LD E,E
0x91b7 48           |                   LD C,B
0x91b8 59           |                   LD E,C
0x91b9 2C           |                   INC L
0x91ba 4C           |                   LD C,H
0x91bb 59           |                   LD E,C
0x91bc 5D           |                   LD E,L
0x91bd 00           |                   NOP
0x91be FF           |                   RST $38
0x91bf DD 86 00     |                   ADD A,(IX+$00)
0x91c2 00           |                   NOP
0x91c3 FF           |                   RST $38
0x91c4 00           |                   NOP
0x91c5 CC BB EE     |                   CALL Z,$EEBB
0x91c8 DD           |                   *ILLEGAL*
0x91c9 11 44 0C     |                   LD DE,$0C44
0x91cc 88           |                   ADC A,B
0x91cd 0C           |                   INC C
0x91ce 88           |                   ADC A,B
0x91cf 00           |                   NOP
0x91d0 12           |                   LD (DE),A
0x91d1 00           |                   NOP
0x91d2 C0           |                   RET NZ
0x91d3 20 38        |                   JR NZ,$38
0x91d5 00           |                   NOP
0x91d6 00           |                   NOP
0x91d7 00           |                   NOP
0x91d8 C8           |                   RET Z
0x91d9 00           |                   NOP
0x91da 00           |                   NOP
0x91db 00           |                   NOP
0x91dc 00           |                   NOP
0x91dd 00           |                   NOP
0x91de 00           |                   NOP
0x91df 00           |                   NOP
0x91e0 00           |                   NOP
0x91e1 00           |                   NOP
0x91e2 00           |                   NOP
0x91e3 00           |                   NOP
0x91e4 00           |                   NOP
0x91e5 00           |                   NOP
0x91e6 00           |                   NOP
0x91e7 00           |                   NOP
0x91e8 00           |                   NOP
0x91e9 01 00 FF     |                   LD BC,$FF00
0x91ec 37           |                   SCF
0x91ed 00           |                   NOP
0x91ee 00           |                   NOP
0x91ef 00           |                   NOP
0x91f0 00           |                   NOP
0x91f1 00           |                   NOP
0x91f2 00           |                   NOP
0x91f3 01 00 01     |                   LD BC,$0100
0x91f6 00           |                   NOP
0x91f7 FF           |                   RST $38
0x91f8 00           |                   NOP
0x91f9 00           |                   NOP
0x91fa 00           |                   NOP
0x91fb 0E 19        |                   LD C,$19
0x91fd 9F           |                   SBC A,A
0x91fe C6 41        |                   ADD A,$41
0x9200 4C           |                   LD C,H
0x9201 4F           |                   LD C,A
0x9202 20 41        |                   JR NZ,$41
0x9204 2C           |                   INC L
0x9205 28 58        |                   JR Z,$58
0x9207 59           |                   LD E,C
0x9208 29           |                   ADD HL,HL
0x9209 00           |                   NOP
0x920a FF           |                   RST $38
0x920b 07           |                   RLCA
0x920c 00           |                   NOP
0x920d 00           |                   NOP
0x920e 00           |                   NOP
0x920f FF           |                   RST $38
0x9210 AA           |                   XOR D
0x9211 CC BB EE     |                   CALL Z,$EEBB
0x9214 DD           |                   *ILLEGAL*
0x9215 11 44 88     |                   LD DE,$8844
0x9218 DD 77 FD     |                   LD (IX+$FD),A
0x921b 34           |                   INC (HL)
0x921c 12           |                   LD (DE),A
0x921d 00           |                   NOP
0x921e C0           |                   RET NZ
0x921f 00           |                   NOP
0x9220 00           |                   NOP
0x9221 00           |                   NOP
0x9222 00           |                   NOP
0x9223 01 FF 00     |                   LD BC,$00FF
0x9226 00           |                   NOP
0x9227 00           |                   NOP
0x9228 00           |                   NOP
0x9229 00           |                   NOP
0x922a 00           |                   NOP
0x922b 00           |                   NOP
0x922c 00           |                   NOP
0x922d 00           |                   NOP
0x922e 00           |                   NOP
0x922f 00           |                   NOP
0x9230 00           |                   NOP
0x9231 00           |                   NOP
0x9232 00           |                   NOP
0x9233 00           |                   NOP
0x9234 00           |                   NOP
0x9235 00           |                   NOP
0x9236 00           |                   NOP
0x9237 FE 00        |                   CP $00
0x9239 00           |                   NOP
0x923a 00           |                   NOP
0x923b 00           |                   NOP
0x923c 00           |                   NOP
0x923d 00           |                   NOP
0x923e 00           |                   NOP
0x923f 00           |                   NOP
0x9240 00           |                   NOP
0x9241 00           |                   NOP
0x9242 00           |                   NOP
0x9243 00           |                   NOP
0x9244 00           |                   NOP
0x9245 00           |                   NOP
0x9246 00           |                   NOP
0x9247 2C           |                   INC L
0x9248 F1           |                   POP AF
0x9249 4E           |                   LD C,(HL)
0x924a 06 52        |                   LD B,$52
0x924c 4C           |                   LD C,H
0x924d 43           |                   LD B,E
0x924e 41           |                   LD B,C
0x924f 00           |                   NOP
0x9250 FF           |                   RST $38
0x9251 0F           |                   RRCA
0x9252 00           |                   NOP
0x9253 00           |                   NOP
0x9254 00           |                   NOP
0x9255 FF           |                   RST $38
0x9256 AA           |                   XOR D
0x9257 CC BB EE     |                   CALL Z,$EEBB
0x925a DD           |                   *ILLEGAL*
0x925b 11 44 88     |                   LD DE,$8844
0x925e DD 77 FD     |                   LD (IX+$FD),A
0x9261 34           |                   INC (HL)
0x9262 12           |                   LD (DE),A
0x9263 00           |                   NOP
0x9264 C0           |                   RET NZ
0x9265 00           |                   NOP
0x9266 00           |                   NOP
0x9267 00           |                   NOP
0x9268 00           |                   NOP
0x9269 01 FF 00     |                   LD BC,$00FF
0x926c 00           |                   NOP
0x926d 00           |                   NOP
0x926e 00           |                   NOP
0x926f 00           |                   NOP
0x9270 00           |                   NOP
0x9271 00           |                   NOP
0x9272 00           |                   NOP
0x9273 00           |                   NOP
0x9274 00           |                   NOP
0x9275 00           |                   NOP
0x9276 00           |                   NOP
0x9277 00           |                   NOP
0x9278 00           |                   NOP
0x9279 00           |                   NOP
0x927a 00           |                   NOP
0x927b 00           |                   NOP
0x927c 00           |                   NOP
0x927d FE 00        |                   CP $00
0x927f 00           |                   NOP
0x9280 00           |                   NOP
0x9281 00           |                   NOP
0x9282 00           |                   NOP
0x9283 00           |                   NOP
0x9284 00           |                   NOP
0x9285 00           |                   NOP
0x9286 00           |                   NOP
0x9287 00           |                   NOP
0x9288 00           |                   NOP
0x9289 00           |                   NOP
0x928a 00           |                   NOP
0x928b 00           |                   NOP
0x928c 00           |                   NOP
0x928d 02           |                   LD (BC),A
0x928e 2A E2 90     |                   LD HL,($90E2)
0x9291 52           |                   LD D,D
0x9292 52           |                   LD D,D
0x9293 43           |                   LD B,E
0x9294 41           |                   LD B,C
0x9295 00           |                   NOP
0x9296 FF           |                   RST $38
0x9297 17           |                   RLA
0x9298 00           |                   NOP
0x9299 00           |                   NOP
0x929a 00           |                   NOP
0x929b FF           |                   RST $38
0x929c AA           |                   XOR D
0x929d CC BB EE     |                   CALL Z,$EEBB
0x92a0 DD           |                   *ILLEGAL*
0x92a1 11 44 88     |                   LD DE,$8844
0x92a4 DD 77 FD     |                   LD (IX+$FD),A
0x92a7 34           |                   INC (HL)
0x92a8 12           |                   LD (DE),A
0x92a9 00           |                   NOP
0x92aa C0           |                   RET NZ
0x92ab 00           |                   NOP
0x92ac 00           |                   NOP
0x92ad 00           |                   NOP
0x92ae 00           |                   NOP
0x92af 01 FF 00     |                   LD BC,$00FF
0x92b2 00           |                   NOP
0x92b3 00           |                   NOP
0x92b4 00           |                   NOP
0x92b5 00           |                   NOP
0x92b6 00           |                   NOP
0x92b7 00           |                   NOP
0x92b8 00           |                   NOP
0x92b9 00           |                   NOP
0x92ba 00           |                   NOP
0x92bb 00           |                   NOP
0x92bc 00           |                   NOP
0x92bd 00           |                   NOP
0x92be 00           |                   NOP
0x92bf 00           |                   NOP
0x92c0 00           |                   NOP
0x92c1 00           |                   NOP
0x92c2 00           |                   NOP
0x92c3 FE 00        |                   CP $00
0x92c5 00           |                   NOP
0x92c6 00           |                   NOP
0x92c7 00           |                   NOP
0x92c8 00           |                   NOP
0x92c9 00           |                   NOP
0x92ca 00           |                   NOP
0x92cb 00           |                   NOP
0x92cc 00           |                   NOP
0x92cd 00           |                   NOP
0x92ce 00           |                   NOP
0x92cf 00           |                   NOP
0x92d0 00           |                   NOP
0x92d1 00           |                   NOP
0x92d2 00           |                   NOP
0x92d3 AE           |                   XOR (HL)
0x92d4 39           |                   ADD HL,SP
0x92d5 CB 75        |                   BIT 6,L
0x92d7 52           |                   LD D,D
0x92d8 4C           |                   LD C,H
0x92d9 41           |                   LD B,C
0x92da 00           |                   NOP
0x92db FF           |                   RST $38
0x92dc 1F           |                   RRA
0x92dd 00           |                   NOP
0x92de 00           |                   NOP
0x92df 00           |                   NOP
0x92e0 FF           |                   RST $38
0x92e1 AA           |                   XOR D
0x92e2 CC BB EE     |                   CALL Z,$EEBB
0x92e5 DD           |                   *ILLEGAL*
0x92e6 11 44 88     |                   LD DE,$8844
0x92e9 DD 77 FD     |                   LD (IX+$FD),A
0x92ec 34           |                   INC (HL)
0x92ed 12           |                   LD (DE),A
0x92ee 00           |                   NOP
0x92ef C0           |                   RET NZ
0x92f0 00           |                   NOP
0x92f1 00           |                   NOP
0x92f2 00           |                   NOP
0x92f3 00           |                   NOP
0x92f4 01 FF 00     |                   LD BC,$00FF
0x92f7 00           |                   NOP
0x92f8 00           |                   NOP
0x92f9 00           |                   NOP
0x92fa 00           |                   NOP
0x92fb 00           |                   NOP
0x92fc 00           |                   NOP
0x92fd 00           |                   NOP
0x92fe 00           |                   NOP
0x92ff 00           |                   NOP
0x9300 00           |                   NOP
0x9301 00           |                   NOP
0x9302 00           |                   NOP
0x9303 00           |                   NOP
0x9304 00           |                   NOP
0x9305 00           |                   NOP
0x9306 00           |                   NOP
0x9307 00           |                   NOP
0x9308 FE 00        |                   CP $00
0x930a 00           |                   NOP
0x930b 00           |                   NOP
0x930c 00           |                   NOP
0x930d 00           |                   NOP
0x930e 00           |                   NOP
0x930f 00           |                   NOP
0x9310 00           |                   NOP
0x9311 00           |                   NOP
0x9312 00           |                   NOP
0x9313 00           |                   NOP
0x9314 00           |                   NOP
0x9315 00           |                   NOP
0x9316 00           |                   NOP
0x9317 00           |                   NOP
0x9318 9C           |                   SBC A,H
0x9319 60           |                   LD H,B
0x931a 94           |                   SUB A,H
0x931b B6           |                   OR (HL)
0x931c 52           |                   LD D,D
0x931d 52           |                   LD D,D
0x931e 41           |                   LD B,C
0x931f 00           |                   NOP
0x9320 FF           |                   RST $38
0x9321 ED 6F        |                   RLD
0x9323 00           |                   NOP
0x9324 00           |                   NOP
0x9325 FF           |                   RST $38
0x9326 00           |                   NOP
0x9327 CC BB EE     |                   CALL Z,$EEBB
0x932a DD           |                   *ILLEGAL*
0x932b 0C           |                   INC C
0x932c 88           |                   ADC A,B
0x932d 88           |                   ADC A,B
0x932e DD 77 FD     |                   LD (IX+$FD),A
0x9331 00           |                   NOP
0x9332 12           |                   LD (DE),A
0x9333 00           |                   NOP
0x9334 C0           |                   RET NZ
0x9335 00           |                   NOP
0x9336 00           |                   NOP
0x9337 00           |                   NOP
0x9338 00           |                   NOP
0x9339 00           |                   NOP
0x933a 88           |                   ADC A,B
0x933b 00           |                   NOP
0x933c 00           |                   NOP
0x933d 00           |                   NOP
0x933e 00           |                   NOP
0x933f 00           |                   NOP
0x9340 00           |                   NOP
0x9341 00           |                   NOP
0x9342 00           |                   NOP
0x9343 00           |                   NOP
0x9344 00           |                   NOP
0x9345 88           |                   ADC A,B
0x9346 00           |                   NOP
0x9347 00           |                   NOP
0x9348 00           |                   NOP
0x9349 00           |                   NOP
0x934a 00           |                   NOP
0x934b 00           |                   NOP
0x934c 00           |                   NOP
0x934d FF           |                   RST $38
0x934e 77           |                   LD (HL),A
0x934f 00           |                   NOP
0x9350 00           |                   NOP
0x9351 00           |                   NOP
0x9352 00           |                   NOP
0x9353 00           |                   NOP
0x9354 00           |                   NOP
0x9355 00           |                   NOP
0x9356 00           |                   NOP
0x9357 00           |                   NOP
0x9358 00           |                   NOP
0x9359 77           |                   LD (HL),A
0x935a 00           |                   NOP
0x935b 00           |                   NOP
0x935c 00           |                   NOP
0x935d BF           |                   CP A
0x935e A1           |                   AND C
0x935f 32 84 52     |                   LD ($5284),A
0x9362 4C           |                   LD C,H
0x9363 44           |                   LD B,H
0x9364 00           |                   NOP
0x9365 FF           |                   RST $38
0x9366 ED 67        |                   RRD
0x9368 00           |                   NOP
0x9369 00           |                   NOP
0x936a FF           |                   RST $38
0x936b 00           |                   NOP
0x936c CC BB EE     |                   CALL Z,$EEBB
0x936f DD           |                   *ILLEGAL*
0x9370 0C           |                   INC C
0x9371 88           |                   ADC A,B
0x9372 88           |                   ADC A,B
0x9373 DD 77 FD     |                   LD (IX+$FD),A
0x9376 00           |                   NOP
0x9377 12           |                   LD (DE),A
0x9378 00           |                   NOP
0x9379 C0           |                   RET NZ
0x937a 00           |                   NOP
0x937b 00           |                   NOP
0x937c 00           |                   NOP
0x937d 00           |                   NOP
0x937e 00           |                   NOP
0x937f 88           |                   ADC A,B
0x9380 00           |                   NOP
0x9381 00           |                   NOP
0x9382 00           |                   NOP
0x9383 00           |                   NOP
0x9384 00           |                   NOP
0x9385 00           |                   NOP
0x9386 00           |                   NOP
0x9387 00           |                   NOP
0x9388 00           |                   NOP
0x9389 00           |                   NOP
0x938a 88           |                   ADC A,B
0x938b 00           |                   NOP
0x938c 00           |                   NOP
0x938d 00           |                   NOP
0x938e 00           |                   NOP
0x938f 00           |                   NOP
0x9390 00           |                   NOP
0x9391 00           |                   NOP
0x9392 FF           |                   RST $38
0x9393 77           |                   LD (HL),A
0x9394 00           |                   NOP
0x9395 00           |                   NOP
0x9396 00           |                   NOP
0x9397 00           |                   NOP
0x9398 00           |                   NOP
0x9399 00           |                   NOP
0x939a 00           |                   NOP
0x939b 00           |                   NOP
0x939c 00           |                   NOP
0x939d 00           |                   NOP
0x939e 77           |                   LD (HL),A
0x939f 00           |                   NOP
0x93a0 00           |                   NOP
0x93a1 00           |                   NOP
0x93a2 7D           |                   LD A,L
0x93a3 B4           |                   OR H
0x93a4 C0           |                   RET NZ
0x93a5 60           |                   LD H,B
0x93a6 52           |                   LD D,D
0x93a7 52           |                   LD D,D
0x93a8 44           |                   LD B,H
0x93a9 00           |                   NOP
0x93aa FF           |                   RST $38
0x93ab CB 07        |                   RLC A
0x93ad 00           |                   NOP
0x93ae 00           |                   NOP
0x93af FF           |                   RST $38
0x93b0 AA           |                   XOR D
0x93b1 CC BB EE     |                   CALL Z,$EEBB
0x93b4 DD           |                   *ILLEGAL*
0x93b5 11 44 88     |                   LD DE,$8844
0x93b8 DD 77 FD     |                   LD (IX+$FD),A
0x93bb 34           |                   INC (HL)
0x93bc 12           |                   LD (DE),A
0x93bd 00           |                   NOP
0x93be C0           |                   RET NZ
0x93bf 00           |                   NOP
0x93c0 00           |                   NOP
0x93c1 00           |                   NOP
0x93c2 00           |                   NOP
0x93c3 01 FF 00     |                   LD BC,$00FF
0x93c6 00           |                   NOP
0x93c7 00           |                   NOP
0x93c8 00           |                   NOP
0x93c9 00           |                   NOP
0x93ca 00           |                   NOP
0x93cb 00           |                   NOP
0x93cc 00           |                   NOP
0x93cd 00           |                   NOP
0x93ce 00           |                   NOP
0x93cf 00           |                   NOP
0x93d0 00           |                   NOP
0x93d1 00           |                   NOP
0x93d2 00           |                   NOP
0x93d3 00           |                   NOP
0x93d4 00           |                   NOP
0x93d5 00           |                   NOP
0x93d6 00           |                   NOP
0x93d7 FE 00        |                   CP $00
0x93d9 00           |                   NOP
0x93da 00           |                   NOP
0x93db 00           |                   NOP
0x93dc 00           |                   NOP
0x93dd 00           |                   NOP
0x93de 00           |                   NOP
0x93df 00           |                   NOP
0x93e0 00           |                   NOP
0x93e1 00           |                   NOP
0x93e2 00           |                   NOP
0x93e3 00           |                   NOP
0x93e4 00           |                   NOP
0x93e5 00           |                   NOP
0x93e6 00           |                   NOP
0x93e7 28 3E        |                   JR Z,$3E
0x93e9 77           |                   LD (HL),A
0x93ea E2 52 4C     |                   JP PO,$4C52
0x93ed 43           |                   LD B,E
0x93ee 20 41        |                   JR NZ,$41
0x93f0 00           |                   NOP
0x93f1 FF           |                   RST $38
0x93f2 CB 0F        |                   RRC A
0x93f4 00           |                   NOP
0x93f5 00           |                   NOP
0x93f6 FF           |                   RST $38
0x93f7 AA           |                   XOR D
0x93f8 CC BB EE     |                   CALL Z,$EEBB
0x93fb DD           |                   *ILLEGAL*
0x93fc 11 44 88     |                   LD DE,$8844
0x93ff DD 77 FD     |                   LD (IX+$FD),A
0x9402 34           |                   INC (HL)
0x9403 12           |                   LD (DE),A
0x9404 00           |                   NOP
0x9405 C0           |                   RET NZ
0x9406 00           |                   NOP
0x9407 00           |                   NOP
0x9408 00           |                   NOP
0x9409 00           |                   NOP
0x940a 01 FF 00     |                   LD BC,$00FF
0x940d 00           |                   NOP
0x940e 00           |                   NOP
0x940f 00           |                   NOP
0x9410 00           |                   NOP
0x9411 00           |                   NOP
0x9412 00           |                   NOP
0x9413 00           |                   NOP
0x9414 00           |                   NOP
0x9415 00           |                   NOP
0x9416 00           |                   NOP
0x9417 00           |                   NOP
0x9418 00           |                   NOP
0x9419 00           |                   NOP
0x941a 00           |                   NOP
0x941b 00           |                   NOP
0x941c 00           |                   NOP
0x941d 00           |                   NOP
0x941e FE 00        |                   CP $00
0x9420 00           |                   NOP
0x9421 00           |                   NOP
0x9422 00           |                   NOP
0x9423 00           |                   NOP
0x9424 00           |                   NOP
0x9425 00           |                   NOP
0x9426 00           |                   NOP
0x9427 00           |                   NOP
0x9428 00           |                   NOP
0x9429 00           |                   NOP
0x942a 00           |                   NOP
0x942b 00           |                   NOP
0x942c 00           |                   NOP
0x942d 00           |                   NOP
0x942e 8E           |                   ADC A,(HL)
0x942f C5           |                   PUSH BC
0x9430 C3 7A 52     |                   JP $527A
0x9433 52           |                   LD D,D
0x9434 43           |                   LD B,E
0x9435 20 41        |                   JR NZ,$41
0x9437 00           |                   NOP
0x9438 FF           |                   RST $38
0x9439 CB 17        |                   RL A
0x943b 00           |                   NOP
0x943c 00           |                   NOP
0x943d FF           |                   RST $38
0x943e AA           |                   XOR D
0x943f CC BB EE     |                   CALL Z,$EEBB
0x9442 DD           |                   *ILLEGAL*
0x9443 11 44 88     |                   LD DE,$8844
0x9446 DD 77 FD     |                   LD (IX+$FD),A
0x9449 34           |                   INC (HL)
0x944a 12           |                   LD (DE),A
0x944b 00           |                   NOP
0x944c C0           |                   RET NZ
0x944d 00           |                   NOP
0x944e 00           |                   NOP
0x944f 00           |                   NOP
0x9450 00           |                   NOP
0x9451 01 FF 00     |                   LD BC,$00FF
0x9454 00           |                   NOP
0x9455 00           |                   NOP
0x9456 00           |                   NOP
0x9457 00           |                   NOP
0x9458 00           |                   NOP
0x9459 00           |                   NOP
0x945a 00           |                   NOP
0x945b 00           |                   NOP
0x945c 00           |                   NOP
0x945d 00           |                   NOP
0x945e 00           |                   NOP
0x945f 00           |                   NOP
0x9460 00           |                   NOP
0x9461 00           |                   NOP
0x9462 00           |                   NOP
0x9463 00           |                   NOP
0x9464 00           |                   NOP
0x9465 FE 00        |                   CP $00
0x9467 00           |                   NOP
0x9468 00           |                   NOP
0x9469 00           |                   NOP
0x946a 00           |                   NOP
0x946b 00           |                   NOP
0x946c 00           |                   NOP
0x946d 00           |                   NOP
0x946e 00           |                   NOP
0x946f 00           |                   NOP
0x9470 00           |                   NOP
0x9471 00           |                   NOP
0x9472 00           |                   NOP
0x9473 00           |                   NOP
0x9474 00           |                   NOP
0x9475 F4 28 4A     |                   CALL P,$4A28
0x9478 2F           |                   CPL
0x9479 52           |                   LD D,D
0x947a 4C           |                   LD C,H
0x947b 20 41        |                   JR NZ,$41
0x947d 00           |                   NOP
0x947e FF           |                   RST $38
0x947f CB 1F        |                   RR A
0x9481 00           |                   NOP
0x9482 00           |                   NOP
0x9483 FF           |                   RST $38
0x9484 AA           |                   XOR D
0x9485 CC BB EE     |                   CALL Z,$EEBB
0x9488 DD           |                   *ILLEGAL*
0x9489 11 44 88     |                   LD DE,$8844
0x948c DD 77 FD     |                   LD (IX+$FD),A
0x948f 34           |                   INC (HL)
0x9490 12           |                   LD (DE),A
0x9491 00           |                   NOP
0x9492 C0           |                   RET NZ
0x9493 00           |                   NOP
0x9494 00           |                   NOP
0x9495 00           |                   NOP
0x9496 00           |                   NOP
0x9497 01 FF 00     |                   LD BC,$00FF
0x949a 00           |                   NOP
0x949b 00           |                   NOP
0x949c 00           |                   NOP
0x949d 00           |                   NOP
0x949e 00           |                   NOP
0x949f 00           |                   NOP
0x94a0 00           |                   NOP
0x94a1 00           |                   NOP
0x94a2 00           |                   NOP
0x94a3 00           |                   NOP
0x94a4 00           |                   NOP
0x94a5 00           |                   NOP
0x94a6 00           |                   NOP
0x94a7 00           |                   NOP
0x94a8 00           |                   NOP
0x94a9 00           |                   NOP
0x94aa 00           |                   NOP
0x94ab FE 00        |                   CP $00
0x94ad 00           |                   NOP
0x94ae 00           |                   NOP
0x94af 00           |                   NOP
0x94b0 00           |                   NOP
0x94b1 00           |                   NOP
0x94b2 00           |                   NOP
0x94b3 00           |                   NOP
0x94b4 00           |                   NOP
0x94b5 00           |                   NOP
0x94b6 00           |                   NOP
0x94b7 00           |                   NOP
0x94b8 00           |                   NOP
0x94b9 00           |                   NOP
0x94ba 00           |                   NOP
0x94bb 8F           |                   ADC A,A
0x94bc F2 A5 87     |                   JP P,$87A5
0x94bf 52           |                   LD D,D
0x94c0 52           |                   LD D,D
0x94c1 20 41        |                   JR NZ,$41
0x94c3 00           |                   NOP
0x94c4 FF           |                   RST $38
0x94c5 CB 27        |                   SLA A
0x94c7 00           |                   NOP
0x94c8 00           |                   NOP
0x94c9 FF           |                   RST $38
0x94ca AA           |                   XOR D
0x94cb CC BB EE     |                   CALL Z,$EEBB
0x94ce DD           |                   *ILLEGAL*
0x94cf 11 44 88     |                   LD DE,$8844
0x94d2 DD 77 FD     |                   LD (IX+$FD),A
0x94d5 34           |                   INC (HL)
0x94d6 12           |                   LD (DE),A
0x94d7 00           |                   NOP
0x94d8 C0           |                   RET NZ
0x94d9 00           |                   NOP
0x94da 00           |                   NOP
0x94db 00           |                   NOP
0x94dc 00           |                   NOP
0x94dd 01 FF 00     |                   LD BC,$00FF
0x94e0 00           |                   NOP
0x94e1 00           |                   NOP
0x94e2 00           |                   NOP
0x94e3 00           |                   NOP
0x94e4 00           |                   NOP
0x94e5 00           |                   NOP
0x94e6 00           |                   NOP
0x94e7 00           |                   NOP
0x94e8 00           |                   NOP
0x94e9 00           |                   NOP
0x94ea 00           |                   NOP
0x94eb 00           |                   NOP
0x94ec 00           |                   NOP
0x94ed 00           |                   NOP
0x94ee 00           |                   NOP
0x94ef 00           |                   NOP
0x94f0 00           |                   NOP
0x94f1 FE 00        |                   CP $00
0x94f3 00           |                   NOP
0x94f4 00           |                   NOP
0x94f5 00           |                   NOP
0x94f6 00           |                   NOP
0x94f7 00           |                   NOP
0x94f8 00           |                   NOP
0x94f9 00           |                   NOP
0x94fa 00           |                   NOP
0x94fb 00           |                   NOP
0x94fc 00           |                   NOP
0x94fd 00           |                   NOP
0x94fe 00           |                   NOP
0x94ff 00           |                   NOP
0x9500 00           |                   NOP
0x9501 23           |                   INC HL
0x9502 57           |                   LD D,A
0x9503 57           |                   LD D,A
0x9504 76           |                   HALT
0x9505 53           |                   LD D,E
0x9506 4C           |                   LD C,H
0x9507 41           |                   LD B,C
0x9508 20 41        |                   JR NZ,$41
0x950a 00           |                   NOP
0x950b FF           |                   RST $38
0x950c CB 2F        |                   SRA A
0x950e 00           |                   NOP
0x950f 00           |                   NOP
0x9510 FF           |                   RST $38
0x9511 AA           |                   XOR D
0x9512 CC BB EE     |                   CALL Z,$EEBB
0x9515 DD           |                   *ILLEGAL*
0x9516 11 44 88     |                   LD DE,$8844
0x9519 DD 77 FD     |                   LD (IX+$FD),A
0x951c 34           |                   INC (HL)
0x951d 12           |                   LD (DE),A
0x951e 00           |                   NOP
0x951f C0           |                   RET NZ
0x9520 00           |                   NOP
0x9521 00           |                   NOP
0x9522 00           |                   NOP
0x9523 00           |                   NOP
0x9524 01 FF 00     |                   LD BC,$00FF
0x9527 00           |                   NOP
0x9528 00           |                   NOP
0x9529 00           |                   NOP
0x952a 00           |                   NOP
0x952b 00           |                   NOP
0x952c 00           |                   NOP
0x952d 00           |                   NOP
0x952e 00           |                   NOP
0x952f 00           |                   NOP
0x9530 00           |                   NOP
0x9531 00           |                   NOP
0x9532 00           |                   NOP
0x9533 00           |                   NOP
0x9534 00           |                   NOP
0x9535 00           |                   NOP
0x9536 00           |                   NOP
0x9537 00           |                   NOP
0x9538 FE 00        |                   CP $00
0x953a 00           |                   NOP
0x953b 00           |                   NOP
0x953c 00           |                   NOP
0x953d 00           |                   NOP
0x953e 00           |                   NOP
0x953f 00           |                   NOP
0x9540 00           |                   NOP
0x9541 00           |                   NOP
0x9542 00           |                   NOP
0x9543 00           |                   NOP
0x9544 00           |                   NOP
0x9545 00           |                   NOP
0x9546 00           |                   NOP
0x9547 00           |                   NOP
0x9548 43           |                   LD B,E
0x9549 FD 2A 03 53  |                   LD IY,($5303)
0x954d 52           |                   LD D,D
0x954e 41           |                   LD B,C
0x954f 20 41        |                   JR NZ,$41
0x9551 00           |                   NOP
0x9552 FF           |                   RST $38
0x9553 CB 37        |                   SLS A
0x9555 00           |                   NOP
0x9556 00           |                   NOP
0x9557 FF           |                   RST $38
0x9558 AA           |                   XOR D
0x9559 CC BB EE     |                   CALL Z,$EEBB
0x955c DD           |                   *ILLEGAL*
0x955d 11 44 88     |                   LD DE,$8844
0x9560 DD 77 FD     |                   LD (IX+$FD),A
0x9563 34           |                   INC (HL)
0x9564 12           |                   LD (DE),A
0x9565 00           |                   NOP
0x9566 C0           |                   RET NZ
0x9567 00           |                   NOP
0x9568 00           |                   NOP
0x9569 00           |                   NOP
0x956a 00           |                   NOP
0x956b 01 FF 00     |                   LD BC,$00FF
0x956e 00           |                   NOP
0x956f 00           |                   NOP
0x9570 00           |                   NOP
0x9571 00           |                   NOP
0x9572 00           |                   NOP
0x9573 00           |                   NOP
0x9574 00           |                   NOP
0x9575 00           |                   NOP
0x9576 00           |                   NOP
0x9577 00           |                   NOP
0x9578 00           |                   NOP
0x9579 00           |                   NOP
0x957a 00           |                   NOP
0x957b 00           |                   NOP
0x957c 00           |                   NOP
0x957d 00           |                   NOP
0x957e 00           |                   NOP
0x957f FE 00        |                   CP $00
0x9581 00           |                   NOP
0x9582 00           |                   NOP
0x9583 00           |                   NOP
0x9584 00           |                   NOP
0x9585 00           |                   NOP
0x9586 00           |                   NOP
0x9587 00           |                   NOP
0x9588 00           |                   NOP
0x9589 00           |                   NOP
0x958a 00           |                   NOP
0x958b 00           |                   NOP
0x958c 00           |                   NOP
0x958d 00           |                   NOP
0x958e 00           |                   NOP
0x958f 31 0E 72     |                   LD SP,$720E
0x9592 5B           |                   LD E,E
0x9593 53           |                   LD D,E
0x9594 4C           |                   LD C,H
0x9595 49           |                   LD C,C
0x9596 41           |                   LD B,C
0x9597 20 41        |                   JR NZ,$41
0x9599 00           |                   NOP
0x959a FF           |                   RST $38
0x959b CB 3F        |                   SRL A
0x959d 00           |                   NOP
0x959e 00           |                   NOP
0x959f FF           |                   RST $38
0x95a0 AA           |                   XOR D
0x95a1 CC BB EE     |                   CALL Z,$EEBB
0x95a4 DD           |                   *ILLEGAL*
0x95a5 11 44 88     |                   LD DE,$8844
0x95a8 DD 77 FD     |                   LD (IX+$FD),A
0x95ab 34           |                   INC (HL)
0x95ac 12           |                   LD (DE),A
0x95ad 00           |                   NOP
0x95ae C0           |                   RET NZ
0x95af 00           |                   NOP
0x95b0 00           |                   NOP
0x95b1 00           |                   NOP
0x95b2 00           |                   NOP
0x95b3 01 FF 00     |                   LD BC,$00FF
0x95b6 00           |                   NOP
0x95b7 00           |                   NOP
0x95b8 00           |                   NOP
0x95b9 00           |                   NOP
0x95ba 00           |                   NOP
0x95bb 00           |                   NOP
0x95bc 00           |                   NOP
0x95bd 00           |                   NOP
0x95be 00           |                   NOP
0x95bf 00           |                   NOP
0x95c0 00           |                   NOP
0x95c1 00           |                   NOP
0x95c2 00           |                   NOP
0x95c3 00           |                   NOP
0x95c4 00           |                   NOP
0x95c5 00           |                   NOP
0x95c6 00           |                   NOP
0x95c7 FE 00        |                   CP $00
0x95c9 00           |                   NOP
0x95ca 00           |                   NOP
0x95cb 00           |                   NOP
0x95cc 00           |                   NOP
0x95cd 00           |                   NOP
0x95ce 00           |                   NOP
0x95cf 00           |                   NOP
0x95d0 00           |                   NOP
0x95d1 00           |                   NOP
0x95d2 00           |                   NOP
0x95d3 00           |                   NOP
0x95d4 00           |                   NOP
0x95d5 00           |                   NOP
0x95d6 00           |                   NOP
0x95d7 0D           |                   DEC C
0x95d8 D8           |                   RET C
0x95d9 DB B3        |                   IN A,($B3)
0x95db 53           |                   LD D,E
0x95dc 52           |                   LD D,D
0x95dd 4C           |                   LD C,H
0x95de 20 41        |                   JR NZ,$41
0x95e0 00           |                   NOP
0x95e1 FF           |                   RST $38
0x95e2 CB 00        |                   RLC B
0x95e4 00           |                   NOP
0x95e5 00           |                   NOP
0x95e6 FF           |                   RST $38
0x95e7 00           |                   NOP
0x95e8 00           |                   NOP
0x95e9 00           |                   NOP
0x95ea 00           |                   NOP
0x95eb 00           |                   NOP
0x95ec 0C           |                   INC C
0x95ed 88           |                   ADC A,B
0x95ee 88           |                   ADC A,B
0x95ef DD 77 FD     |                   LD (IX+$FD),A
0x95f2 34           |                   INC (HL)
0x95f3 12           |                   LD (DE),A
0x95f4 00           |                   NOP
0x95f5 C0           |                   RET NZ
0x95f6 00           |                   NOP
0x95f7 07           |                   RLCA
0x95f8 00           |                   NOP
0x95f9 00           |                   NOP
0x95fa 01 00 00     |                   LD BC,$0000
0x95fd 00           |                   NOP
0x95fe 00           |                   NOP
0x95ff 00           |                   NOP
0x9600 00           |                   NOP
0x9601 00           |                   NOP
0x9602 00           |                   NOP
0x9603 00           |                   NOP
0x9604 00           |                   NOP
0x9605 00           |                   NOP
0x9606 00           |                   NOP
0x9607 00           |                   NOP
0x9608 00           |                   NOP
0x9609 00           |                   NOP
0x960a 00           |                   NOP
0x960b 00           |                   NOP
0x960c 00           |                   NOP
0x960d 00           |                   NOP
0x960e FE FF        |                   CP $FF
0x9610 FF           |                   RST $38
0x9611 FF           |                   RST $38
0x9612 FF           |                   RST $38
0x9613 FF           |                   RST $38
0x9614 01 00 00     |                   LD BC,$0000
0x9617 00           |                   NOP
0x9618 00           |                   NOP
0x9619 00           |                   NOP
0x961a FF           |                   RST $38
0x961b 00           |                   NOP
0x961c 00           |                   NOP
0x961d 00           |                   NOP
0x961e D0           |                   RET NC
0x961f DB B5        |                   IN A,($B5)
0x9621 C9           |                   RET
0x9622 52           |                   LD D,D
0x9623 4C           |                   LD C,H
0x9624 43           |                   LD B,E
0x9625 20 5B        |                   JR NZ,$5B
0x9627 52           |                   LD D,D
0x9628 2C           |                   INC L
0x9629 28 48        |                   JR Z,$48
0x962b 4C           |                   LD C,H
0x962c 29           |                   ADD HL,HL
0x962d 5D           |                   LD E,L
0x962e 00           |                   NOP
0x962f FF           |                   RST $38
0x9630 CB 08        |                   RRC B
0x9632 00           |                   NOP
0x9633 00           |                   NOP
0x9634 FF           |                   RST $38
0x9635 00           |                   NOP
0x9636 00           |                   NOP
0x9637 00           |                   NOP
0x9638 00           |                   NOP
0x9639 00           |                   NOP
0x963a 0C           |                   INC C
0x963b 88           |                   ADC A,B
0x963c 88           |                   ADC A,B
0x963d DD 77 FD     |                   LD (IX+$FD),A
0x9640 34           |                   INC (HL)
0x9641 12           |                   LD (DE),A
0x9642 00           |                   NOP
0x9643 C0           |                   RET NZ
0x9644 00           |                   NOP
0x9645 07           |                   RLCA
0x9646 00           |                   NOP
0x9647 00           |                   NOP
0x9648 01 00 00     |                   LD BC,$0000
0x964b 00           |                   NOP
0x964c 00           |                   NOP
0x964d 00           |                   NOP
0x964e 00           |                   NOP
0x964f 00           |                   NOP
0x9650 00           |                   NOP
0x9651 00           |                   NOP
0x9652 00           |                   NOP
0x9653 00           |                   NOP
0x9654 00           |                   NOP
0x9655 00           |                   NOP
0x9656 00           |                   NOP
0x9657 00           |                   NOP
0x9658 00           |                   NOP
0x9659 00           |                   NOP
0x965a 00           |                   NOP
0x965b 00           |                   NOP
0x965c FE FF        |                   CP $FF
0x965e FF           |                   RST $38
0x965f FF           |                   RST $38
0x9660 FF           |                   RST $38
0x9661 FF           |                   RST $38
0x9662 01 00 00     |                   LD BC,$0000
0x9665 00           |                   NOP
0x9666 00           |                   NOP
0x9667 00           |                   NOP
0x9668 FF           |                   RST $38
0x9669 00           |                   NOP
0x966a 00           |                   NOP
0x966b 00           |                   NOP
0x966c 58           |                   LD E,B
0x966d 0C           |                   INC C
0x966e 36 99        |                   LD (HL),$99
0x9670 52           |                   LD D,D
0x9671 52           |                   LD D,D
0x9672 43           |                   LD B,E
0x9673 20 5B        |                   JR NZ,$5B
0x9675 52           |                   LD D,D
0x9676 2C           |                   INC L
0x9677 28 48        |                   JR Z,$48
0x9679 4C           |                   LD C,H
0x967a 29           |                   ADD HL,HL
0x967b 5D           |                   LD E,L
0x967c 00           |                   NOP
0x967d FF           |                   RST $38
0x967e CB 10        |                   RL B
0x9680 00           |                   NOP
0x9681 00           |                   NOP
0x9682 FF           |                   RST $38
0x9683 00           |                   NOP
0x9684 00           |                   NOP
0x9685 00           |                   NOP
0x9686 00           |                   NOP
0x9687 00           |                   NOP
0x9688 0C           |                   INC C
0x9689 88           |                   ADC A,B
0x968a 88           |                   ADC A,B
0x968b DD 77 FD     |                   LD (IX+$FD),A
0x968e 34           |                   INC (HL)
0x968f 12           |                   LD (DE),A
0x9690 00           |                   NOP
0x9691 C0           |                   RET NZ
0x9692 00           |                   NOP
0x9693 07           |                   RLCA
0x9694 00           |                   NOP
0x9695 00           |                   NOP
0x9696 01 00 00     |                   LD BC,$0000
0x9699 00           |                   NOP
0x969a 00           |                   NOP
0x969b 00           |                   NOP
0x969c 00           |                   NOP
0x969d 00           |                   NOP
0x969e 00           |                   NOP
0x969f 00           |                   NOP
0x96a0 00           |                   NOP
0x96a1 00           |                   NOP
0x96a2 00           |                   NOP
0x96a3 00           |                   NOP
0x96a4 00           |                   NOP
0x96a5 00           |                   NOP
0x96a6 00           |                   NOP
0x96a7 00           |                   NOP
0x96a8 00           |                   NOP
0x96a9 00           |                   NOP
0x96aa FE FF        |                   CP $FF
0x96ac FF           |                   RST $38
0x96ad FF           |                   RST $38
0x96ae FF           |                   RST $38
0x96af FF           |                   RST $38
0x96b0 01 00 00     |                   LD BC,$0000
0x96b3 00           |                   NOP
0x96b4 00           |                   NOP
0x96b5 00           |                   NOP
0x96b6 FF           |                   RST $38
0x96b7 00           |                   NOP
0x96b8 00           |                   NOP
0x96b9 00           |                   NOP
0x96ba 6C           |                   LD L,H
0x96bb E6 36        |                   AND $36
0x96bd 85           |                   AA,L
0x96be 52           |                   LD D,D
0x96bf 4C           |                   LD C,H
0x96c0 20 5B        |                   JR NZ,$5B
0x96c2 52           |                   LD D,D
0x96c3 2C           |                   INC L
0x96c4 28 48        |                   JR Z,$48
0x96c6 4C           |                   LD C,H
0x96c7 29           |                   ADD HL,HL
0x96c8 5D           |                   LD E,L
0x96c9 00           |                   NOP
0x96ca FF           |                   RST $38
0x96cb CB 18        |                   RR B
0x96cd 00           |                   NOP
0x96ce 00           |                   NOP
0x96cf FF           |                   RST $38
0x96d0 00           |                   NOP
0x96d1 00           |                   NOP
0x96d2 00           |                   NOP
0x96d3 00           |                   NOP
0x96d4 00           |                   NOP
0x96d5 0C           |                   INC C
0x96d6 88           |                   ADC A,B
0x96d7 88           |                   ADC A,B
0x96d8 DD 77 FD     |                   LD (IX+$FD),A
0x96db 34           |                   INC (HL)
0x96dc 12           |                   LD (DE),A
0x96dd 00           |                   NOP
0x96de C0           |                   RET NZ
0x96df 00           |                   NOP
0x96e0 07           |                   RLCA
0x96e1 00           |                   NOP
0x96e2 00           |                   NOP
0x96e3 01 00 00     |                   LD BC,$0000
0x96e6 00           |                   NOP
0x96e7 00           |                   NOP
0x96e8 00           |                   NOP
0x96e9 00           |                   NOP
0x96ea 00           |                   NOP
0x96eb 00           |                   NOP
0x96ec 00           |                   NOP
0x96ed 00           |                   NOP
0x96ee 00           |                   NOP
0x96ef 00           |                   NOP
0x96f0 00           |                   NOP
0x96f1 00           |                   NOP
0x96f2 00           |                   NOP
0x96f3 00           |                   NOP
0x96f4 00           |                   NOP
0x96f5 00           |                   NOP
0x96f6 00           |                   NOP
0x96f7 FE FF        |                   CP $FF
0x96f9 FF           |                   RST $38
0x96fa FF           |                   RST $38
0x96fb FF           |                   RST $38
0x96fc FF           |                   RST $38
0x96fd 01 00 00     |                   LD BC,$0000
0x9700 00           |                   NOP
0x9701 00           |                   NOP
0x9702 00           |                   NOP
0x9703 FF           |                   RST $38
0x9704 00           |                   NOP
0x9705 00           |                   NOP
0x9706 00           |                   NOP
0x9707 AA           |                   XOR D
0x9708 EF           |                   RST $28
0x9709 8E           |                   ADC A,(HL)
0x970a 65           |                   LD H,L
0x970b 52           |                   LD D,D
0x970c 52           |                   LD D,D
0x970d 20 5B        |                   JR NZ,$5B
0x970f 52           |                   LD D,D
0x9710 2C           |                   INC L
0x9711 28 48        |                   JR Z,$48
0x9713 4C           |                   LD C,H
0x9714 29           |                   ADD HL,HL
0x9715 5D           |                   LD E,L
0x9716 00           |                   NOP
0x9717 FF           |                   RST $38
0x9718 CB 20        |                   SLA B
0x971a 00           |                   NOP
0x971b 00           |                   NOP
0x971c FF           |                   RST $38
0x971d 00           |                   NOP
0x971e 00           |                   NOP
0x971f 00           |                   NOP
0x9720 00           |                   NOP
0x9721 00           |                   NOP
0x9722 0C           |                   INC C
0x9723 88           |                   ADC A,B
0x9724 88           |                   ADC A,B
0x9725 DD 77 FD     |                   LD (IX+$FD),A
0x9728 34           |                   INC (HL)
0x9729 12           |                   LD (DE),A
0x972a 00           |                   NOP
0x972b C0           |                   RET NZ
0x972c 00           |                   NOP
0x972d 07           |                   RLCA
0x972e 00           |                   NOP
0x972f 00           |                   NOP
0x9730 01 00 00     |                   LD BC,$0000
0x9733 00           |                   NOP
0x9734 00           |                   NOP
0x9735 00           |                   NOP
0x9736 00           |                   NOP
0x9737 00           |                   NOP
0x9738 00           |                   NOP
0x9739 00           |                   NOP
0x973a 00           |                   NOP
0x973b 00           |                   NOP
0x973c 00           |                   NOP
0x973d 00           |                   NOP
0x973e 00           |                   NOP
0x973f 00           |                   NOP
0x9740 00           |                   NOP
0x9741 00           |                   NOP
0x9742 00           |                   NOP
0x9743 00           |                   NOP
0x9744 FE FF        |                   CP $FF
0x9746 FF           |                   RST $38
0x9747 FF           |                   RST $38
0x9748 FF           |                   RST $38
0x9749 FF           |                   RST $38
0x974a 01 00 00     |                   LD BC,$0000
0x974d 00           |                   NOP
0x974e 00           |                   NOP
0x974f 00           |                   NOP
0x9750 FF           |                   RST $38
0x9751 00           |                   NOP
0x9752 00           |                   NOP
0x9753 00           |                   NOP
0x9754 96           |                   SUB A,(HL)
0x9755 41           |                   LD B,C
0x9756 72           |                   LD (HL),D
0x9757 F2 53 4C     |                   JP P,$4C53
0x975a 41           |                   LD B,C
0x975b 20 5B        |                   JR NZ,$5B
0x975d 52           |                   LD D,D
0x975e 2C           |                   INC L
0x975f 28 48        |                   JR Z,$48
0x9761 4C           |                   LD C,H
0x9762 29           |                   ADD HL,HL
0x9763 5D           |                   LD E,L
0x9764 00           |                   NOP
0x9765 FF           |                   RST $38
0x9766 CB 28        |                   SRA B
0x9768 00           |                   NOP
0x9769 00           |                   NOP
0x976a FF           |                   RST $38
0x976b 00           |                   NOP
0x976c 00           |                   NOP
0x976d 00           |                   NOP
0x976e 00           |                   NOP
0x976f 00           |                   NOP
0x9770 0C           |                   INC C
0x9771 88           |                   ADC A,B
0x9772 88           |                   ADC A,B
0x9773 DD 77 FD     |                   LD (IX+$FD),A
0x9776 34           |                   INC (HL)
0x9777 12           |                   LD (DE),A
0x9778 00           |                   NOP
0x9779 C0           |                   RET NZ
0x977a 00           |                   NOP
0x977b 07           |                   RLCA
0x977c 00           |                   NOP
0x977d 00           |                   NOP
0x977e 01 00 00     |                   LD BC,$0000
0x9781 00           |                   NOP
0x9782 00           |                   NOP
0x9783 00           |                   NOP
0x9784 00           |                   NOP
0x9785 00           |                   NOP
0x9786 00           |                   NOP
0x9787 00           |                   NOP
0x9788 00           |                   NOP
0x9789 00           |                   NOP
0x978a 00           |                   NOP
0x978b 00           |                   NOP
0x978c 00           |                   NOP
0x978d 00           |                   NOP
0x978e 00           |                   NOP
0x978f 00           |                   NOP
0x9790 00           |                   NOP
0x9791 00           |                   NOP
0x9792 FE FF        |                   CP $FF
0x9794 FF           |                   RST $38
0x9795 FF           |                   RST $38
0x9796 FF           |                   RST $38
0x9797 FF           |                   RST $38
0x9798 01 00 00     |                   LD BC,$0000
0x979b 00           |                   NOP
0x979c 00           |                   NOP
0x979d 00           |                   NOP
0x979e FF           |                   RST $38
0x979f 00           |                   NOP
0x97a0 00           |                   NOP
0x97a1 00           |                   NOP
0x97a2 1F           |                   RRA
0x97a3 BB           |                   CP E
0x97a4 78           |                   LD A,B
0x97a5 0D           |                   DEC C
0x97a6 53           |                   LD D,E
0x97a7 52           |                   LD D,D
0x97a8 41           |                   LD B,C
0x97a9 20 5B        |                   JR NZ,$5B
0x97ab 52           |                   LD D,D
0x97ac 2C           |                   INC L
0x97ad 28 48        |                   JR Z,$48
0x97af 4C           |                   LD C,H
0x97b0 29           |                   ADD HL,HL
0x97b1 5D           |                   LD E,L
0x97b2 00           |                   NOP
0x97b3 FF           |                   RST $38
0x97b4 CB 30        |                   SLS B
0x97b6 00           |                   NOP
0x97b7 00           |                   NOP
0x97b8 FF           |                   RST $38
0x97b9 00           |                   NOP
0x97ba 00           |                   NOP
0x97bb 00           |                   NOP
0x97bc 00           |                   NOP
0x97bd 00           |                   NOP
0x97be 0C           |                   INC C
0x97bf 88           |                   ADC A,B
0x97c0 88           |                   ADC A,B
0x97c1 DD 77 FD     |                   LD (IX+$FD),A
0x97c4 34           |                   INC (HL)
0x97c5 12           |                   LD (DE),A
0x97c6 00           |                   NOP
0x97c7 C0           |                   RET NZ
0x97c8 00           |                   NOP
0x97c9 07           |                   RLCA
0x97ca 00           |                   NOP
0x97cb 00           |                   NOP
0x97cc 01 00 00     |                   LD BC,$0000
0x97cf 00           |                   NOP
0x97d0 00           |                   NOP
0x97d1 00           |                   NOP
0x97d2 00           |                   NOP
0x97d3 00           |                   NOP
0x97d4 00           |                   NOP
0x97d5 00           |                   NOP
0x97d6 00           |                   NOP
0x97d7 00           |                   NOP
0x97d8 00           |                   NOP
0x97d9 00           |                   NOP
0x97da 00           |                   NOP
0x97db 00           |                   NOP
0x97dc 00           |                   NOP
0x97dd 00           |                   NOP
0x97de 00           |                   NOP
0x97df 00           |                   NOP
0x97e0 FE FF        |                   CP $FF
0x97e2 FF           |                   RST $38
0x97e3 FF           |                   RST $38
0x97e4 FF           |                   RST $38
0x97e5 FF           |                   RST $38
0x97e6 01 00 00     |                   LD BC,$0000
0x97e9 00           |                   NOP
0x97ea 00           |                   NOP
0x97eb 00           |                   NOP
0x97ec FF           |                   RST $38
0x97ed 00           |                   NOP
0x97ee 00           |                   NOP
0x97ef 00           |                   NOP
0x97f0 D7           |                   RST $10
0x97f1 09           |                   ADD HL,BC
0x97f2 A8           |                   XOR B
0x97f3 53           |                   LD D,E
0x97f4 53           |                   LD D,E
0x97f5 4C           |                   LD C,H
0x97f6 49           |                   LD C,C
0x97f7 41           |                   LD B,C
0x97f8 20 5B        |                   JR NZ,$5B
0x97fa 52           |                   LD D,D
0x97fb 2C           |                   INC L
0x97fc 28 48        |                   JR Z,$48
0x97fe 4C           |                   LD C,H
0x97ff 29           |                   ADD HL,HL
0x9800 5D           |                   LD E,L
0x9801 00           |                   NOP
0x9802 FF           |                   RST $38
0x9803 CB 38        |                   SRL B
0x9805 00           |                   NOP
0x9806 00           |                   NOP
0x9807 FF           |                   RST $38
0x9808 00           |                   NOP
0x9809 00           |                   NOP
0x980a 00           |                   NOP
0x980b 00           |                   NOP
0x980c 00           |                   NOP
0x980d 0C           |                   INC C
0x980e 88           |                   ADC A,B
0x980f 88           |                   ADC A,B
0x9810 DD 77 FD     |                   LD (IX+$FD),A
0x9813 34           |                   INC (HL)
0x9814 12           |                   LD (DE),A
0x9815 00           |                   NOP
0x9816 C0           |                   RET NZ
0x9817 00           |                   NOP
0x9818 07           |                   RLCA
0x9819 00           |                   NOP
0x981a 00           |                   NOP
0x981b 01 00 00     |                   LD BC,$0000
0x981e 00           |                   NOP
0x981f 00           |                   NOP
0x9820 00           |                   NOP
0x9821 00           |                   NOP
0x9822 00           |                   NOP
0x9823 00           |                   NOP
0x9824 00           |                   NOP
0x9825 00           |                   NOP
0x9826 00           |                   NOP
0x9827 00           |                   NOP
0x9828 00           |                   NOP
0x9829 00           |                   NOP
0x982a 00           |                   NOP
0x982b 00           |                   NOP
0x982c 00           |                   NOP
0x982d 00           |                   NOP
0x982e 00           |                   NOP
0x982f FE FF        |                   CP $FF
0x9831 FF           |                   RST $38
0x9832 FF           |                   RST $38
0x9833 FF           |                   RST $38
0x9834 FF           |                   RST $38
0x9835 01 00 00     |                   LD BC,$0000
0x9838 00           |                   NOP
0x9839 00           |                   NOP
0x983a 00           |                   NOP
0x983b FF           |                   RST $38
0x983c 00           |                   NOP
0x983d 00           |                   NOP
0x983e 00           |                   NOP
0x983f A1           |                   AND C
0x9840 EA 5B 8C     |                   JP PE,$8C5B
0x9843 53           |                   LD D,E
0x9844 52           |                   LD D,D
0x9845 4C           |                   LD C,H
0x9846 20 5B        |                   JR NZ,$5B
0x9848 52           |                   LD D,D
0x9849 2C           |                   INC L
0x984a 28 48        |                   JR Z,$48
0x984c 4C           |                   LD C,H
0x984d 29           |                   ADD HL,HL
0x984e 5D           |                   LD E,L
0x984f 00           |                   NOP
0x9850 FF           |                   RST $38
0x9851 DD CB 00 06  |                   RLC (IX+${byte:02X})
0x9855 FF           |                   RST $38
0x9856 A0           |                   AND B
0x9857 CC BB EE     |                   CALL Z,$EEBB
0x985a DD           |                   *ILLEGAL*
0x985b 11 44 0C     |                   LD DE,$0C44
0x985e 88           |                   ADC A,B
0x985f 0C           |                   INC C
0x9860 88           |                   ADC A,B
0x9861 00           |                   NOP
0x9862 12           |                   LD (DE),A
0x9863 00           |                   NOP
0x9864 C0           |                   RET NZ
0x9865 20 00        |                   JR NZ,$00
0x9867 00           |                   NOP
0x9868 38 01        |                   JR C,$01
0x986a 00           |                   NOP
0x986b 00           |                   NOP
0x986c 00           |                   NOP
0x986d 00           |                   NOP
0x986e 00           |                   NOP
0x986f 00           |                   NOP
0x9870 00           |                   NOP
0x9871 00           |                   NOP
0x9872 00           |                   NOP
0x9873 00           |                   NOP
0x9874 00           |                   NOP
0x9875 00           |                   NOP
0x9876 00           |                   NOP
0x9877 00           |                   NOP
0x9878 00           |                   NOP
0x9879 00           |                   NOP
0x987a 00           |                   NOP
0x987b 01 00 FE     |                   LD BC,$FE00
0x987e 00           |                   NOP
0x987f 00           |                   NOP
0x9880 00           |                   NOP
0x9881 00           |                   NOP
0x9882 00           |                   NOP
0x9883 00           |                   NOP
0x9884 00           |                   NOP
0x9885 01 00 01     |                   LD BC,$0100
0x9888 00           |                   NOP
0x9889 FF           |                   RST $38
0x988a 00           |                   NOP
0x988b 00           |                   NOP
0x988c 00           |                   NOP
0x988d 1C           |                   INC E
0x988e F5           |                   PUSH AF
0x988f BF           |                   CP A
0x9890 25           |                   DEC H
0x9891 53           |                   LD D,E
0x9892 52           |                   LD D,D
0x9893 4F           |                   LD C,A
0x9894 20 28        |                   JR NZ,$28
0x9896 58           |                   LD E,B
0x9897 59           |                   LD E,C
0x9898 29           |                   ADD HL,HL
0x9899 00           |                   NOP
0x989a FF           |                   RST $38
0x989b DD CB 00 00  |                   RLC (IX+${byte:02X}),B
0x989f FF           |                   RST $38
0x98a0 A0           |                   AND B
0x98a1 CC BB EE     |                   CALL Z,$EEBB
0x98a4 DD           |                   *ILLEGAL*
0x98a5 11 44 0C     |                   LD DE,$0C44
0x98a8 88           |                   ADC A,B
0x98a9 0C           |                   INC C
0x98aa 88           |                   ADC A,B
0x98ab 00           |                   NOP
0x98ac 12           |                   LD (DE),A
0x98ad 00           |                   NOP
0x98ae C0           |                   RET NZ
0x98af 20 00        |                   JR NZ,$00
0x98b1 00           |                   NOP
0x98b2 3F           |                   CCF
0x98b3 01 00 00     |                   LD BC,$0000
0x98b6 00           |                   NOP
0x98b7 00           |                   NOP
0x98b8 00           |                   NOP
0x98b9 00           |                   NOP
0x98ba 00           |                   NOP
0x98bb 00           |                   NOP
0x98bc 00           |                   NOP
0x98bd 00           |                   NOP
0x98be 00           |                   NOP
0x98bf 00           |                   NOP
0x98c0 00           |                   NOP
0x98c1 00           |                   NOP
0x98c2 00           |                   NOP
0x98c3 00           |                   NOP
0x98c4 00           |                   NOP
0x98c5 01 00 FE     |                   LD BC,$FE00
0x98c8 00           |                   NOP
0x98c9 00           |                   NOP
0x98ca 00           |                   NOP
0x98cb 00           |                   NOP
0x98cc 00           |                   NOP
0x98cd 00           |                   NOP
0x98ce 00           |                   NOP
0x98cf 01 00 01     |                   LD BC,$0100
0x98d2 00           |                   NOP
0x98d3 FF           |                   RST $38
0x98d4 00           |                   NOP
0x98d5 00           |                   NOP
0x98d6 00           |                   NOP
0x98d7 2E 23        |                   LD L,$23
0x98d9 10 2B        |                   DJNZ $2B
0x98db 53           |                   LD D,E
0x98dc 52           |                   LD D,D
0x98dd 4F           |                   LD C,A
0x98de 20 28        |                   JR NZ,$28
0x98e0 58           |                   LD E,B
0x98e1 59           |                   LD E,C
0x98e2 29           |                   ADD HL,HL
0x98e3 2C           |                   INC L
0x98e4 52           |                   LD D,D
0x98e5 00           |                   NOP
0x98e6 FF           |                   RST $38
0x98e7 3C           |                   INC A
0x98e8 00           |                   NOP
0x98e9 00           |                   NOP
0x98ea 00           |                   NOP
0x98eb FF           |                   RST $38
0x98ec AA           |                   XOR D
0x98ed CC BB EE     |                   CALL Z,$EEBB
0x98f0 DD           |                   *ILLEGAL*
0x98f1 11 44 88     |                   LD DE,$8844
0x98f4 DD 77 FD     |                   LD (IX+$FD),A
0x98f7 34           |                   INC (HL)
0x98f8 12           |                   LD (DE),A
0x98f9 00           |                   NOP
0x98fa C0           |                   RET NZ
0x98fb 00           |                   NOP
0x98fc 00           |                   NOP
0x98fd 00           |                   NOP
0x98fe 00           |                   NOP
0x98ff 41           |                   LD B,C
0x9900 FF           |                   RST $38
0x9901 00           |                   NOP
0x9902 00           |                   NOP
0x9903 00           |                   NOP
0x9904 00           |                   NOP
0x9905 00           |                   NOP
0x9906 00           |                   NOP
0x9907 00           |                   NOP
0x9908 00           |                   NOP
0x9909 00           |                   NOP
0x990a 00           |                   NOP
0x990b 00           |                   NOP
0x990c 00           |                   NOP
0x990d 00           |                   NOP
0x990e 00           |                   NOP
0x990f 00           |                   NOP
0x9910 00           |                   NOP
0x9911 00           |                   NOP
0x9912 00           |                   NOP
0x9913 BE           |                   CP (HL)
0x9914 00           |                   NOP
0x9915 00           |                   NOP
0x9916 00           |                   NOP
0x9917 00           |                   NOP
0x9918 00           |                   NOP
0x9919 00           |                   NOP
0x991a 00           |                   NOP
0x991b 00           |                   NOP
0x991c 00           |                   NOP
0x991d 00           |                   NOP
0x991e 00           |                   NOP
0x991f 00           |                   NOP
0x9920 00           |                   NOP
0x9921 00           |                   NOP
0x9922 00           |                   NOP
0x9923 A5           |                   AND L
0x9924 5C           |                   LD E,H
0x9925 51           |                   LD D,C
0x9926 56           |                   LD D,(HL)
0x9927 49           |                   LD C,C
0x9928 4E           |                   LD C,(HL)
0x9929 43           |                   LD B,E
0x992a 20 41        |                   JR NZ,$41
0x992c 00           |                   NOP
0x992d FF           |                   RST $38
0x992e 3D           |                   DEC A
0x992f 00           |                   NOP
0x9930 00           |                   NOP
0x9931 00           |                   NOP
0x9932 FF           |                   RST $38
0x9933 AA           |                   XOR D
0x9934 CC BB EE     |                   CALL Z,$EEBB
0x9937 DD           |                   *ILLEGAL*
0x9938 11 44 88     |                   LD DE,$8844
0x993b DD 77 FD     |                   LD (IX+$FD),A
0x993e 34           |                   INC (HL)
0x993f 12           |                   LD (DE),A
0x9940 00           |                   NOP
0x9941 C0           |                   RET NZ
0x9942 00           |                   NOP
0x9943 00           |                   NOP
0x9944 00           |                   NOP
0x9945 00           |                   NOP
0x9946 41           |                   LD B,C
0x9947 FF           |                   RST $38
0x9948 00           |                   NOP
0x9949 00           |                   NOP
0x994a 00           |                   NOP
0x994b 00           |                   NOP
0x994c 00           |                   NOP
0x994d 00           |                   NOP
0x994e 00           |                   NOP
0x994f 00           |                   NOP
0x9950 00           |                   NOP
0x9951 00           |                   NOP
0x9952 00           |                   NOP
0x9953 00           |                   NOP
0x9954 00           |                   NOP
0x9955 00           |                   NOP
0x9956 00           |                   NOP
0x9957 00           |                   NOP
0x9958 00           |                   NOP
0x9959 00           |                   NOP
0x995a BE           |                   CP (HL)
0x995b 00           |                   NOP
0x995c 00           |                   NOP
0x995d 00           |                   NOP
0x995e 00           |                   NOP
0x995f 00           |                   NOP
0x9960 00           |                   NOP
0x9961 00           |                   NOP
0x9962 00           |                   NOP
0x9963 00           |                   NOP
0x9964 00           |                   NOP
0x9965 00           |                   NOP
0x9966 00           |                   NOP
0x9967 00           |                   NOP
0x9968 00           |                   NOP
0x9969 00           |                   NOP
0x996a 36 16        |                   LD (HL),$16
0x996c 74           |                   LD (HL),H
0x996d 75           |                   LD (HL),L
0x996e 44           |                   LD B,H
0x996f 45           |                   LD B,L
0x9970 43           |                   LD B,E
0x9971 20 41        |                   JR NZ,$41
0x9973 00           |                   NOP
0x9974 FF           |                   RST $38
0x9975 04           |                   INC B
0x9976 00           |                   NOP
0x9977 00           |                   NOP
0x9978 00           |                   NOP
0x9979 FF           |                   RST $38
0x997a FF           |                   RST $38
0x997b FF           |                   RST $38
0x997c FF           |                   RST $38
0x997d FF           |                   RST $38
0x997e FF           |                   RST $38
0x997f 0C           |                   INC C
0x9980 88           |                   ADC A,B
0x9981 88           |                   ADC A,B
0x9982 DD 77 FD     |                   LD (IX+$FD),A
0x9985 00           |                   NOP
0x9986 00           |                   NOP
0x9987 00           |                   NOP
0x9988 C0           |                   RET NZ
0x9989 38 00        |                   JR C,$00
0x998b 00           |                   NOP
0x998c 00           |                   NOP
0x998d 41           |                   LD B,C
0x998e 00           |                   NOP
0x998f 00           |                   NOP
0x9990 00           |                   NOP
0x9991 00           |                   NOP
0x9992 00           |                   NOP
0x9993 00           |                   NOP
0x9994 00           |                   NOP
0x9995 00           |                   NOP
0x9996 00           |                   NOP
0x9997 00           |                   NOP
0x9998 00           |                   NOP
0x9999 00           |                   NOP
0x999a 00           |                   NOP
0x999b 00           |                   NOP
0x999c 00           |                   NOP
0x999d 00           |                   NOP
0x999e 00           |                   NOP
0x999f 00           |                   NOP
0x99a0 00           |                   NOP
0x99a1 BE           |                   CP (HL)
0x99a2 FF           |                   RST $38
0x99a3 FF           |                   RST $38
0x99a4 FF           |                   RST $38
0x99a5 FF           |                   RST $38
0x99a6 FF           |                   RST $38
0x99a7 01 00 00     |                   LD BC,$0000
0x99aa 00           |                   NOP
0x99ab 00           |                   NOP
0x99ac 00           |                   NOP
0x99ad FF           |                   RST $38
0x99ae 00           |                   NOP
0x99af 00           |                   NOP
0x99b0 00           |                   NOP
0x99b1 AD           |                   XOR L
0x99b2 45           |                   LD B,L
0x99b3 83           |                   AA,E
0x99b4 FC 49 4E     |                   CALL M,$4E49
0x99b7 43           |                   LD B,E
0x99b8 20 5B        |                   JR NZ,$5B
0x99ba 52           |                   LD D,D
0x99bb 2C           |                   INC L
0x99bc 28 48        |                   JR Z,$48
0x99be 4C           |                   LD C,H
0x99bf 29           |                   ADD HL,HL
0x99c0 5D           |                   LD E,L
0x99c1 00           |                   NOP
0x99c2 FF           |                   RST $38
0x99c3 05           |                   DEC B
0x99c4 00           |                   NOP
0x99c5 00           |                   NOP
0x99c6 00           |                   NOP
0x99c7 FF           |                   RST $38
0x99c8 00           |                   NOP
0x99c9 00           |                   NOP
0x99ca 00           |                   NOP
0x99cb 00           |                   NOP
0x99cc 00           |                   NOP
0x99cd 0C           |                   INC C
0x99ce 88           |                   ADC A,B
0x99cf 88           |                   ADC A,B
0x99d0 DD 77 FD     |                   LD (IX+$FD),A
0x99d3 FF           |                   RST $38
0x99d4 FF           |                   RST $38
0x99d5 00           |                   NOP
0x99d6 C0           |                   RET NZ
0x99d7 38 00        |                   JR C,$00
0x99d9 00           |                   NOP
0x99da 00           |                   NOP
0x99db 41           |                   LD B,C
0x99dc 00           |                   NOP
0x99dd 00           |                   NOP
0x99de 00           |                   NOP
0x99df 00           |                   NOP
0x99e0 00           |                   NOP
0x99e1 00           |                   NOP
0x99e2 00           |                   NOP
0x99e3 00           |                   NOP
0x99e4 00           |                   NOP
0x99e5 00           |                   NOP
0x99e6 00           |                   NOP
0x99e7 00           |                   NOP
0x99e8 00           |                   NOP
0x99e9 00           |                   NOP
0x99ea 00           |                   NOP
0x99eb 00           |                   NOP
0x99ec 00           |                   NOP
0x99ed 00           |                   NOP
0x99ee 00           |                   NOP
0x99ef BE           |                   CP (HL)
0x99f0 FF           |                   RST $38
0x99f1 FF           |                   RST $38
0x99f2 FF           |                   RST $38
0x99f3 FF           |                   RST $38
0x99f4 FF           |                   RST $38
0x99f5 01 00 00     |                   LD BC,$0000
0x99f8 00           |                   NOP
0x99f9 00           |                   NOP
0x99fa 00           |                   NOP
0x99fb FF           |                   RST $38
0x99fc 00           |                   NOP
0x99fd 00           |                   NOP
0x99fe 00           |                   NOP
0x99ff DD           |                   *ILLEGAL*
0x9a00 B3           |                   OR E
0x9a01 EB           |                   EX DE,HL
0x9a02 F9           |                   LD SP,HL
0x9a03 44           |                   LD B,H
0x9a04 45           |                   LD B,L
0x9a05 43           |                   LD B,E
0x9a06 20 5B        |                   JR NZ,$5B
0x9a08 52           |                   LD D,D
0x9a09 2C           |                   INC L
0x9a0a 28 48        |                   JR Z,$48
0x9a0c 4C           |                   LD C,H
0x9a0d 29           |                   ADD HL,HL
0x9a0e 5D           |                   LD E,L
0x9a0f 00           |                   NOP
0x9a10 FF           |                   RST $38
0x9a11 DD 24        |                   INC IXH
0x9a13 00           |                   NOP
0x9a14 00           |                   NOP
0x9a15 FF           |                   RST $38
0x9a16 A0           |                   AND B
0x9a17 CC BB EE     |                   CALL Z,$EEBB
0x9a1a DD           |                   *ILLEGAL*
0x9a1b 11 44 FF     |                   LD DE,$FF44
0x9a1e FF           |                   RST $38
0x9a1f FF           |                   RST $38
0x9a20 FF           |                   RST $38
0x9a21 34           |                   INC (HL)
0x9a22 12           |                   LD (DE),A
0x9a23 00           |                   NOP
0x9a24 C0           |                   RET NZ
0x9a25 20 08        |                   JR NZ,$08
0x9a27 00           |                   NOP
0x9a28 00           |                   NOP
0x9a29 41           |                   LD B,C
0x9a2a 00           |                   NOP
0x9a2b 00           |                   NOP
0x9a2c 00           |                   NOP
0x9a2d 00           |                   NOP
0x9a2e 00           |                   NOP
0x9a2f 00           |                   NOP
0x9a30 00           |                   NOP
0x9a31 00           |                   NOP
0x9a32 00           |                   NOP
0x9a33 00           |                   NOP
0x9a34 00           |                   NOP
0x9a35 00           |                   NOP
0x9a36 00           |                   NOP
0x9a37 00           |                   NOP
0x9a38 00           |                   NOP
0x9a39 00           |                   NOP
0x9a3a 00           |                   NOP
0x9a3b 00           |                   NOP
0x9a3c 00           |                   NOP
0x9a3d BE           |                   CP (HL)
0x9a3e 00           |                   NOP
0x9a3f 00           |                   NOP
0x9a40 00           |                   NOP
0x9a41 00           |                   NOP
0x9a42 00           |                   NOP
0x9a43 00           |                   NOP
0x9a44 00           |                   NOP
0x9a45 FF           |                   RST $38
0x9a46 FF           |                   RST $38
0x9a47 FF           |                   RST $38
0x9a48 FF           |                   RST $38
0x9a49 00           |                   NOP
0x9a4a 00           |                   NOP
0x9a4b 00           |                   NOP
0x9a4c 00           |                   NOP
0x9a4d E5           |                   PUSH HL
0x9a4e A3           |                   AND E
0x9a4f 4C           |                   LD C,H
0x9a50 ED 49        |                   OUT (C),C
0x9a52 4E           |                   LD C,(HL)
0x9a53 43           |                   LD B,E
0x9a54 20 58        |                   JR NZ,$58
0x9a56 00           |                   NOP
0x9a57 FF           |                   RST $38
0x9a58 DD 25        |                   DEC IXH
0x9a5a 00           |                   NOP
0x9a5b 00           |                   NOP
0x9a5c FF           |                   RST $38
0x9a5d A0           |                   AND B
0x9a5e CC BB EE     |                   CALL Z,$EEBB
0x9a61 DD           |                   *ILLEGAL*
0x9a62 11 44 00     |                   LD DE,$0044
0x9a65 00           |                   NOP
0x9a66 00           |                   NOP
0x9a67 00           |                   NOP
0x9a68 34           |                   INC (HL)
0x9a69 12           |                   LD (DE),A
0x9a6a 00           |                   NOP
0x9a6b C0           |                   RET NZ
0x9a6c 20 08        |                   JR NZ,$08
0x9a6e 00           |                   NOP
0x9a6f 00           |                   NOP
0x9a70 41           |                   LD B,C
0x9a71 00           |                   NOP
0x9a72 00           |                   NOP
0x9a73 00           |                   NOP
0x9a74 00           |                   NOP
0x9a75 00           |                   NOP
0x9a76 00           |                   NOP
0x9a77 00           |                   NOP
0x9a78 00           |                   NOP
0x9a79 00           |                   NOP
0x9a7a 00           |                   NOP
0x9a7b 00           |                   NOP
0x9a7c 00           |                   NOP
0x9a7d 00           |                   NOP
0x9a7e 00           |                   NOP
0x9a7f 00           |                   NOP
0x9a80 00           |                   NOP
0x9a81 00           |                   NOP
0x9a82 00           |                   NOP
0x9a83 00           |                   NOP
0x9a84 BE           |                   CP (HL)
0x9a85 00           |                   NOP
0x9a86 00           |                   NOP
0x9a87 00           |                   NOP
0x9a88 00           |                   NOP
0x9a89 00           |                   NOP
0x9a8a 00           |                   NOP
0x9a8b 00           |                   NOP
0x9a8c FF           |                   RST $38
0x9a8d FF           |                   RST $38
0x9a8e FF           |                   RST $38
0x9a8f FF           |                   RST $38
0x9a90 00           |                   NOP
0x9a91 00           |                   NOP
0x9a92 00           |                   NOP
0x9a93 00           |                   NOP
0x9a94 33           |                   INC SP
0x9a95 1C           |                   INC E
0x9a96 7B           |                   LD A,E
0x9a97 F9           |                   LD SP,HL
0x9a98 44           |                   LD B,H
0x9a99 45           |                   LD B,L
0x9a9a 43           |                   LD B,E
0x9a9b 20 58        |                   JR NZ,$58
0x9a9d 00           |                   NOP
0x9a9e FF           |                   RST $38
0x9a9f DD 34 00     |                   INC (IX+$00)
0x9aa2 00           |                   NOP
0x9aa3 FF           |                   RST $38
0x9aa4 AA           |                   XOR D
0x9aa5 CC BB EE     |                   CALL Z,$EEBB
0x9aa8 DD           |                   *ILLEGAL*
0x9aa9 11 44 0C     |                   LD DE,$0C44
0x9aac 88           |                   ADC A,B
0x9aad 0C           |                   INC C
0x9aae 88           |                   ADC A,B
0x9aaf FF           |                   RST $38
0x9ab0 FF           |                   RST $38
0x9ab1 00           |                   NOP
0x9ab2 C0           |                   RET NZ
0x9ab3 20 00        |                   JR NZ,$00
0x9ab5 00           |                   NOP
0x9ab6 00           |                   NOP
0x9ab7 41           |                   LD B,C
0x9ab8 00           |                   NOP
0x9ab9 00           |                   NOP
0x9aba 00           |                   NOP
0x9abb 00           |                   NOP
0x9abc 00           |                   NOP
0x9abd 00           |                   NOP
0x9abe 00           |                   NOP
0x9abf 00           |                   NOP
0x9ac0 00           |                   NOP
0x9ac1 00           |                   NOP
0x9ac2 00           |                   NOP
0x9ac3 01 00 00     |                   LD BC,$0000
0x9ac6 00           |                   NOP
0x9ac7 00           |                   NOP
0x9ac8 00           |                   NOP
0x9ac9 01 00 BE     |                   LD BC,$BE00
0x9acc 00           |                   NOP
0x9acd 00           |                   NOP
0x9ace 00           |                   NOP
0x9acf 00           |                   NOP
0x9ad0 00           |                   NOP
0x9ad1 00           |                   NOP
0x9ad2 00           |                   NOP
0x9ad3 01 00 01     |                   LD BC,$0100
0x9ad6 00           |                   NOP
0x9ad7 FE 00        |                   CP $00
0x9ad9 00           |                   NOP
0x9ada 00           |                   NOP
0x9adb 04           |                   INC B
0x9adc 32 31 53     |                   LD ($5331),A
0x9adf 49           |                   LD C,C
0x9ae0 4E           |                   LD C,(HL)
0x9ae1 43           |                   LD B,E
0x9ae2 20 28        |                   JR NZ,$28
0x9ae4 58           |                   LD E,B
0x9ae5 59           |                   LD E,C
0x9ae6 29           |                   ADD HL,HL
0x9ae7 00           |                   NOP
0x9ae8 FF           |                   RST $38
0x9ae9 DD 35 00     |                   DEC (IX+$00)
0x9aec 00           |                   NOP
0x9aed FF           |                   RST $38
0x9aee AA           |                   XOR D
0x9aef CC BB EE     |                   CALL Z,$EEBB
0x9af2 DD           |                   *ILLEGAL*
0x9af3 11 44 0C     |                   LD DE,$0C44
0x9af6 88           |                   ADC A,B
0x9af7 0C           |                   INC C
0x9af8 88           |                   ADC A,B
0x9af9 00           |                   NOP
0x9afa 00           |                   NOP
0x9afb 00           |                   NOP
0x9afc C0           |                   RET NZ
0x9afd 20 00        |                   JR NZ,$00
0x9aff 00           |                   NOP
0x9b00 00           |                   NOP
0x9b01 41           |                   LD B,C
0x9b02 00           |                   NOP
0x9b03 00           |                   NOP
0x9b04 00           |                   NOP
0x9b05 00           |                   NOP
0x9b06 00           |                   NOP
0x9b07 00           |                   NOP
0x9b08 00           |                   NOP
0x9b09 00           |                   NOP
0x9b0a 00           |                   NOP
0x9b0b 00           |                   NOP
0x9b0c 00           |                   NOP
0x9b0d 01 00 00     |                   LD BC,$0000
0x9b10 00           |                   NOP
0x9b11 00           |                   NOP
0x9b12 00           |                   NOP
0x9b13 01 00 BE     |                   LD BC,$BE00
0x9b16 00           |                   NOP
0x9b17 00           |                   NOP
0x9b18 00           |                   NOP
0x9b19 00           |                   NOP
0x9b1a 00           |                   NOP
0x9b1b 00           |                   NOP
0x9b1c 00           |                   NOP
0x9b1d 01 00 01     |                   LD BC,$0100
0x9b20 00           |                   NOP
0x9b21 FE 00        |                   CP $00
0x9b23 00           |                   NOP
0x9b24 00           |                   NOP
0x9b25 E3           |                   EX (SP),HL
0x9b26 17           |                   RLA
0x9b27 91           |                   SUB A,C
0x9b28 3C           |                   INC A
0x9b29 44           |                   LD B,H
0x9b2a 45           |                   LD B,L
0x9b2b 43           |                   LD B,E
0x9b2c 20 28        |                   JR NZ,$28
0x9b2e 58           |                   LD E,B
0x9b2f 59           |                   LD E,C
0x9b30 29           |                   ADD HL,HL
0x9b31 00           |                   NOP
0x9b32 FF           |                   RST $38
0x9b33 03           |                   INC BC
0x9b34 00           |                   NOP
0x9b35 00           |                   NOP
0x9b36 00           |                   NOP
0x9b37 FF           |                   RST $38
0x9b38 AA           |                   XOR D
0x9b39 FF           |                   RST $38
0x9b3a FF           |                   RST $38
0x9b3b FF           |                   RST $38
0x9b3c FF           |                   RST $38
0x9b3d FF           |                   RST $38
0x9b3e FF           |                   RST $38
0x9b3f 88           |                   ADC A,B
0x9b40 DD 77 FD     |                   LD (IX+$FD),A
0x9b43 34           |                   INC (HL)
0x9b44 12           |                   LD (DE),A
0x9b45 FF           |                   RST $38
0x9b46 FF           |                   RST $38
0x9b47 30 00        |                   JR NC,$00
0x9b49 00           |                   NOP
0x9b4a 00           |                   NOP
0x9b4b 00           |                   NOP
0x9b4c 00           |                   NOP
0x9b4d 01 00 01     |                   LD BC,$0100
0x9b50 00           |                   NOP
0x9b51 01 00 00     |                   LD BC,$0000
0x9b54 00           |                   NOP
0x9b55 00           |                   NOP
0x9b56 00           |                   NOP
0x9b57 00           |                   NOP
0x9b58 00           |                   NOP
0x9b59 01 00 00     |                   LD BC,$0000
0x9b5c 00           |                   NOP
0x9b5d 00           |                   NOP
0x9b5e 00           |                   NOP
0x9b5f FF           |                   RST $38
0x9b60 00           |                   NOP
0x9b61 FE FF        |                   CP $FF
0x9b63 FE FF        |                   CP $FF
0x9b65 FE FF        |                   CP $FF
0x9b67 00           |                   NOP
0x9b68 00           |                   NOP
0x9b69 00           |                   NOP
0x9b6a 00           |                   NOP
0x9b6b 00           |                   NOP
0x9b6c 00           |                   NOP
0x9b6d FE FF        |                   CP $FF
0x9b6f 8C           |                   ADC A,H
0x9b70 D1           |                   POP DE
0x9b71 16 26        |                   LD D,$26
0x9b73 49           |                   LD C,C
0x9b74 4E           |                   LD C,(HL)
0x9b75 43           |                   LD B,E
0x9b76 20 52        |                   JR NZ,$52
0x9b78 52           |                   LD D,D
0x9b79 00           |                   NOP
0x9b7a FF           |                   RST $38
0x9b7b 0B           |                   DEC BC
0x9b7c 00           |                   NOP
0x9b7d 00           |                   NOP
0x9b7e 00           |                   NOP
0x9b7f FF           |                   RST $38
0x9b80 AA           |                   XOR D
0x9b81 00           |                   NOP
0x9b82 00           |                   NOP
0x9b83 00           |                   NOP
0x9b84 00           |                   NOP
0x9b85 00           |                   NOP
0x9b86 00           |                   NOP
0x9b87 88           |                   ADC A,B
0x9b88 DD 77 FD     |                   LD (IX+$FD),A
0x9b8b 34           |                   INC (HL)
0x9b8c 12           |                   LD (DE),A
0x9b8d 00           |                   NOP
0x9b8e 00           |                   NOP
0x9b8f 30 00        |                   JR NC,$00
0x9b91 00           |                   NOP
0x9b92 00           |                   NOP
0x9b93 00           |                   NOP
0x9b94 00           |                   NOP
0x9b95 01 00 01     |                   LD BC,$0100
0x9b98 00           |                   NOP
0x9b99 01 00 00     |                   LD BC,$0000
0x9b9c 00           |                   NOP
0x9b9d 00           |                   NOP
0x9b9e 00           |                   NOP
0x9b9f 00           |                   NOP
0x9ba0 00           |                   NOP
0x9ba1 01 00 00     |                   LD BC,$0000
0x9ba4 00           |                   NOP
0x9ba5 00           |                   NOP
0x9ba6 00           |                   NOP
0x9ba7 FF           |                   RST $38
0x9ba8 00           |                   NOP
0x9ba9 FE FF        |                   CP $FF
0x9bab FE FF        |                   CP $FF
0x9bad FE FF        |                   CP $FF
0x9baf 00           |                   NOP
0x9bb0 00           |                   NOP
0x9bb1 00           |                   NOP
0x9bb2 00           |                   NOP
0x9bb3 00           |                   NOP
0x9bb4 00           |                   NOP
0x9bb5 FE FF        |                   CP $FF
0x9bb7 34           |                   INC (HL)
0x9bb8 3B           |                   DEC SP
0x9bb9 2D           |                   DEC L
0x9bba A0           |                   AND B
0x9bbb 44           |                   LD B,H
0x9bbc 45           |                   LD B,L
0x9bbd 43           |                   LD B,E
0x9bbe 20 52        |                   JR NZ,$52
0x9bc0 52           |                   LD D,D
0x9bc1 00           |                   NOP
0x9bc2 FF           |                   RST $38
0x9bc3 DD 23        |                   INC IX
0x9bc5 00           |                   NOP
0x9bc6 00           |                   NOP
0x9bc7 FF           |                   RST $38
0x9bc8 AA           |                   XOR D
0x9bc9 CC BB EE     |                   CALL Z,$EEBB
0x9bcc DD           |                   *ILLEGAL*
0x9bcd 11 44 FF     |                   LD DE,$FF44
0x9bd0 FF           |                   RST $38
0x9bd1 FF           |                   RST $38
0x9bd2 FF           |                   RST $38
0x9bd3 34           |                   INC (HL)
0x9bd4 12           |                   LD (DE),A
0x9bd5 00           |                   NOP
0x9bd6 C0           |                   RET NZ
0x9bd7 20 00        |                   JR NZ,$00
0x9bd9 00           |                   NOP
0x9bda 00           |                   NOP
0x9bdb 00           |                   NOP
0x9bdc 00           |                   NOP
0x9bdd 00           |                   NOP
0x9bde 00           |                   NOP
0x9bdf 00           |                   NOP
0x9be0 00           |                   NOP
0x9be1 00           |                   NOP
0x9be2 00           |                   NOP
0x9be3 01 00 01     |                   LD BC,$0100
0x9be6 00           |                   NOP
0x9be7 00           |                   NOP
0x9be8 00           |                   NOP
0x9be9 00           |                   NOP
0x9bea 00           |                   NOP
0x9beb 00           |                   NOP
0x9bec 00           |                   NOP
0x9bed 00           |                   NOP
0x9bee 00           |                   NOP
0x9bef FF           |                   RST $38
0x9bf0 00           |                   NOP
0x9bf1 00           |                   NOP
0x9bf2 00           |                   NOP
0x9bf3 00           |                   NOP
0x9bf4 00           |                   NOP
0x9bf5 00           |                   NOP
0x9bf6 00           |                   NOP
0x9bf7 FE FF        |                   CP $FF
0x9bf9 FE FF        |                   CP $FF
0x9bfb 00           |                   NOP
0x9bfc 00           |                   NOP
0x9bfd 00           |                   NOP
0x9bfe 00           |                   NOP
0x9bff E1           |                   POP HL
0x9c00 32 D9 3B     |                   LD ($3BD9),A
0x9c03 49           |                   LD C,C
0x9c04 4E           |                   LD C,(HL)
0x9c05 43           |                   LD B,E
0x9c06 20 58        |                   JR NZ,$58
0x9c08 59           |                   LD E,C
0x9c09 00           |                   NOP
0x9c0a FF           |                   RST $38
0x9c0b DD 2B        |                   DEC IX
0x9c0d 00           |                   NOP
0x9c0e 00           |                   NOP
0x9c0f FF           |                   RST $38
0x9c10 AA           |                   XOR D
0x9c11 CC BB EE     |                   CALL Z,$EEBB
0x9c14 DD           |                   *ILLEGAL*
0x9c15 11 44 00     |                   LD DE,$0044
0x9c18 00           |                   NOP
0x9c19 00           |                   NOP
0x9c1a 00           |                   NOP
0x9c1b 34           |                   INC (HL)
0x9c1c 12           |                   LD (DE),A
0x9c1d 00           |                   NOP
0x9c1e C0           |                   RET NZ
0x9c1f 20 00        |                   JR NZ,$00
0x9c21 00           |                   NOP
0x9c22 00           |                   NOP
0x9c23 00           |                   NOP
0x9c24 00           |                   NOP
0x9c25 00           |                   NOP
0x9c26 00           |                   NOP
0x9c27 00           |                   NOP
0x9c28 00           |                   NOP
0x9c29 00           |                   NOP
0x9c2a 00           |                   NOP
0x9c2b 01 00 01     |                   LD BC,$0100
0x9c2e 00           |                   NOP
0x9c2f 00           |                   NOP
0x9c30 00           |                   NOP
0x9c31 00           |                   NOP
0x9c32 00           |                   NOP
0x9c33 00           |                   NOP
0x9c34 00           |                   NOP
0x9c35 00           |                   NOP
0x9c36 00           |                   NOP
0x9c37 FF           |                   RST $38
0x9c38 00           |                   NOP
0x9c39 00           |                   NOP
0x9c3a 00           |                   NOP
0x9c3b 00           |                   NOP
0x9c3c 00           |                   NOP
0x9c3d 00           |                   NOP
0x9c3e 00           |                   NOP
0x9c3f FE FF        |                   CP $FF
0x9c41 FE FF        |                   CP $FF
0x9c43 00           |                   NOP
0x9c44 00           |                   NOP
0x9c45 00           |                   NOP
0x9c46 00           |                   NOP
0x9c47 D3 D0        |                   OUT ($D0),A
0x9c49 7C           |                   LD A,H
0x9c4a 72           |                   LD (HL),D
0x9c4b 44           |                   LD B,H
0x9c4c 45           |                   LD B,L
0x9c4d 43           |                   LD B,E
0x9c4e 20 58        |                   JR NZ,$58
0x9c50 59           |                   LD E,C
0x9c51 00           |                   NOP
0x9c52 FF           |                   RST $38
0x9c53 09           |                   ADD HL,BC
0x9c54 00           |                   NOP
0x9c55 00           |                   NOP
0x9c56 00           |                   NOP
0x9c57 FF           |                   RST $38
0x9c58 AA           |                   XOR D
0x9c59 00           |                   NOP
0x9c5a 00           |                   NOP
0x9c5b 00           |                   NOP
0x9c5c 00           |                   NOP
0x9c5d 00           |                   NOP
0x9c5e 00           |                   NOP
0x9c5f 88           |                   ADC A,B
0x9c60 DD 77 FD     |                   LD (IX+$FD),A
0x9c63 34           |                   INC (HL)
0x9c64 12           |                   LD (DE),A
0x9c65 00           |                   NOP
0x9c66 00           |                   NOP
0x9c67 30 00        |                   JR NC,$00
0x9c69 00           |                   NOP
0x9c6a 00           |                   NOP
0x9c6b 00           |                   NOP
0x9c6c 00           |                   NOP
0x9c6d 00           |                   NOP
0x9c6e 00           |                   NOP
0x9c6f 00           |                   NOP
0x9c70 00           |                   NOP
0x9c71 00           |                   NOP
0x9c72 C8           |                   RET Z
0x9c73 00           |                   NOP
0x9c74 00           |                   NOP
0x9c75 00           |                   NOP
0x9c76 00           |                   NOP
0x9c77 00           |                   NOP
0x9c78 00           |                   NOP
0x9c79 00           |                   NOP
0x9c7a 00           |                   NOP
0x9c7b 00           |                   NOP
0x9c7c 00           |                   NOP
0x9c7d 00           |                   NOP
0x9c7e 00           |                   NOP
0x9c7f FF           |                   RST $38
0x9c80 00           |                   NOP
0x9c81 FF           |                   RST $38
0x9c82 FF           |                   RST $38
0x9c83 FF           |                   RST $38
0x9c84 FF           |                   RST $38
0x9c85 FF           |                   RST $38
0x9c86 37           |                   SCF
0x9c87 00           |                   NOP
0x9c88 00           |                   NOP
0x9c89 00           |                   NOP
0x9c8a 00           |                   NOP
0x9c8b 00           |                   NOP
0x9c8c 00           |                   NOP
0x9c8d FF           |                   RST $38
0x9c8e FF           |                   RST $38
0x9c8f BF           |                   CP A
0x9c90 D3 BA        |                   OUT ($BA),A
0x9c92 45           |                   LD B,L
0x9c93 41           |                   LD B,C
0x9c94 44           |                   LD B,H
0x9c95 44           |                   LD B,H
0x9c96 20 48        |                   JR NZ,$48
0x9c98 4C           |                   LD C,H
0x9c99 2C           |                   INC L
0x9c9a 52           |                   LD D,D
0x9c9b 52           |                   LD D,D
0x9c9c 00           |                   NOP
0x9c9d FF           |                   RST $38
0x9c9e DD 09        |                   ADD IX,BC
0x9ca0 00           |                   NOP
0x9ca1 00           |                   NOP
0x9ca2 FF           |                   RST $38
0x9ca3 AA           |                   XOR D
0x9ca4 00           |                   NOP
0x9ca5 00           |                   NOP
0x9ca6 00           |                   NOP
0x9ca7 00           |                   NOP
0x9ca8 11 44 00     |                   LD DE,$0044
0x9cab 00           |                   NOP
0x9cac 77           |                   LD (HL),A
0x9cad FD 34 12     |                   INC (IY+$12)
0x9cb0 00           |                   NOP
0x9cb1 00           |                   NOP
0x9cb2 00           |                   NOP
0x9cb3 30 00        |                   JR NC,$00
0x9cb5 00           |                   NOP
0x9cb6 00           |                   NOP
0x9cb7 00           |                   NOP
0x9cb8 00           |                   NOP
0x9cb9 00           |                   NOP
0x9cba 00           |                   NOP
0x9cbb 00           |                   NOP
0x9cbc 00           |                   NOP
0x9cbd 00           |                   NOP
0x9cbe 00           |                   NOP
0x9cbf C8           |                   RET Z
0x9cc0 00           |                   NOP
0x9cc1 00           |                   NOP
0x9cc2 00           |                   NOP
0x9cc3 00           |                   NOP
0x9cc4 00           |                   NOP
0x9cc5 00           |                   NOP
0x9cc6 00           |                   NOP
0x9cc7 00           |                   NOP
0x9cc8 00           |                   NOP
0x9cc9 00           |                   NOP
0x9cca FF           |                   RST $38
0x9ccb 00           |                   NOP
0x9ccc FF           |                   RST $38
0x9ccd FF           |                   RST $38
0x9cce FF           |                   RST $38
0x9ccf FF           |                   RST $38
0x9cd0 00           |                   NOP
0x9cd1 00           |                   NOP
0x9cd2 FF           |                   RST $38
0x9cd3 37           |                   SCF
0x9cd4 00           |                   NOP
0x9cd5 00           |                   NOP
0x9cd6 00           |                   NOP
0x9cd7 00           |                   NOP
0x9cd8 FF           |                   RST $38
0x9cd9 FF           |                   RST $38
0x9cda 4C           |                   LD C,H
0x9cdb 9B           |                   SBC A,E
0x9cdc BA           |                   CP D
0x9cdd 44           |                   LD B,H
0x9cde 41           |                   LD B,C
0x9cdf 44           |                   LD B,H
0x9ce0 44           |                   LD B,H
0x9ce1 20 49        |                   JR NZ,$49
0x9ce3 58           |                   LD E,B
0x9ce4 2C           |                   INC L
0x9ce5 52           |                   LD D,D
0x9ce6 52           |                   LD D,D
0x9ce7 00           |                   NOP
0x9ce8 FF           |                   RST $38
0x9ce9 FD 09        |                   ADD IY,BC
0x9ceb 00           |                   NOP
0x9cec 00           |                   NOP
0x9ced FF           |                   RST $38
0x9cee AA           |                   XOR D
0x9cef 00           |                   NOP
0x9cf0 00           |                   NOP
0x9cf1 00           |                   NOP
0x9cf2 00           |                   NOP
0x9cf3 11 44 88     |                   LD DE,$8844
0x9cf6 DD           |                   *ILLEGAL*
0x9cf7 00           |                   NOP
0x9cf8 00           |                   NOP
0x9cf9 34           |                   INC (HL)
0x9cfa 12           |                   LD (DE),A
0x9cfb 00           |                   NOP
0x9cfc 00           |                   NOP
0x9cfd 00           |                   NOP
0x9cfe 30 00        |                   JR NC,$00
0x9d00 00           |                   NOP
0x9d01 00           |                   NOP
0x9d02 00           |                   NOP
0x9d03 00           |                   NOP
0x9d04 00           |                   NOP
0x9d05 00           |                   NOP
0x9d06 00           |                   NOP
0x9d07 00           |                   NOP
0x9d08 00           |                   NOP
0x9d09 00           |                   NOP
0x9d0a 00           |                   NOP
0x9d0b 00           |                   NOP
0x9d0c C8           |                   RET Z
0x9d0d 00           |                   NOP
0x9d0e 00           |                   NOP
0x9d0f 00           |                   NOP
0x9d10 00           |                   NOP
0x9d11 00           |                   NOP
0x9d12 00           |                   NOP
0x9d13 00           |                   NOP
0x9d14 00           |                   NOP
0x9d15 FF           |                   RST $38
0x9d16 00           |                   NOP
0x9d17 FF           |                   RST $38
0x9d18 FF           |                   RST $38
0x9d19 FF           |                   RST $38
0x9d1a FF           |                   RST $38
0x9d1b 00           |                   NOP
0x9d1c 00           |                   NOP
0x9d1d 00           |                   NOP
0x9d1e 00           |                   NOP
0x9d1f FF           |                   RST $38
0x9d20 37           |                   SCF
0x9d21 00           |                   NOP
0x9d22 00           |                   NOP
0x9d23 FF           |                   RST $38
0x9d24 FF           |                   RST $38
0x9d25 5B           |                   LD E,E
0x9d26 74           |                   LD (HL),H
0x9d27 C0           |                   RET NZ
0x9d28 FE 41        |                   CP $41
0x9d2a 44           |                   LD B,H
0x9d2b 44           |                   LD B,H
0x9d2c 20 49        |                   JR NZ,$49
0x9d2e 59           |                   LD E,C
0x9d2f 2C           |                   INC L
0x9d30 52           |                   LD D,D
0x9d31 52           |                   LD D,D
0x9d32 00           |                   NOP
0x9d33 FF           |                   RST $38
0x9d34 ED 4A        |                   ADC HL,BC
0x9d36 00           |                   NOP
0x9d37 00           |                   NOP
0x9d38 FF           |                   RST $38
0x9d39 AA           |                   XOR D
0x9d3a 00           |                   NOP
0x9d3b 00           |                   NOP
0x9d3c 00           |                   NOP
0x9d3d 00           |                   NOP
0x9d3e 00           |                   NOP
0x9d3f 00           |                   NOP
0x9d40 88           |                   ADC A,B
0x9d41 DD 77 FD     |                   LD (IX+$FD),A
0x9d44 34           |                   INC (HL)
0x9d45 12           |                   LD (DE),A
0x9d46 00           |                   NOP
0x9d47 00           |                   NOP
0x9d48 00           |                   NOP
0x9d49 30 00        |                   JR NC,$00
0x9d4b 00           |                   NOP
0x9d4c 01 00 00     |                   LD BC,$0000
0x9d4f 00           |                   NOP
0x9d50 00           |                   NOP
0x9d51 00           |                   NOP
0x9d52 00           |                   NOP
0x9d53 C8           |                   RET Z
0x9d54 00           |                   NOP
0x9d55 00           |                   NOP
0x9d56 00           |                   NOP
0x9d57 00           |                   NOP
0x9d58 00           |                   NOP
0x9d59 00           |                   NOP
0x9d5a 00           |                   NOP
0x9d5b 00           |                   NOP
0x9d5c 00           |                   NOP
0x9d5d 00           |                   NOP
0x9d5e 00           |                   NOP
0x9d5f 00           |                   NOP
0x9d60 FE 00        |                   CP $00
0x9d62 FF           |                   RST $38
0x9d63 FF           |                   RST $38
0x9d64 FF           |                   RST $38
0x9d65 FF           |                   RST $38
0x9d66 FF           |                   RST $38
0x9d67 37           |                   SCF
0x9d68 00           |                   NOP
0x9d69 00           |                   NOP
0x9d6a 00           |                   NOP
0x9d6b 00           |                   NOP
0x9d6c 00           |                   NOP
0x9d6d 00           |                   NOP
0x9d6e FF           |                   RST $38
0x9d6f FF           |                   RST $38
0x9d70 6C           |                   LD L,H
0x9d71 72           |                   LD (HL),D
0x9d72 46           |                   LD B,(HL)
0x9d73 DF           |                   RST $18
0x9d74 41           |                   LD B,C
0x9d75 44           |                   LD B,H
0x9d76 43           |                   LD B,E
0x9d77 20 48        |                   JR NZ,$48
0x9d79 4C           |                   LD C,H
0x9d7a 2C           |                   INC L
0x9d7b 52           |                   LD D,D
0x9d7c 52           |                   LD D,D
0x9d7d 00           |                   NOP
0x9d7e FF           |                   RST $38
0x9d7f ED 42        |                   SBC HL,BC
0x9d81 00           |                   NOP
0x9d82 00           |                   NOP
0x9d83 FF           |                   RST $38
0x9d84 AA           |                   XOR D
0x9d85 00           |                   NOP
0x9d86 00           |                   NOP
0x9d87 00           |                   NOP
0x9d88 00           |                   NOP
0x9d89 00           |                   NOP
0x9d8a 00           |                   NOP
0x9d8b 88           |                   ADC A,B
0x9d8c DD 77 FD     |                   LD (IX+$FD),A
0x9d8f 34           |                   INC (HL)
0x9d90 12           |                   LD (DE),A
0x9d91 00           |                   NOP
0x9d92 00           |                   NOP
0x9d93 00           |                   NOP
0x9d94 30 00        |                   JR NC,$00
0x9d96 00           |                   NOP
0x9d97 01 00 00     |                   LD BC,$0000
0x9d9a 00           |                   NOP
0x9d9b 00           |                   NOP
0x9d9c 00           |                   NOP
0x9d9d 00           |                   NOP
0x9d9e C8           |                   RET Z
0x9d9f 00           |                   NOP
0x9da0 00           |                   NOP
0x9da1 00           |                   NOP
0x9da2 00           |                   NOP
0x9da3 00           |                   NOP
0x9da4 00           |                   NOP
0x9da5 00           |                   NOP
0x9da6 00           |                   NOP
0x9da7 00           |                   NOP
0x9da8 00           |                   NOP
0x9da9 00           |                   NOP
0x9daa 00           |                   NOP
0x9dab FE 00        |                   CP $00
0x9dad FF           |                   RST $38
0x9dae FF           |                   RST $38
0x9daf FF           |                   RST $38
0x9db0 FF           |                   RST $38
0x9db1 FF           |                   RST $38
0x9db2 37           |                   SCF
0x9db3 00           |                   NOP
0x9db4 00           |                   NOP
0x9db5 00           |                   NOP
0x9db6 00           |                   NOP
0x9db7 00           |                   NOP
0x9db8 00           |                   NOP
0x9db9 FF           |                   RST $38
0x9dba FF           |                   RST $38
0x9dbb 8C           |                   ADC A,H
0x9dbc 5F           |                   LD E,A
0x9dbd F2 8A 53     |                   JP P,$538A
0x9dc0 42           |                   LD B,D
0x9dc1 43           |                   LD B,E
0x9dc2 20 48        |                   JR NZ,$48
0x9dc4 4C           |                   LD C,H
0x9dc5 2C           |                   INC L
0x9dc6 52           |                   LD D,D
0x9dc7 52           |                   LD D,D
0x9dc8 00           |                   NOP
0x9dc9 FF           |                   RST $38
0x9dca CB 47        |                   BIT 0,A
0x9dcc 00           |                   NOP
0x9dcd 00           |                   NOP
0x9dce FF           |                   RST $38
0x9dcf AA           |                   XOR D
0x9dd0 CC BB EE     |                   CALL Z,$EEBB
0x9dd3 DD           |                   *ILLEGAL*
0x9dd4 11 44 88     |                   LD DE,$8844
0x9dd7 DD 77 FD     |                   LD (IX+$FD),A
0x9dda 34           |                   INC (HL)
0x9ddb 12           |                   LD (DE),A
0x9ddc 00           |                   NOP
0x9ddd C0           |                   RET NZ
0x9dde 00           |                   NOP
0x9ddf 38 00        |                   JR C,$00
0x9de1 00           |                   NOP
0x9de2 28 28        |                   JR Z,$28
0x9de4 00           |                   NOP
0x9de5 00           |                   NOP
0x9de6 00           |                   NOP
0x9de7 00           |                   NOP
0x9de8 00           |                   NOP
0x9de9 00           |                   NOP
0x9dea 00           |                   NOP
0x9deb 00           |                   NOP
0x9dec 00           |                   NOP
0x9ded 00           |                   NOP
0x9dee 00           |                   NOP
0x9def 00           |                   NOP
0x9df0 00           |                   NOP
0x9df1 00           |                   NOP
0x9df2 00           |                   NOP
0x9df3 00           |                   NOP
0x9df4 00           |                   NOP
0x9df5 00           |                   NOP
0x9df6 D7           |                   RST $10
0x9df7 D7           |                   RST $10
0x9df8 00           |                   NOP
0x9df9 00           |                   NOP
0x9dfa 00           |                   NOP
0x9dfb 00           |                   NOP
0x9dfc 00           |                   NOP
0x9dfd 00           |                   NOP
0x9dfe 00           |                   NOP
0x9dff 00           |                   NOP
0x9e00 00           |                   NOP
0x9e01 00           |                   NOP
0x9e02 00           |                   NOP
0x9e03 00           |                   NOP
0x9e04 00           |                   NOP
0x9e05 00           |                   NOP
0x9e06 3A 19 14     |                   LD A,($1419)
0x9e09 E7           |                   RST $20
0x9e0a 42           |                   LD B,D
0x9e0b 49           |                   LD C,C
0x9e0c 54           |                   LD D,H
0x9e0d 20 4E        |                   JR NZ,$4E
0x9e0f 2C           |                   INC L
0x9e10 41           |                   LD B,C
0x9e11 00           |                   NOP
0x9e12 FF           |                   RST $38
0x9e13 CB 46        |                   BIT 0,(HL)
0x9e15 00           |                   NOP
0x9e16 00           |                   NOP
0x9e17 FF           |                   RST $38
0x9e18 AA           |                   XOR D
0x9e19 CC BB EE     |                   CALL Z,$EEBB
0x9e1c DD           |                   *ILLEGAL*
0x9e1d 0C           |                   INC C
0x9e1e 88           |                   ADC A,B
0x9e1f 88           |                   ADC A,B
0x9e20 DD 77 FD     |                   LD (IX+$FD),A
0x9e23 34           |                   INC (HL)
0x9e24 12           |                   LD (DE),A
0x9e25 00           |                   NOP
0x9e26 C0           |                   RET NZ
0x9e27 00           |                   NOP
0x9e28 38 00        |                   JR C,$00
0x9e2a 00           |                   NOP
0x9e2b 28 00        |                   JR Z,$00
0x9e2d 00           |                   NOP
0x9e2e 00           |                   NOP
0x9e2f 00           |                   NOP
0x9e30 00           |                   NOP
0x9e31 00           |                   NOP
0x9e32 00           |                   NOP
0x9e33 00           |                   NOP
0x9e34 00           |                   NOP
0x9e35 00           |                   NOP
0x9e36 00           |                   NOP
0x9e37 28 00        |                   JR Z,$00
0x9e39 00           |                   NOP
0x9e3a 00           |                   NOP
0x9e3b 00           |                   NOP
0x9e3c 00           |                   NOP
0x9e3d 00           |                   NOP
0x9e3e 00           |                   NOP
0x9e3f D7           |                   RST $10
0x9e40 00           |                   NOP
0x9e41 00           |                   NOP
0x9e42 00           |                   NOP
0x9e43 00           |                   NOP
0x9e44 00           |                   NOP
0x9e45 01 00 00     |                   LD BC,$0000
0x9e48 00           |                   NOP
0x9e49 00           |                   NOP
0x9e4a 00           |                   NOP
0x9e4b D7           |                   RST $10
0x9e4c 00           |                   NOP
0x9e4d 00           |                   NOP
0x9e4e 00           |                   NOP
0x9e4f 7F           |                   LD A,A
0x9e50 6E           |                   LD L,(HL)
0x9e51 6F           |                   LD L,A
0x9e52 AE           |                   XOR (HL)
0x9e53 42           |                   LD B,D
0x9e54 49           |                   LD C,C
0x9e55 54           |                   LD D,H
0x9e56 20 4E        |                   JR NZ,$4E
0x9e58 2C           |                   INC L
0x9e59 28 48        |                   JR Z,$48
0x9e5b 4C           |                   LD C,H
0x9e5c 29           |                   ADD HL,HL
0x9e5d 00           |                   NOP
0x9e5e FF           |                   RST $38
0x9e5f CB 40        |                   BIT 0,B
0x9e61 00           |                   NOP
0x9e62 00           |                   NOP
0x9e63 FF           |                   RST $38
0x9e64 AA           |                   XOR D
0x9e65 CC BB EE     |                   CALL Z,$EEBB
0x9e68 DD           |                   *ILLEGAL*
0x9e69 0C           |                   INC C
0x9e6a 88           |                   ADC A,B
0x9e6b 88           |                   ADC A,B
0x9e6c DD 77 FD     |                   LD (IX+$FD),A
0x9e6f 34           |                   INC (HL)
0x9e70 12           |                   LD (DE),A
0x9e71 00           |                   NOP
0x9e72 C0           |                   RET NZ
0x9e73 00           |                   NOP
0x9e74 3F           |                   CCF
0x9e75 00           |                   NOP
0x9e76 00           |                   NOP
0x9e77 28 00        |                   JR Z,$00
0x9e79 00           |                   NOP
0x9e7a 00           |                   NOP
0x9e7b 00           |                   NOP
0x9e7c 00           |                   NOP
0x9e7d 00           |                   NOP
0x9e7e 00           |                   NOP
0x9e7f 00           |                   NOP
0x9e80 00           |                   NOP
0x9e81 00           |                   NOP
0x9e82 00           |                   NOP
0x9e83 00           |                   NOP
0x9e84 00           |                   NOP
0x9e85 00           |                   NOP
0x9e86 00           |                   NOP
0x9e87 00           |                   NOP
0x9e88 00           |                   NOP
0x9e89 00           |                   NOP
0x9e8a 00           |                   NOP
0x9e8b D7           |                   RST $10
0x9e8c 00           |                   NOP
0x9e8d FF           |                   RST $38
0x9e8e FF           |                   RST $38
0x9e8f FF           |                   RST $38
0x9e90 FF           |                   RST $38
0x9e91 00           |                   NOP
0x9e92 00           |                   NOP
0x9e93 00           |                   NOP
0x9e94 00           |                   NOP
0x9e95 00           |                   NOP
0x9e96 00           |                   NOP
0x9e97 00           |                   NOP
0x9e98 00           |                   NOP
0x9e99 00           |                   NOP
0x9e9a 00           |                   NOP
0x9e9b B0           |                   OR B
0x9e9c 77           |                   LD (HL),A
0x9e9d 79           |                   LD A,C
0x9e9e 01 42 49     |                   LD BC,$4942
0x9ea1 54           |                   LD D,H
0x9ea2 20 4E        |                   JR NZ,$4E
0x9ea4 2C           |                   INC L
0x9ea5 5B           |                   LD E,E
0x9ea6 52           |                   LD D,D
0x9ea7 2C           |                   INC L
0x9ea8 28 48        |                   JR Z,$48
0x9eaa 4C           |                   LD C,H
0x9eab 29           |                   ADD HL,HL
0x9eac 5D           |                   LD E,L
0x9ead 00           |                   NOP
0x9eae FF           |                   RST $38
0x9eaf DD CB 00 46  |                   BIT 0,(IX+${byte:02X})
0x9eb3 FF           |                   RST $38
0x9eb4 AA           |                   XOR D
0x9eb5 CC BB EE     |                   CALL Z,$EEBB
0x9eb8 DD           |                   *ILLEGAL*
0x9eb9 11 44 0C     |                   LD DE,$0C44
0x9ebc 88           |                   ADC A,B
0x9ebd 0C           |                   INC C
0x9ebe 88           |                   ADC A,B
0x9ebf 34           |                   INC (HL)
0x9ec0 12           |                   LD (DE),A
0x9ec1 00           |                   NOP
0x9ec2 C0           |                   RET NZ
0x9ec3 20 00        |                   JR NZ,$00
0x9ec5 00           |                   NOP
0x9ec6 38 28        |                   JR C,$28
0x9ec8 00           |                   NOP
0x9ec9 00           |                   NOP
0x9eca 00           |                   NOP
0x9ecb 00           |                   NOP
0x9ecc 00           |                   NOP
0x9ecd 00           |                   NOP
0x9ece 00           |                   NOP
0x9ecf 00           |                   NOP
0x9ed0 00           |                   NOP
0x9ed1 00           |                   NOP
0x9ed2 00           |                   NOP
0x9ed3 00           |                   NOP
0x9ed4 00           |                   NOP
0x9ed5 00           |                   NOP
0x9ed6 00           |                   NOP
0x9ed7 00           |                   NOP
0x9ed8 00           |                   NOP
0x9ed9 01 00 D7     |                   LD BC,$D700
0x9edc 00           |                   NOP
0x9edd 00           |                   NOP
0x9ede 00           |                   NOP
0x9edf 00           |                   NOP
0x9ee0 00           |                   NOP
0x9ee1 00           |                   NOP
0x9ee2 00           |                   NOP
0x9ee3 01 00 01     |                   LD BC,$0100
0x9ee6 00           |                   NOP
0x9ee7 FF           |                   RST $38
0x9ee8 00           |                   NOP
0x9ee9 00           |                   NOP
0x9eea 00           |                   NOP
0x9eeb AC           |                   XOR H
0x9eec 37           |                   SCF
0x9eed 5D           |                   LD E,L
0x9eee 19           |                   ADD HL,DE
0x9eef 42           |                   LD B,D
0x9ef0 49           |                   LD C,C
0x9ef1 54           |                   LD D,H
0x9ef2 20 4E        |                   JR NZ,$4E
0x9ef4 2C           |                   INC L
0x9ef5 28 58        |                   JR Z,$58
0x9ef7 59           |                   LD E,C
0x9ef8 29           |                   ADD HL,HL
0x9ef9 00           |                   NOP
0x9efa FF           |                   RST $38
0x9efb DD CB 00 40  |                   BIT 0,(IX+${byte:02X})
0x9eff FF           |                   RST $38
0x9f00 AA           |                   XOR D
0x9f01 CC BB EE     |                   CALL Z,$EEBB
0x9f04 DD           |                   *ILLEGAL*
0x9f05 11 44 0C     |                   LD DE,$0C44
0x9f08 88           |                   ADC A,B
0x9f09 0C           |                   INC C
0x9f0a 88           |                   ADC A,B
0x9f0b 34           |                   INC (HL)
0x9f0c 12           |                   LD (DE),A
0x9f0d 00           |                   NOP
0x9f0e C0           |                   RET NZ
0x9f0f 20 00        |                   JR NZ,$00
0x9f11 00           |                   NOP
0x9f12 3F           |                   CCF
0x9f13 28 00        |                   JR Z,$00
0x9f15 00           |                   NOP
0x9f16 00           |                   NOP
0x9f17 00           |                   NOP
0x9f18 00           |                   NOP
0x9f19 00           |                   NOP
0x9f1a 00           |                   NOP
0x9f1b 00           |                   NOP
0x9f1c 00           |                   NOP
0x9f1d 00           |                   NOP
0x9f1e 00           |                   NOP
0x9f1f 00           |                   NOP
0x9f20 00           |                   NOP
0x9f21 00           |                   NOP
0x9f22 00           |                   NOP
0x9f23 00           |                   NOP
0x9f24 00           |                   NOP
0x9f25 01 00 D7     |                   LD BC,$D700
0x9f28 00           |                   NOP
0x9f29 00           |                   NOP
0x9f2a 00           |                   NOP
0x9f2b 00           |                   NOP
0x9f2c 00           |                   NOP
0x9f2d 00           |                   NOP
0x9f2e 00           |                   NOP
0x9f2f 01 00 01     |                   LD BC,$0100
0x9f32 00           |                   NOP
0x9f33 FF           |                   RST $38
0x9f34 00           |                   NOP
0x9f35 00           |                   NOP
0x9f36 00           |                   NOP
0x9f37 8E           |                   ADC A,(HL)
0x9f38 78           |                   LD A,B
0x9f39 E9           |                   JP (HL)
0x9f3a 22 42 49     |                   LD ($4942),HL
0x9f3d 54           |                   LD D,H
0x9f3e 20 4E        |                   JR NZ,$4E
0x9f40 2C           |                   INC L
0x9f41 28 58        |                   JR Z,$58
0x9f43 59           |                   LD E,C
0x9f44 29           |                   ADD HL,HL
0x9f45 2C           |                   INC L
0x9f46 2D           |                   DEC L
0x9f47 00           |                   NOP
0x9f48 FF           |                   RST $38
0x9f49 CB C7        |                   SET 0,A
0x9f4b 00           |                   NOP
0x9f4c 00           |                   NOP
0x9f4d FF           |                   RST $38
0x9f4e AA           |                   XOR D
0x9f4f CC BB EE     |                   CALL Z,$EEBB
0x9f52 DD           |                   *ILLEGAL*
0x9f53 11 44 88     |                   LD DE,$8844
0x9f56 DD 77 FD     |                   LD (IX+$FD),A
0x9f59 34           |                   INC (HL)
0x9f5a 12           |                   LD (DE),A
0x9f5b 00           |                   NOP
0x9f5c C0           |                   RET NZ
0x9f5d 00           |                   NOP
0x9f5e 38 00        |                   JR C,$00
0x9f60 00           |                   NOP
0x9f61 00           |                   NOP
0x9f62 00           |                   NOP
0x9f63 00           |                   NOP
0x9f64 00           |                   NOP
0x9f65 00           |                   NOP
0x9f66 00           |                   NOP
0x9f67 00           |                   NOP
0x9f68 00           |                   NOP
0x9f69 00           |                   NOP
0x9f6a 00           |                   NOP
0x9f6b 00           |                   NOP
0x9f6c 00           |                   NOP
0x9f6d 00           |                   NOP
0x9f6e 00           |                   NOP
0x9f6f 00           |                   NOP
0x9f70 00           |                   NOP
0x9f71 00           |                   NOP
0x9f72 00           |                   NOP
0x9f73 00           |                   NOP
0x9f74 00           |                   NOP
0x9f75 FF           |                   RST $38
0x9f76 FF           |                   RST $38
0x9f77 00           |                   NOP
0x9f78 00           |                   NOP
0x9f79 00           |                   NOP
0x9f7a 00           |                   NOP
0x9f7b 00           |                   NOP
0x9f7c 00           |                   NOP
0x9f7d 00           |                   NOP
0x9f7e 00           |                   NOP
0x9f7f 00           |                   NOP
0x9f80 00           |                   NOP
0x9f81 00           |                   NOP
0x9f82 00           |                   NOP
0x9f83 00           |                   NOP
0x9f84 00           |                   NOP
0x9f85 0E 29        |                   LD C,$29
0x9f87 86           |                   AA,(HL)
0x9f88 0A           |                   LD A,(BC)
0x9f89 53           |                   LD D,E
0x9f8a 45           |                   LD B,L
0x9f8b 54           |                   LD D,H
0x9f8c 20 4E        |                   JR NZ,$4E
0x9f8e 2C           |                   INC L
0x9f8f 41           |                   LD B,C
0x9f90 00           |                   NOP
0x9f91 FF           |                   RST $38
0x9f92 CB C6        |                   SET 0,(HL)
0x9f94 00           |                   NOP
0x9f95 00           |                   NOP
0x9f96 FF           |                   RST $38
0x9f97 AA           |                   XOR D
0x9f98 CC BB EE     |                   CALL Z,$EEBB
0x9f9b DD           |                   *ILLEGAL*
0x9f9c 0C           |                   INC C
0x9f9d 88           |                   ADC A,B
0x9f9e 88           |                   ADC A,B
0x9f9f DD 77 FD     |                   LD (IX+$FD),A
0x9fa2 34           |                   INC (HL)
0x9fa3 12           |                   LD (DE),A
0x9fa4 00           |                   NOP
0x9fa5 C0           |                   RET NZ
0x9fa6 00           |                   NOP
0x9fa7 38 00        |                   JR C,$00
0x9fa9 00           |                   NOP
0x9faa 00           |                   NOP
0x9fab 00           |                   NOP
0x9fac 00           |                   NOP
0x9fad 00           |                   NOP
0x9fae 00           |                   NOP
0x9faf 00           |                   NOP
0x9fb0 00           |                   NOP
0x9fb1 00           |                   NOP
0x9fb2 00           |                   NOP
0x9fb3 00           |                   NOP
0x9fb4 00           |                   NOP
0x9fb5 00           |                   NOP
0x9fb6 00           |                   NOP
0x9fb7 00           |                   NOP
0x9fb8 00           |                   NOP
0x9fb9 00           |                   NOP
0x9fba 00           |                   NOP
0x9fbb 00           |                   NOP
0x9fbc 00           |                   NOP
0x9fbd 00           |                   NOP
0x9fbe FF           |                   RST $38
0x9fbf 00           |                   NOP
0x9fc0 00           |                   NOP
0x9fc1 00           |                   NOP
0x9fc2 00           |                   NOP
0x9fc3 00           |                   NOP
0x9fc4 01 00 00     |                   LD BC,$0000
0x9fc7 00           |                   NOP
0x9fc8 00           |                   NOP
0x9fc9 00           |                   NOP
0x9fca FF           |                   RST $38
0x9fcb 00           |                   NOP
0x9fcc 00           |                   NOP
0x9fcd 00           |                   NOP
0x9fce 51           |                   LD D,C
0x9fcf 4C           |                   LD C,H
0x9fd0 C2 F6 53     |                   JP NZ,$53F6
0x9fd3 45           |                   LD B,L
0x9fd4 54           |                   LD D,H
0x9fd5 20 4E        |                   JR NZ,$4E
0x9fd7 2C           |                   INC L
0x9fd8 28 48        |                   JR Z,$48
0x9fda 4C           |                   LD C,H
0x9fdb 29           |                   ADD HL,HL
0x9fdc 00           |                   NOP
0x9fdd FF           |                   RST $38
0x9fde CB C0        |                   SET 0,B
0x9fe0 00           |                   NOP
0x9fe1 00           |                   NOP
0x9fe2 FF           |                   RST $38
0x9fe3 AA           |                   XOR D
0x9fe4 CC BB EE     |                   CALL Z,$EEBB
0x9fe7 DD           |                   *ILLEGAL*
0x9fe8 0C           |                   INC C
0x9fe9 88           |                   ADC A,B
0x9fea 88           |                   ADC A,B
0x9feb DD 77 FD     |                   LD (IX+$FD),A
0x9fee 34           |                   INC (HL)
0x9fef 12           |                   LD (DE),A
0x9ff0 00           |                   NOP
0x9ff1 C0           |                   RET NZ
0x9ff2 00           |                   NOP
0x9ff3 3F           |                   CCF
0x9ff4 00           |                   NOP
0x9ff5 00           |                   NOP
0x9ff6 00           |                   NOP
0x9ff7 00           |                   NOP
0x9ff8 00           |                   NOP
0x9ff9 00           |                   NOP
0x9ffa 00           |                   NOP
0x9ffb 00           |                   NOP
0x9ffc 00           |                   NOP
0x9ffd 00           |                   NOP
0x9ffe 00           |                   NOP
0x9fff 00           |                   NOP
0xa000 00           |                   NOP
0xa001 00           |                   NOP
0xa002 00           |                   NOP
0xa003 00           |                   NOP
0xa004 00           |                   NOP
0xa005 00           |                   NOP
0xa006 00           |                   NOP
0xa007 00           |                   NOP
0xa008 00           |                   NOP
0xa009 00           |                   NOP
0xa00a FF           |                   RST $38
0xa00b 00           |                   NOP
0xa00c FF           |                   RST $38
0xa00d FF           |                   RST $38
0xa00e FF           |                   RST $38
0xa00f FF           |                   RST $38
0xa010 00           |                   NOP
0xa011 00           |                   NOP
0xa012 00           |                   NOP
0xa013 00           |                   NOP
0xa014 00           |                   NOP
0xa015 00           |                   NOP
0xa016 00           |                   NOP
0xa017 00           |                   NOP
0xa018 00           |                   NOP
0xa019 00           |                   NOP
0xa01a BC           |                   CP H
0xa01b 87           |                   AA,A
0xa01c A9           |                   XOR C
0xa01d E1           |                   POP HL
0xa01e 53           |                   LD D,E
0xa01f 45           |                   LD B,L
0xa020 54           |                   LD D,H
0xa021 20 4E        |                   JR NZ,$4E
0xa023 2C           |                   INC L
0xa024 5B           |                   LD E,E
0xa025 52           |                   LD D,D
0xa026 2C           |                   INC L
0xa027 28 48        |                   JR Z,$48
0xa029 4C           |                   LD C,H
0xa02a 29           |                   ADD HL,HL
0xa02b 5D           |                   LD E,L
0xa02c 00           |                   NOP
0xa02d FF           |                   RST $38
0xa02e DD CB 00 C6  |                   SET 0,(IX+${byte:02X})
0xa032 FF           |                   RST $38
0xa033 AA           |                   XOR D
0xa034 CC BB EE     |                   CALL Z,$EEBB
0xa037 DD           |                   *ILLEGAL*
0xa038 11 44 0C     |                   LD DE,$0C44
0xa03b 88           |                   ADC A,B
0xa03c 0C           |                   INC C
0xa03d 88           |                   ADC A,B
0xa03e 34           |                   INC (HL)
0xa03f 12           |                   LD (DE),A
0xa040 00           |                   NOP
0xa041 C0           |                   RET NZ
0xa042 20 00        |                   JR NZ,$00
0xa044 00           |                   NOP
0xa045 38 00        |                   JR C,$00
0xa047 00           |                   NOP
0xa048 00           |                   NOP
0xa049 00           |                   NOP
0xa04a 00           |                   NOP
0xa04b 00           |                   NOP
0xa04c 00           |                   NOP
0xa04d 00           |                   NOP
0xa04e 00           |                   NOP
0xa04f 00           |                   NOP
0xa050 00           |                   NOP
0xa051 00           |                   NOP
0xa052 00           |                   NOP
0xa053 00           |                   NOP
0xa054 00           |                   NOP
0xa055 00           |                   NOP
0xa056 00           |                   NOP
0xa057 00           |                   NOP
0xa058 01 00 FF     |                   LD BC,$FF00
0xa05b 00           |                   NOP
0xa05c 00           |                   NOP
0xa05d 00           |                   NOP
0xa05e 00           |                   NOP
0xa05f 00           |                   NOP
0xa060 00           |                   NOP
0xa061 00           |                   NOP
0xa062 01 00 01     |                   LD BC,$0100
0xa065 00           |                   NOP
0xa066 FF           |                   RST $38
0xa067 00           |                   NOP
0xa068 00           |                   NOP
0xa069 00           |                   NOP
0xa06a FC 48 DC     |                   CALL M,$DC48
0xa06d 5A           |                   LD E,D
0xa06e 53           |                   LD D,E
0xa06f 45           |                   LD B,L
0xa070 54           |                   LD D,H
0xa071 20 4E        |                   JR NZ,$4E
0xa073 2C           |                   INC L
0xa074 28 58        |                   JR Z,$58
0xa076 59           |                   LD E,C
0xa077 29           |                   ADD HL,HL
0xa078 00           |                   NOP
0xa079 FF           |                   RST $38
0xa07a DD CB 00 C0  |                   SET 0,(IX+${byte:02X})
0xa07e FF           |                   RST $38
0xa07f AA           |                   XOR D
0xa080 CC BB EE     |                   CALL Z,$EEBB
0xa083 DD           |                   *ILLEGAL*
0xa084 11 44 0C     |                   LD DE,$0C44
0xa087 88           |                   ADC A,B
0xa088 0C           |                   INC C
0xa089 88           |                   ADC A,B
0xa08a 34           |                   INC (HL)
0xa08b 12           |                   LD (DE),A
0xa08c 00           |                   NOP
0xa08d C0           |                   RET NZ
0xa08e 20 00        |                   JR NZ,$00
0xa090 00           |                   NOP
0xa091 3F           |                   CCF
0xa092 00           |                   NOP
0xa093 00           |                   NOP
0xa094 00           |                   NOP
0xa095 00           |                   NOP
0xa096 00           |                   NOP
0xa097 00           |                   NOP
0xa098 00           |                   NOP
0xa099 00           |                   NOP
0xa09a 00           |                   NOP
0xa09b 00           |                   NOP
0xa09c 00           |                   NOP
0xa09d 00           |                   NOP
0xa09e 00           |                   NOP
0xa09f 00           |                   NOP
0xa0a0 00           |                   NOP
0xa0a1 00           |                   NOP
0xa0a2 00           |                   NOP
0xa0a3 00           |                   NOP
0xa0a4 01 00 FF     |                   LD BC,$FF00
0xa0a7 00           |                   NOP
0xa0a8 00           |                   NOP
0xa0a9 00           |                   NOP
0xa0aa 00           |                   NOP
0xa0ab 00           |                   NOP
0xa0ac 00           |                   NOP
0xa0ad 00           |                   NOP
0xa0ae 01 00 01     |                   LD BC,$0100
0xa0b1 00           |                   NOP
0xa0b2 FF           |                   RST $38
0xa0b3 00           |                   NOP
0xa0b4 00           |                   NOP
0xa0b5 00           |                   NOP
0xa0b6 02           |                   LD (BC),A
0xa0b7 39           |                   ADD HL,SP
0xa0b8 26 78        |                   LD H,$78
0xa0ba 53           |                   LD D,E
0xa0bb 45           |                   LD B,L
0xa0bc 54           |                   LD D,H
0xa0bd 20 4E        |                   JR NZ,$4E
0xa0bf 2C           |                   INC L
0xa0c0 28 58        |                   JR Z,$58
0xa0c2 59           |                   LD E,C
0xa0c3 29           |                   ADD HL,HL
0xa0c4 2C           |                   INC L
0xa0c5 52           |                   LD D,D
0xa0c6 00           |                   NOP
0xa0c7 FF           |                   RST $38
0xa0c8 CB 87        |                   RES 0,A
0xa0ca 00           |                   NOP
0xa0cb 00           |                   NOP
0xa0cc FF           |                   RST $38
0xa0cd AA           |                   XOR D
0xa0ce CC BB EE     |                   CALL Z,$EEBB
0xa0d1 DD           |                   *ILLEGAL*
0xa0d2 11 44 88     |                   LD DE,$8844
0xa0d5 DD 77 FD     |                   LD (IX+$FD),A
0xa0d8 34           |                   INC (HL)
0xa0d9 12           |                   LD (DE),A
0xa0da 00           |                   NOP
0xa0db C0           |                   RET NZ
0xa0dc 00           |                   NOP
0xa0dd 38 00        |                   JR C,$00
0xa0df 00           |                   NOP
0xa0e0 00           |                   NOP
0xa0e1 00           |                   NOP
0xa0e2 00           |                   NOP
0xa0e3 00           |                   NOP
0xa0e4 00           |                   NOP
0xa0e5 00           |                   NOP
0xa0e6 00           |                   NOP
0xa0e7 00           |                   NOP
0xa0e8 00           |                   NOP
0xa0e9 00           |                   NOP
0xa0ea 00           |                   NOP
0xa0eb 00           |                   NOP
0xa0ec 00           |                   NOP
0xa0ed 00           |                   NOP
0xa0ee 00           |                   NOP
0xa0ef 00           |                   NOP
0xa0f0 00           |                   NOP
0xa0f1 00           |                   NOP
0xa0f2 00           |                   NOP
0xa0f3 00           |                   NOP
0xa0f4 FF           |                   RST $38
0xa0f5 FF           |                   RST $38
0xa0f6 00           |                   NOP
0xa0f7 00           |                   NOP
0xa0f8 00           |                   NOP
0xa0f9 00           |                   NOP
0xa0fa 00           |                   NOP
0xa0fb 00           |                   NOP
0xa0fc 00           |                   NOP
0xa0fd 00           |                   NOP
0xa0fe 00           |                   NOP
0xa0ff 00           |                   NOP
0xa100 00           |                   NOP
0xa101 00           |                   NOP
0xa102 00           |                   NOP
0xa103 00           |                   NOP
0xa104 00           |                   NOP
0xa105 2D           |                   DEC L
0xa106 3C           |                   INC A
0xa107 76           |                   HALT
0xa108 52           |                   LD D,D
0xa109 45           |                   LD B,L
0xa10a 53           |                   LD D,E
0xa10b 20 4E        |                   JR NZ,$4E
0xa10d 2C           |                   INC L
0xa10e 41           |                   LD B,C
0xa10f 00           |                   NOP
0xa110 FF           |                   RST $38
0xa111 CB 86        |                   RES 0,(HL)
0xa113 00           |                   NOP
0xa114 00           |                   NOP
0xa115 FF           |                   RST $38
0xa116 AA           |                   XOR D
0xa117 CC BB EE     |                   CALL Z,$EEBB
0xa11a DD           |                   *ILLEGAL*
0xa11b 0C           |                   INC C
0xa11c 88           |                   ADC A,B
0xa11d 88           |                   ADC A,B
0xa11e DD 77 FD     |                   LD (IX+$FD),A
0xa121 34           |                   INC (HL)
0xa122 12           |                   LD (DE),A
0xa123 00           |                   NOP
0xa124 C0           |                   RET NZ
0xa125 00           |                   NOP
0xa126 38 00        |                   JR C,$00
0xa128 00           |                   NOP
0xa129 00           |                   NOP
0xa12a 00           |                   NOP
0xa12b 00           |                   NOP
0xa12c 00           |                   NOP
0xa12d 00           |                   NOP
0xa12e 00           |                   NOP
0xa12f 00           |                   NOP
0xa130 00           |                   NOP
0xa131 00           |                   NOP
0xa132 00           |                   NOP
0xa133 00           |                   NOP
0xa134 00           |                   NOP
0xa135 00           |                   NOP
0xa136 00           |                   NOP
0xa137 00           |                   NOP
0xa138 00           |                   NOP
0xa139 00           |                   NOP
0xa13a 00           |                   NOP
0xa13b 00           |                   NOP
0xa13c 00           |                   NOP
0xa13d FF           |                   RST $38
0xa13e 00           |                   NOP
0xa13f 00           |                   NOP
0xa140 00           |                   NOP
0xa141 00           |                   NOP
0xa142 00           |                   NOP
0xa143 01 00 00     |                   LD BC,$0000
0xa146 00           |                   NOP
0xa147 00           |                   NOP
0xa148 00           |                   NOP
0xa149 FF           |                   RST $38
0xa14a 00           |                   NOP
0xa14b 00           |                   NOP
0xa14c 00           |                   NOP
0xa14d E0           |                   RET PO
0xa14e 11 2A 76     |                   LD DE,$762A
0xa151 52           |                   LD D,D
0xa152 45           |                   LD B,L
0xa153 53           |                   LD D,E
0xa154 20 4E        |                   JR NZ,$4E
0xa156 2C           |                   INC L
0xa157 28 48        |                   JR Z,$48
0xa159 4C           |                   LD C,H
0xa15a 29           |                   ADD HL,HL
0xa15b 00           |                   NOP
0xa15c FF           |                   RST $38
0xa15d CB 80        |                   RES 0,B
0xa15f 00           |                   NOP
0xa160 00           |                   NOP
0xa161 FF           |                   RST $38
0xa162 AA           |                   XOR D
0xa163 CC BB EE     |                   CALL Z,$EEBB
0xa166 DD           |                   *ILLEGAL*
0xa167 0C           |                   INC C
0xa168 88           |                   ADC A,B
0xa169 88           |                   ADC A,B
0xa16a DD 77 FD     |                   LD (IX+$FD),A
0xa16d 34           |                   INC (HL)
0xa16e 12           |                   LD (DE),A
0xa16f 00           |                   NOP
0xa170 C0           |                   RET NZ
0xa171 00           |                   NOP
0xa172 3F           |                   CCF
0xa173 00           |                   NOP
0xa174 00           |                   NOP
0xa175 00           |                   NOP
0xa176 00           |                   NOP
0xa177 00           |                   NOP
0xa178 00           |                   NOP
0xa179 00           |                   NOP
0xa17a 00           |                   NOP
0xa17b 00           |                   NOP
0xa17c 00           |                   NOP
0xa17d 00           |                   NOP
0xa17e 00           |                   NOP
0xa17f 00           |                   NOP
0xa180 00           |                   NOP
0xa181 00           |                   NOP
0xa182 00           |                   NOP
0xa183 00           |                   NOP
0xa184 00           |                   NOP
0xa185 00           |                   NOP
0xa186 00           |                   NOP
0xa187 00           |                   NOP
0xa188 00           |                   NOP
0xa189 FF           |                   RST $38
0xa18a 00           |                   NOP
0xa18b FF           |                   RST $38
0xa18c FF           |                   RST $38
0xa18d FF           |                   RST $38
0xa18e FF           |                   RST $38
0xa18f 00           |                   NOP
0xa190 00           |                   NOP
0xa191 00           |                   NOP
0xa192 00           |                   NOP
0xa193 00           |                   NOP
0xa194 00           |                   NOP
0xa195 00           |                   NOP
0xa196 00           |                   NOP
0xa197 00           |                   NOP
0xa198 00           |                   NOP
0xa199 4A           |                   LD C,D
0xa19a 20 7D        |                   JR NZ,$7D
0xa19c F2 52 45     |                   JP P,$4552
0xa19f 53           |                   LD D,E
0xa1a0 20 4E        |                   JR NZ,$4E
0xa1a2 2C           |                   INC L
0xa1a3 5B           |                   LD E,E
0xa1a4 52           |                   LD D,D
0xa1a5 2C           |                   INC L
0xa1a6 28 48        |                   JR Z,$48
0xa1a8 4C           |                   LD C,H
0xa1a9 29           |                   ADD HL,HL
0xa1aa 5D           |                   LD E,L
0xa1ab 00           |                   NOP
0xa1ac FF           |                   RST $38
0xa1ad DD CB 00 86  |                   RES 0,(IX+${byte:02X})
0xa1b1 FF           |                   RST $38
0xa1b2 AA           |                   XOR D
0xa1b3 CC BB EE     |                   CALL Z,$EEBB
0xa1b6 DD           |                   *ILLEGAL*
0xa1b7 11 44 0C     |                   LD DE,$0C44
0xa1ba 88           |                   ADC A,B
0xa1bb 0C           |                   INC C
0xa1bc 88           |                   ADC A,B
0xa1bd 34           |                   INC (HL)
0xa1be 12           |                   LD (DE),A
0xa1bf 00           |                   NOP
0xa1c0 C0           |                   RET NZ
0xa1c1 20 00        |                   JR NZ,$00
0xa1c3 00           |                   NOP
0xa1c4 38 00        |                   JR C,$00
0xa1c6 00           |                   NOP
0xa1c7 00           |                   NOP
0xa1c8 00           |                   NOP
0xa1c9 00           |                   NOP
0xa1ca 00           |                   NOP
0xa1cb 00           |                   NOP
0xa1cc 00           |                   NOP
0xa1cd 00           |                   NOP
0xa1ce 00           |                   NOP
0xa1cf 00           |                   NOP
0xa1d0 00           |                   NOP
0xa1d1 00           |                   NOP
0xa1d2 00           |                   NOP
0xa1d3 00           |                   NOP
0xa1d4 00           |                   NOP
0xa1d5 00           |                   NOP
0xa1d6 00           |                   NOP
0xa1d7 01 00 FF     |                   LD BC,$FF00
0xa1da 00           |                   NOP
0xa1db 00           |                   NOP
0xa1dc 00           |                   NOP
0xa1dd 00           |                   NOP
0xa1de 00           |                   NOP
0xa1df 00           |                   NOP
0xa1e0 00           |                   NOP
0xa1e1 01 00 01     |                   LD BC,$0100
0xa1e4 00           |                   NOP
0xa1e5 FF           |                   RST $38
0xa1e6 00           |                   NOP
0xa1e7 00           |                   NOP
0xa1e8 00           |                   NOP
0xa1e9 56           |                   LD D,(HL)
0xa1ea 3D           |                   DEC A
0xa1eb 39           |                   ADD HL,SP
0xa1ec DE 52        |                   SBC A,$52
0xa1ee 45           |                   LD B,L
0xa1ef 53           |                   LD D,E
0xa1f0 20 4E        |                   JR NZ,$4E
0xa1f2 2C           |                   INC L
0xa1f3 28 58        |                   JR Z,$58
0xa1f5 59           |                   LD E,C
0xa1f6 29           |                   ADD HL,HL
0xa1f7 00           |                   NOP
0xa1f8 FF           |                   RST $38
0xa1f9 DD CB 00 80  |                   RES 0,(IX+${byte:02X})
0xa1fd FF           |                   RST $38
0xa1fe AA           |                   XOR D
0xa1ff CC BB EE     |                   CALL Z,$EEBB
0xa202 DD           |                   *ILLEGAL*
0xa203 11 44 0C     |                   LD DE,$0C44
0xa206 88           |                   ADC A,B
0xa207 0C           |                   INC C
0xa208 88           |                   ADC A,B
0xa209 34           |                   INC (HL)
0xa20a 12           |                   LD (DE),A
0xa20b 00           |                   NOP
0xa20c C0           |                   RET NZ
0xa20d 20 00        |                   JR NZ,$00
0xa20f 00           |                   NOP
0xa210 3F           |                   CCF
0xa211 00           |                   NOP
0xa212 00           |                   NOP
0xa213 00           |                   NOP
0xa214 00           |                   NOP
0xa215 00           |                   NOP
0xa216 00           |                   NOP
0xa217 00           |                   NOP
0xa218 00           |                   NOP
0xa219 00           |                   NOP
0xa21a 00           |                   NOP
0xa21b 00           |                   NOP
0xa21c 00           |                   NOP
0xa21d 00           |                   NOP
0xa21e 00           |                   NOP
0xa21f 00           |                   NOP
0xa220 00           |                   NOP
0xa221 00           |                   NOP
0xa222 00           |                   NOP
0xa223 01 00 FF     |                   LD BC,$FF00
0xa226 00           |                   NOP
0xa227 00           |                   NOP
0xa228 00           |                   NOP
0xa229 00           |                   NOP
0xa22a 00           |                   NOP
0xa22b 00           |                   NOP
0xa22c 00           |                   NOP
0xa22d 01 00 01     |                   LD BC,$0100
0xa230 00           |                   NOP
0xa231 FF           |                   RST $38
0xa232 00           |                   NOP
0xa233 00           |                   NOP
0xa234 00           |                   NOP
0xa235 54           |                   LD D,H
0xa236 E6 DA        |                   AND $DA
0xa238 74           |                   LD (HL),H
0xa239 52           |                   LD D,D
0xa23a 45           |                   LD B,L
0xa23b 53           |                   LD D,E
0xa23c 20 4E        |                   JR NZ,$4E
0xa23e 2C           |                   INC L
0xa23f 28 58        |                   JR Z,$58
0xa241 59           |                   LD E,C
0xa242 29           |                   ADD HL,HL
0xa243 2C           |                   INC L
0xa244 52           |                   LD D,D
0xa245 00           |                   NOP
0xa246 FF           |                   RST $38
0xa247 ED A0        |                   LDI
0xa249 00           |                   NOP
0xa24a 00           |                   NOP
0xa24b FF           |                   RST $38
0xa24c AA           |                   XOR D
0xa24d 01 00 0C     |                   LD BC,$0C00
0xa250 88           |                   ADC A,B
0xa251 0C           |                   INC C
0xa252 88           |                   ADC A,B
0xa253 88           |                   ADC A,B
0xa254 DD 77 FD     |                   LD (IX+$FD),A
0xa257 34           |                   INC (HL)
0xa258 12           |                   LD (DE),A
0xa259 00           |                   NOP
0xa25a C0           |                   RET NZ
0xa25b 00           |                   NOP
0xa25c 00           |                   NOP
0xa25d 00           |                   NOP
0xa25e 00           |                   NOP
0xa25f 00           |                   NOP
0xa260 09           |                   ADD HL,BC
0xa261 00           |                   NOP
0xa262 00           |                   NOP
0xa263 01 00 01     |                   LD BC,$0100
0xa266 00           |                   NOP
0xa267 00           |                   NOP
0xa268 00           |                   NOP
0xa269 00           |                   NOP
0xa26a 00           |                   NOP
0xa26b 09           |                   ADD HL,BC
0xa26c 00           |                   NOP
0xa26d 00           |                   NOP
0xa26e 00           |                   NOP
0xa26f 00           |                   NOP
0xa270 00           |                   NOP
0xa271 00           |                   NOP
0xa272 00           |                   NOP
0xa273 FF           |                   RST $38
0xa274 F6 FF        |                   OR $FF
0xa276 FF           |                   RST $38
0xa277 00           |                   NOP
0xa278 00           |                   NOP
0xa279 00           |                   NOP
0xa27a 00           |                   NOP
0xa27b 00           |                   NOP
0xa27c 00           |                   NOP
0xa27d 00           |                   NOP
0xa27e 00           |                   NOP
0xa27f F6 00        |                   OR $00
0xa281 00           |                   NOP
0xa282 00           |                   NOP
0xa283 17           |                   RLA
0xa284 1F           |                   RRA
0xa285 17           |                   RLA
0xa286 4F           |                   LD C,A
0xa287 4C           |                   LD C,H
0xa288 44           |                   LD B,H
0xa289 49           |                   LD C,C
0xa28a 00           |                   NOP
0xa28b FF           |                   RST $38
0xa28c ED A8        |                   LDD
0xa28e 00           |                   NOP
0xa28f 00           |                   NOP
0xa290 FF           |                   RST $38
0xa291 AA           |                   XOR D
0xa292 01 00 0C     |                   LD BC,$0C00
0xa295 88           |                   ADC A,B
0xa296 0C           |                   INC C
0xa297 88           |                   ADC A,B
0xa298 88           |                   ADC A,B
0xa299 DD 77 FD     |                   LD (IX+$FD),A
0xa29c 34           |                   INC (HL)
0xa29d 12           |                   LD (DE),A
0xa29e 00           |                   NOP
0xa29f C0           |                   RET NZ
0xa2a0 00           |                   NOP
0xa2a1 00           |                   NOP
0xa2a2 00           |                   NOP
0xa2a3 00           |                   NOP
0xa2a4 00           |                   NOP
0xa2a5 09           |                   ADD HL,BC
0xa2a6 00           |                   NOP
0xa2a7 00           |                   NOP
0xa2a8 01 00 01     |                   LD BC,$0100
0xa2ab 00           |                   NOP
0xa2ac 00           |                   NOP
0xa2ad 00           |                   NOP
0xa2ae 00           |                   NOP
0xa2af 00           |                   NOP
0xa2b0 09           |                   ADD HL,BC
0xa2b1 00           |                   NOP
0xa2b2 00           |                   NOP
0xa2b3 00           |                   NOP
0xa2b4 00           |                   NOP
0xa2b5 00           |                   NOP
0xa2b6 00           |                   NOP
0xa2b7 00           |                   NOP
0xa2b8 FF           |                   RST $38
0xa2b9 F6 FF        |                   OR $FF
0xa2bb FF           |                   RST $38
0xa2bc 00           |                   NOP
0xa2bd 00           |                   NOP
0xa2be 00           |                   NOP
0xa2bf 00           |                   NOP
0xa2c0 00           |                   NOP
0xa2c1 00           |                   NOP
0xa2c2 00           |                   NOP
0xa2c3 00           |                   NOP
0xa2c4 F6 00        |                   OR $00
0xa2c6 00           |                   NOP
0xa2c7 00           |                   NOP
0xa2c8 D7           |                   RST $10
0xa2c9 52           |                   LD D,D
0xa2ca D9           |                   EXX
0xa2cb BC           |                   CP H
0xa2cc 4C           |                   LD C,H
0xa2cd 44           |                   LD B,H
0xa2ce 44           |                   LD B,H
0xa2cf 00           |                   NOP
0xa2d0 FF           |                   RST $38
0xa2d1 ED B0        |                   LDIR
0xa2d3 00           |                   NOP
0xa2d4 00           |                   NOP
0xa2d5 FF           |                   RST $38
0xa2d6 AA           |                   XOR D
0xa2d7 01 00 0C     |                   LD BC,$0C00
0xa2da 88           |                   ADC A,B
0xa2db 0C           |                   INC C
0xa2dc 88           |                   ADC A,B
0xa2dd 88           |                   ADC A,B
0xa2de DD 77 FD     |                   LD (IX+$FD),A
0xa2e1 34           |                   INC (HL)
0xa2e2 12           |                   LD (DE),A
0xa2e3 00           |                   NOP
0xa2e4 C0           |                   RET NZ
0xa2e5 00           |                   NOP
0xa2e6 00           |                   NOP
0xa2e7 00           |                   NOP
0xa2e8 00           |                   NOP
0xa2e9 00           |                   NOP
0xa2ea 09           |                   ADD HL,BC
0xa2eb 00           |                   NOP
0xa2ec 00           |                   NOP
0xa2ed 01 00 01     |                   LD BC,$0100
0xa2f0 00           |                   NOP
0xa2f1 00           |                   NOP
0xa2f2 00           |                   NOP
0xa2f3 00           |                   NOP
0xa2f4 00           |                   NOP
0xa2f5 09           |                   ADD HL,BC
0xa2f6 00           |                   NOP
0xa2f7 00           |                   NOP
0xa2f8 00           |                   NOP
0xa2f9 00           |                   NOP
0xa2fa 00           |                   NOP
0xa2fb 00           |                   NOP
0xa2fc 00           |                   NOP
0xa2fd FF           |                   RST $38
0xa2fe F6 02        |                   OR $02
0xa300 00           |                   NOP
0xa301 00           |                   NOP
0xa302 00           |                   NOP
0xa303 00           |                   NOP
0xa304 00           |                   NOP
0xa305 00           |                   NOP
0xa306 00           |                   NOP
0xa307 00           |                   NOP
0xa308 00           |                   NOP
0xa309 F6 00        |                   OR $00
0xa30b 00           |                   NOP
0xa30c 00           |                   NOP
0xa30d CE D3        |                   ADC A,$D3
0xa30f EA 2D 4C     |                   JP PE,$4C2D
0xa312 44           |                   LD B,H
0xa313 49           |                   LD C,C
0xa314 52           |                   LD D,D
0xa315 00           |                   NOP
0xa316 FF           |                   RST $38
0xa317 ED B8        |                   LDDR
0xa319 00           |                   NOP
0xa31a 00           |                   NOP
0xa31b FF           |                   RST $38
0xa31c AA           |                   XOR D
0xa31d 01 00 0D     |                   LD BC,$0D00
0xa320 88           |                   ADC A,B
0xa321 0D           |                   DEC C
0xa322 88           |                   ADC A,B
0xa323 88           |                   ADC A,B
0xa324 DD 77 FD     |                   LD (IX+$FD),A
0xa327 34           |                   INC (HL)
0xa328 12           |                   LD (DE),A
0xa329 00           |                   NOP
0xa32a C0           |                   RET NZ
0xa32b 00           |                   NOP
0xa32c 00           |                   NOP
0xa32d 00           |                   NOP
0xa32e 00           |                   NOP
0xa32f 00           |                   NOP
0xa330 09           |                   ADD HL,BC
0xa331 00           |                   NOP
0xa332 00           |                   NOP
0xa333 01 00 01     |                   LD BC,$0100
0xa336 00           |                   NOP
0xa337 00           |                   NOP
0xa338 00           |                   NOP
0xa339 00           |                   NOP
0xa33a 00           |                   NOP
0xa33b 00           |                   NOP
0xa33c 09           |                   ADD HL,BC
0xa33d 00           |                   NOP
0xa33e 00           |                   NOP
0xa33f 00           |                   NOP
0xa340 00           |                   NOP
0xa341 00           |                   NOP
0xa342 00           |                   NOP
0xa343 FF           |                   RST $38
0xa344 F6 02        |                   OR $02
0xa346 00           |                   NOP
0xa347 00           |                   NOP
0xa348 00           |                   NOP
0xa349 00           |                   NOP
0xa34a 00           |                   NOP
0xa34b 00           |                   NOP
0xa34c 00           |                   NOP
0xa34d 00           |                   NOP
0xa34e 00           |                   NOP
0xa34f 00           |                   NOP
0xa350 F6 00        |                   OR $00
0xa352 00           |                   NOP
0xa353 49           |                   LD C,C
0xa354 5A           |                   LD E,D
0xa355 8B           |                   ADC A,E
0xa356 20 4C        |                   JR NZ,$4C
0xa358 44           |                   LD B,H
0xa359 44           |                   LD B,H
0xa35a 52           |                   LD D,D
0xa35b 00           |                   NOP
0xa35c FF           |                   RST $38
0xa35d ED B0        |                   LDIR
0xa35f 00           |                   NOP
0xa360 00           |                   NOP
0xa361 FF           |                   RST $38
0xa362 AA           |                   XOR D
0xa363 00           |                   NOP
0xa364 00           |                   NOP
0xa365 2C           |                   INC L
0xa366 83           |                   AA,E
0xa367 0C           |                   INC C
0xa368 88           |                   ADC A,B
0xa369 88           |                   ADC A,B
0xa36a DD 77 FD     |                   LD (IX+$FD),A
0xa36d 00           |                   NOP
0xa36e 00           |                   NOP
0xa36f 00           |                   NOP
0xa370 C0           |                   RET NZ
0xa371 00           |                   NOP
0xa372 00           |                   NOP
0xa373 00           |                   NOP
0xa374 00           |                   NOP
0xa375 00           |                   NOP
0xa376 09           |                   ADD HL,BC
0xa377 01 00 00     |                   LD BC,$0000
0xa37a 00           |                   NOP
0xa37b 00           |                   NOP
0xa37c 00           |                   NOP
0xa37d 00           |                   NOP
0xa37e 00           |                   NOP
0xa37f 00           |                   NOP
0xa380 00           |                   NOP
0xa381 09           |                   ADD HL,BC
0xa382 00           |                   NOP
0xa383 00           |                   NOP
0xa384 00           |                   NOP
0xa385 00           |                   NOP
0xa386 00           |                   NOP
0xa387 00           |                   NOP
0xa388 00           |                   NOP
0xa389 FF           |                   RST $38
0xa38a F6 FE        |                   OR $FE
0xa38c FF           |                   RST $38
0xa38d 00           |                   NOP
0xa38e 00           |                   NOP
0xa38f 00           |                   NOP
0xa390 00           |                   NOP
0xa391 00           |                   NOP
0xa392 00           |                   NOP
0xa393 00           |                   NOP
0xa394 00           |                   NOP
0xa395 00           |                   NOP
0xa396 00           |                   NOP
0xa397 00           |                   NOP
0xa398 00           |                   NOP
0xa399 CC 93 B5     |                   CALL Z,$B593
0xa39c EC 4C 44     |                   CALL P,$444C
0xa39f 49           |                   LD C,C
0xa3a0 52           |                   LD D,D
0xa3a1 2D           |                   DEC L
0xa3a2 3E 4E        |                   LD A,$4E
0xa3a4 4F           |                   LD C,A
0xa3a5 50           |                   LD D,B
0xa3a6 27           |                   DAA
0xa3a7 00           |                   NOP
0xa3a8 FF           |                   RST $38
0xa3a9 ED B8        |                   LDDR
0xa3ab 00           |                   NOP
0xa3ac 00           |                   NOP
0xa3ad FF           |                   RST $38
0xa3ae AA           |                   XOR D
0xa3af 00           |                   NOP
0xa3b0 00           |                   NOP
0xa3b1 2C           |                   INC L
0xa3b2 83           |                   AA,E
0xa3b3 0C           |                   INC C
0xa3b4 88           |                   ADC A,B
0xa3b5 88           |                   ADC A,B
0xa3b6 DD 77 FD     |                   LD (IX+$FD),A
0xa3b9 00           |                   NOP
0xa3ba 00           |                   NOP
0xa3bb 00           |                   NOP
0xa3bc C0           |                   RET NZ
0xa3bd 00           |                   NOP
0xa3be 00           |                   NOP
0xa3bf 00           |                   NOP
0xa3c0 00           |                   NOP
0xa3c1 00           |                   NOP
0xa3c2 09           |                   ADD HL,BC
0xa3c3 01 00 00     |                   LD BC,$0000
0xa3c6 00           |                   NOP
0xa3c7 00           |                   NOP
0xa3c8 00           |                   NOP
0xa3c9 00           |                   NOP
0xa3ca 00           |                   NOP
0xa3cb 00           |                   NOP
0xa3cc 00           |                   NOP
0xa3cd 09           |                   ADD HL,BC
0xa3ce 00           |                   NOP
0xa3cf 00           |                   NOP
0xa3d0 00           |                   NOP
0xa3d1 00           |                   NOP
0xa3d2 00           |                   NOP
0xa3d3 00           |                   NOP
0xa3d4 00           |                   NOP
0xa3d5 FF           |                   RST $38
0xa3d6 F6 FE        |                   OR $FE
0xa3d8 FF           |                   RST $38
0xa3d9 00           |                   NOP
0xa3da 00           |                   NOP
0xa3db 00           |                   NOP
0xa3dc 00           |                   NOP
0xa3dd 00           |                   NOP
0xa3de 00           |                   NOP
0xa3df 00           |                   NOP
0xa3e0 00           |                   NOP
0xa3e1 00           |                   NOP
0xa3e2 00           |                   NOP
0xa3e3 00           |                   NOP
0xa3e4 00           |                   NOP
0xa3e5 CD 49 1C     |                   CALL $1C49
0xa3e8 09           |                   ADD HL,BC
0xa3e9 4C           |                   LD C,H
0xa3ea 44           |                   LD B,H
0xa3eb 44           |                   LD B,H
0xa3ec 52           |                   LD D,D
0xa3ed 2D           |                   DEC L
0xa3ee 3E 4E        |                   LD A,$4E
0xa3f0 4F           |                   LD C,A
0xa3f1 50           |                   LD D,B
0xa3f2 27           |                   DAA
0xa3f3 00           |                   NOP
0xa3f4 FF           |                   RST $38
0xa3f5 ED A1        |                   CPI
0xa3f7 00           |                   NOP
0xa3f8 00           |                   NOP
0xa3f9 FF           |                   RST $38
0xa3fa 00           |                   NOP
0xa3fb 01 00 EE     |                   LD BC,$EE00
0xa3fe DD           |                   *ILLEGAL*
0xa3ff 0C           |                   INC C
0xa400 88           |                   ADC A,B
0xa401 88           |                   ADC A,B
0xa402 DD 77 FD     |                   LD (IX+$FD),A
0xa405 00           |                   NOP
0xa406 00           |                   NOP
0xa407 00           |                   NOP
0xa408 C0           |                   RET NZ
0xa409 00           |                   NOP
0xa40a 00           |                   NOP
0xa40b 00           |                   NOP
0xa40c 00           |                   NOP
0xa40d 00           |                   NOP
0xa40e 89           |                   ADC A,C
0xa40f 00           |                   NOP
0xa410 00           |                   NOP
0xa411 00           |                   NOP
0xa412 00           |                   NOP
0xa413 01 00 00     |                   LD BC,$0000
0xa416 00           |                   NOP
0xa417 00           |                   NOP
0xa418 00           |                   NOP
0xa419 89           |                   ADC A,C
0xa41a 00           |                   NOP
0xa41b 00           |                   NOP
0xa41c 00           |                   NOP
0xa41d 00           |                   NOP
0xa41e 00           |                   NOP
0xa41f 00           |                   NOP
0xa420 00           |                   NOP
0xa421 FF           |                   RST $38
0xa422 76           |                   HALT
0xa423 FF           |                   RST $38
0xa424 FF           |                   RST $38
0xa425 00           |                   NOP
0xa426 00           |                   NOP
0xa427 00           |                   NOP
0xa428 00           |                   NOP
0xa429 00           |                   NOP
0xa42a 00           |                   NOP
0xa42b 00           |                   NOP
0xa42c 00           |                   NOP
0xa42d 76           |                   HALT
0xa42e 00           |                   NOP
0xa42f 00           |                   NOP
0xa430 00           |                   NOP
0xa431 BE           |                   CP (HL)
0xa432 38 BD        |                   JR C,$BD
0xa434 05           |                   DEC B
0xa435 43           |                   LD B,E
0xa436 50           |                   LD D,B
0xa437 49           |                   LD C,C
0xa438 00           |                   NOP
0xa439 FF           |                   RST $38
0xa43a ED A9        |                   CPD
0xa43c 00           |                   NOP
0xa43d 00           |                   NOP
0xa43e FF           |                   RST $38
0xa43f 00           |                   NOP
0xa440 01 00 EE     |                   LD BC,$EE00
0xa443 DD           |                   *ILLEGAL*
0xa444 0C           |                   INC C
0xa445 88           |                   ADC A,B
0xa446 88           |                   ADC A,B
0xa447 DD 77 FD     |                   LD (IX+$FD),A
0xa44a 00           |                   NOP
0xa44b 00           |                   NOP
0xa44c 00           |                   NOP
0xa44d C0           |                   RET NZ
0xa44e 00           |                   NOP
0xa44f 00           |                   NOP
0xa450 00           |                   NOP
0xa451 00           |                   NOP
0xa452 00           |                   NOP
0xa453 89           |                   ADC A,C
0xa454 00           |                   NOP
0xa455 00           |                   NOP
0xa456 00           |                   NOP
0xa457 00           |                   NOP
0xa458 01 00 00     |                   LD BC,$0000
0xa45b 00           |                   NOP
0xa45c 00           |                   NOP
0xa45d 00           |                   NOP
0xa45e 89           |                   ADC A,C
0xa45f 00           |                   NOP
0xa460 00           |                   NOP
0xa461 00           |                   NOP
0xa462 00           |                   NOP
0xa463 00           |                   NOP
0xa464 00           |                   NOP
0xa465 00           |                   NOP
0xa466 FF           |                   RST $38
0xa467 76           |                   HALT
0xa468 FF           |                   RST $38
0xa469 FF           |                   RST $38
0xa46a 00           |                   NOP
0xa46b 00           |                   NOP
0xa46c 00           |                   NOP
0xa46d 00           |                   NOP
0xa46e 00           |                   NOP
0xa46f 00           |                   NOP
0xa470 00           |                   NOP
0xa471 00           |                   NOP
0xa472 76           |                   HALT
0xa473 00           |                   NOP
0xa474 00           |                   NOP
0xa475 00           |                   NOP
0xa476 C9           |                   RET
0xa477 19           |                   ADD HL,DE
0xa478 BD           |                   CP L
0xa479 72           |                   LD (HL),D
0xa47a 43           |                   LD B,E
0xa47b 50           |                   LD D,B
0xa47c 44           |                   LD B,H
0xa47d 00           |                   NOP
0xa47e FF           |                   RST $38
0xa47f ED B1        |                   CPIR
0xa481 00           |                   NOP
0xa482 00           |                   NOP
0xa483 FF           |                   RST $38
0xa484 00           |                   NOP
0xa485 01 00 EE     |                   LD BC,$EE00
0xa488 DD           |                   *ILLEGAL*
0xa489 0C           |                   INC C
0xa48a 88           |                   ADC A,B
0xa48b 88           |                   ADC A,B
0xa48c DD 77 FD     |                   LD (IX+$FD),A
0xa48f 00           |                   NOP
0xa490 00           |                   NOP
0xa491 00           |                   NOP
0xa492 C0           |                   RET NZ
0xa493 00           |                   NOP
0xa494 00           |                   NOP
0xa495 00           |                   NOP
0xa496 00           |                   NOP
0xa497 00           |                   NOP
0xa498 89           |                   ADC A,C
0xa499 00           |                   NOP
0xa49a 00           |                   NOP
0xa49b 00           |                   NOP
0xa49c 00           |                   NOP
0xa49d 01 00 00     |                   LD BC,$0000
0xa4a0 00           |                   NOP
0xa4a1 00           |                   NOP
0xa4a2 00           |                   NOP
0xa4a3 89           |                   ADC A,C
0xa4a4 00           |                   NOP
0xa4a5 00           |                   NOP
0xa4a6 00           |                   NOP
0xa4a7 00           |                   NOP
0xa4a8 00           |                   NOP
0xa4a9 00           |                   NOP
0xa4aa 00           |                   NOP
0xa4ab FF           |                   RST $38
0xa4ac 76           |                   HALT
0xa4ad 02           |                   LD (BC),A
0xa4ae 00           |                   NOP
0xa4af 00           |                   NOP
0xa4b0 00           |                   NOP
0xa4b1 00           |                   NOP
0xa4b2 00           |                   NOP
0xa4b3 00           |                   NOP
0xa4b4 00           |                   NOP
0xa4b5 00           |                   NOP
0xa4b6 00           |                   NOP
0xa4b7 76           |                   HALT
0xa4b8 00           |                   NOP
0xa4b9 00           |                   NOP
0xa4ba 00           |                   NOP
0xa4bb 2E 43        |                   LD L,$43
0xa4bd 00           |                   NOP
0xa4be CB 43        |                   BIT 0,E
0xa4c0 50           |                   LD D,B
0xa4c1 49           |                   LD C,C
0xa4c2 52           |                   LD D,D
0xa4c3 00           |                   NOP
0xa4c4 FF           |                   RST $38
0xa4c5 ED B9        |                   CPDR
0xa4c7 00           |                   NOP
0xa4c8 00           |                   NOP
0xa4c9 FF           |                   RST $38
0xa4ca 00           |                   NOP
0xa4cb 01 00 EE     |                   LD BC,$EE00
0xa4ce DD           |                   *ILLEGAL*
0xa4cf 0C           |                   INC C
0xa4d0 88           |                   ADC A,B
0xa4d1 88           |                   ADC A,B
0xa4d2 DD 77 FD     |                   LD (IX+$FD),A
0xa4d5 00           |                   NOP
0xa4d6 00           |                   NOP
0xa4d7 00           |                   NOP
0xa4d8 C0           |                   RET NZ
0xa4d9 00           |                   NOP
0xa4da 00           |                   NOP
0xa4db 00           |                   NOP
0xa4dc 00           |                   NOP
0xa4dd 00           |                   NOP
0xa4de 89           |                   ADC A,C
0xa4df 00           |                   NOP
0xa4e0 00           |                   NOP
0xa4e1 00           |                   NOP
0xa4e2 00           |                   NOP
0xa4e3 01 00 00     |                   LD BC,$0000
0xa4e6 00           |                   NOP
0xa4e7 00           |                   NOP
0xa4e8 00           |                   NOP
0xa4e9 00           |                   NOP
0xa4ea 89           |                   ADC A,C
0xa4eb 00           |                   NOP
0xa4ec 00           |                   NOP
0xa4ed 00           |                   NOP
0xa4ee 00           |                   NOP
0xa4ef 00           |                   NOP
0xa4f0 00           |                   NOP
0xa4f1 FF           |                   RST $38
0xa4f2 76           |                   HALT
0xa4f3 02           |                   LD (BC),A
0xa4f4 00           |                   NOP
0xa4f5 00           |                   NOP
0xa4f6 00           |                   NOP
0xa4f7 00           |                   NOP
0xa4f8 00           |                   NOP
0xa4f9 00           |                   NOP
0xa4fa 00           |                   NOP
0xa4fb 00           |                   NOP
0xa4fc 00           |                   NOP
0xa4fd 00           |                   NOP
0xa4fe 76           |                   HALT
0xa4ff 00           |                   NOP
0xa500 00           |                   NOP
0xa501 9D           |                   SBC A,L
0xa502 DA B5 6A     |                   JP C,$6AB5
0xa505 43           |                   LD B,E
0xa506 50           |                   LD D,B
0xa507 44           |                   LD B,H
0xa508 52           |                   LD D,D
0xa509 00           |                   NOP
0xa50a FF           |                   RST $38
0xa50b DB FE        |                   IN A,($FE)
0xa50d 00           |                   NOP
0xa50e 00           |                   NOP
0xa50f FF           |                   RST $38
0xa510 AA           |                   XOR D
0xa511 CC BB EE     |                   CALL Z,$EEBB
0xa514 DD           |                   *ILLEGAL*
0xa515 11 44 88     |                   LD DE,$8844
0xa518 DD 77 FD     |                   LD (IX+$FD),A
0xa51b 34           |                   INC (HL)
0xa51c 12           |                   LD (DE),A
0xa51d 00           |                   NOP
0xa51e C0           |                   RET NZ
0xa51f 00           |                   NOP
0xa520 00           |                   NOP
0xa521 00           |                   NOP
0xa522 00           |                   NOP
0xa523 00           |                   NOP
0xa524 00           |                   NOP
0xa525 00           |                   NOP
0xa526 00           |                   NOP
0xa527 00           |                   NOP
0xa528 00           |                   NOP
0xa529 00           |                   NOP
0xa52a 00           |                   NOP
0xa52b 00           |                   NOP
0xa52c 00           |                   NOP
0xa52d 00           |                   NOP
0xa52e 00           |                   NOP
0xa52f 00           |                   NOP
0xa530 00           |                   NOP
0xa531 00           |                   NOP
0xa532 00           |                   NOP
0xa533 00           |                   NOP
0xa534 00           |                   NOP
0xa535 00           |                   NOP
0xa536 00           |                   NOP
0xa537 FF           |                   RST $38
0xa538 00           |                   NOP
0xa539 00           |                   NOP
0xa53a 00           |                   NOP
0xa53b 00           |                   NOP
0xa53c 00           |                   NOP
0xa53d 00           |                   NOP
0xa53e 00           |                   NOP
0xa53f 00           |                   NOP
0xa540 00           |                   NOP
0xa541 00           |                   NOP
0xa542 00           |                   NOP
0xa543 00           |                   NOP
0xa544 00           |                   NOP
0xa545 00           |                   NOP
0xa546 00           |                   NOP
0xa547 15           |                   DEC D
0xa548 F7           |                   RST $30
0xa549 D9           |                   EXX
0xa54a B8           |                   CP B
0xa54b 49           |                   LD C,C
0xa54c 4E           |                   LD C,(HL)
0xa54d 20 41        |                   JR NZ,$41
0xa54f 2C           |                   INC L
0xa550 28 4E        |                   JR Z,$4E
0xa552 29           |                   ADD HL,HL
0xa553 00           |                   NOP
0xa554 01 FF ED     |                   LD BC,$EDFF
0xa557 40           |                   LD B,B
0xa558 00           |                   NOP
0xa559 00           |                   NOP
0xa55a FF           |                   RST $38
0xa55b AA           |                   XOR D
0xa55c FE BB        |                   CP $BB
0xa55e EE DD        |                   XOR $DD
0xa560 11 44 88     |                   LD DE,$8844
0xa563 DD 77 FD     |                   LD (IX+$FD),A
0xa566 34           |                   INC (HL)
0xa567 12           |                   LD (DE),A
0xa568 00           |                   NOP
0xa569 C0           |                   RET NZ
0xa56a 00           |                   NOP
0xa56b 38 00        |                   JR C,$00
0xa56d 00           |                   NOP
0xa56e 00           |                   NOP
0xa56f 00           |                   NOP
0xa570 00           |                   NOP
0xa571 00           |                   NOP
0xa572 00           |                   NOP
0xa573 00           |                   NOP
0xa574 00           |                   NOP
0xa575 00           |                   NOP
0xa576 00           |                   NOP
0xa577 00           |                   NOP
0xa578 00           |                   NOP
0xa579 00           |                   NOP
0xa57a 00           |                   NOP
0xa57b 00           |                   NOP
0xa57c 00           |                   NOP
0xa57d 00           |                   NOP
0xa57e 00           |                   NOP
0xa57f 00           |                   NOP
0xa580 00           |                   NOP
0xa581 00           |                   NOP
0xa582 FF           |                   RST $38
0xa583 00           |                   NOP
0xa584 00           |                   NOP
0xa585 00           |                   NOP
0xa586 00           |                   NOP
0xa587 00           |                   NOP
0xa588 00           |                   NOP
0xa589 00           |                   NOP
0xa58a 00           |                   NOP
0xa58b 00           |                   NOP
0xa58c 00           |                   NOP
0xa58d 00           |                   NOP
0xa58e 00           |                   NOP
0xa58f 00           |                   NOP
0xa590 00           |                   NOP
0xa591 00           |                   NOP
0xa592 EA 29 12     |                   JP PE,$1229
0xa595 BF           |                   CP A
0xa596 49           |                   LD C,C
0xa597 4E           |                   LD C,(HL)
0xa598 20 52        |                   JR NZ,$52
0xa59a 2C           |                   INC L
0xa59b 28 43        |                   JR Z,$43
0xa59d 29           |                   ADD HL,HL
0xa59e 00           |                   NOP
0xa59f 01 FF ED     |                   LD BC,$EDFF
0xa5a2 70           |                   LD (HL),B
0xa5a3 00           |                   NOP
0xa5a4 00           |                   NOP
0xa5a5 FF           |                   RST $38
0xa5a6 AA           |                   XOR D
0xa5a7 FE BB        |                   CP $BB
0xa5a9 EE DD        |                   XOR $DD
0xa5ab 11 44 88     |                   LD DE,$8844
0xa5ae DD 77 FD     |                   LD (IX+$FD),A
0xa5b1 34           |                   INC (HL)
0xa5b2 12           |                   LD (DE),A
0xa5b3 00           |                   NOP
0xa5b4 C0           |                   RET NZ
0xa5b5 00           |                   NOP
0xa5b6 00           |                   NOP
0xa5b7 00           |                   NOP
0xa5b8 00           |                   NOP
0xa5b9 00           |                   NOP
0xa5ba 00           |                   NOP
0xa5bb 00           |                   NOP
0xa5bc 00           |                   NOP
0xa5bd 00           |                   NOP
0xa5be 00           |                   NOP
0xa5bf 00           |                   NOP
0xa5c0 00           |                   NOP
0xa5c1 00           |                   NOP
0xa5c2 00           |                   NOP
0xa5c3 00           |                   NOP
0xa5c4 00           |                   NOP
0xa5c5 00           |                   NOP
0xa5c6 00           |                   NOP
0xa5c7 00           |                   NOP
0xa5c8 00           |                   NOP
0xa5c9 00           |                   NOP
0xa5ca 00           |                   NOP
0xa5cb 00           |                   NOP
0xa5cc 00           |                   NOP
0xa5cd FF           |                   RST $38
0xa5ce 00           |                   NOP
0xa5cf 00           |                   NOP
0xa5d0 00           |                   NOP
0xa5d1 00           |                   NOP
0xa5d2 00           |                   NOP
0xa5d3 00           |                   NOP
0xa5d4 00           |                   NOP
0xa5d5 00           |                   NOP
0xa5d6 00           |                   NOP
0xa5d7 00           |                   NOP
0xa5d8 00           |                   NOP
0xa5d9 00           |                   NOP
0xa5da 00           |                   NOP
0xa5db 00           |                   NOP
0xa5dc 00           |                   NOP
0xa5dd 68           |                   LD L,B
0xa5de 39           |                   ADD HL,SP
0xa5df 2C           |                   INC L
0xa5e0 0E 49        |                   LD C,$49
0xa5e2 4E           |                   LD C,(HL)
0xa5e3 20 28        |                   JR NZ,$28
0xa5e5 43           |                   LD B,E
0xa5e6 29           |                   ADD HL,HL
0xa5e7 00           |                   NOP
0xa5e8 01 FF ED     |                   LD BC,$EDFF
0xa5eb A2           |                   AND D
0xa5ec 00           |                   NOP
0xa5ed 00           |                   NOP
0xa5ee FF           |                   RST $38
0xa5ef AA           |                   XOR D
0xa5f0 FE 00        |                   CP $00
0xa5f2 EE DD        |                   XOR $DD
0xa5f4 0C           |                   INC C
0xa5f5 88           |                   ADC A,B
0xa5f6 88           |                   ADC A,B
0xa5f7 DD 77 FD     |                   LD (IX+$FD),A
0xa5fa 34           |                   INC (HL)
0xa5fb 12           |                   LD (DE),A
0xa5fc 00           |                   NOP
0xa5fd C0           |                   RET NZ
0xa5fe 00           |                   NOP
0xa5ff 00           |                   NOP
0xa600 00           |                   NOP
0xa601 00           |                   NOP
0xa602 00           |                   NOP
0xa603 00           |                   NOP
0xa604 00           |                   NOP
0xa605 FF           |                   RST $38
0xa606 00           |                   NOP
0xa607 00           |                   NOP
0xa608 00           |                   NOP
0xa609 00           |                   NOP
0xa60a 00           |                   NOP
0xa60b 00           |                   NOP
0xa60c 00           |                   NOP
0xa60d 00           |                   NOP
0xa60e 00           |                   NOP
0xa60f 00           |                   NOP
0xa610 00           |                   NOP
0xa611 00           |                   NOP
0xa612 00           |                   NOP
0xa613 00           |                   NOP
0xa614 00           |                   NOP
0xa615 00           |                   NOP
0xa616 FF           |                   RST $38
0xa617 00           |                   NOP
0xa618 00           |                   NOP
0xa619 00           |                   NOP
0xa61a 00           |                   NOP
0xa61b 00           |                   NOP
0xa61c 01 00 00     |                   LD BC,$0000
0xa61f 00           |                   NOP
0xa620 00           |                   NOP
0xa621 00           |                   NOP
0xa622 00           |                   NOP
0xa623 00           |                   NOP
0xa624 00           |                   NOP
0xa625 00           |                   NOP
0xa626 03           |                   INC BC
0xa627 DA 75 34     |                   JP C,$3475
0xa62a 49           |                   LD C,C
0xa62b 4E           |                   LD C,(HL)
0xa62c 49           |                   LD C,C
0xa62d 00           |                   NOP
0xa62e 01 FF ED     |                   LD BC,$EDFF
0xa631 AA           |                   XOR D
0xa632 00           |                   NOP
0xa633 00           |                   NOP
0xa634 FF           |                   RST $38
0xa635 AA           |                   XOR D
0xa636 FE 00        |                   CP $00
0xa638 EE DD        |                   XOR $DD
0xa63a 0C           |                   INC C
0xa63b 88           |                   ADC A,B
0xa63c 88           |                   ADC A,B
0xa63d DD 77 FD     |                   LD (IX+$FD),A
0xa640 34           |                   INC (HL)
0xa641 12           |                   LD (DE),A
0xa642 00           |                   NOP
0xa643 C0           |                   RET NZ
0xa644 00           |                   NOP
0xa645 00           |                   NOP
0xa646 00           |                   NOP
0xa647 00           |                   NOP
0xa648 00           |                   NOP
0xa649 00           |                   NOP
0xa64a 00           |                   NOP
0xa64b FF           |                   RST $38
0xa64c 00           |                   NOP
0xa64d 00           |                   NOP
0xa64e 00           |                   NOP
0xa64f 00           |                   NOP
0xa650 00           |                   NOP
0xa651 00           |                   NOP
0xa652 00           |                   NOP
0xa653 00           |                   NOP
0xa654 00           |                   NOP
0xa655 00           |                   NOP
0xa656 00           |                   NOP
0xa657 00           |                   NOP
0xa658 00           |                   NOP
0xa659 00           |                   NOP
0xa65a 00           |                   NOP
0xa65b 00           |                   NOP
0xa65c FF           |                   RST $38
0xa65d 00           |                   NOP
0xa65e 00           |                   NOP
0xa65f 00           |                   NOP
0xa660 00           |                   NOP
0xa661 00           |                   NOP
0xa662 01 00 00     |                   LD BC,$0000
0xa665 00           |                   NOP
0xa666 00           |                   NOP
0xa667 00           |                   NOP
0xa668 00           |                   NOP
0xa669 00           |                   NOP
0xa66a 00           |                   NOP
0xa66b 00           |                   NOP
0xa66c 4C           |                   LD C,H
0xa66d 30 6B        |                   JR NC,$6B
0xa66f 87           |                   AA,A
0xa670 49           |                   LD C,C
0xa671 4E           |                   LD C,(HL)
0xa672 44           |                   LD B,H
0xa673 00           |                   NOP
0xa674 01 FF ED     |                   LD BC,$EDFF
0xa677 B2           |                   OR D
0xa678 00           |                   NOP
0xa679 00           |                   NOP
0xa67a FF           |                   RST $38
0xa67b AA           |                   XOR D
0xa67c FE 01        |                   CP $01
0xa67e EE DD        |                   XOR $DD
0xa680 0C           |                   INC C
0xa681 88           |                   ADC A,B
0xa682 88           |                   ADC A,B
0xa683 DD 77 FD     |                   LD (IX+$FD),A
0xa686 34           |                   INC (HL)
0xa687 12           |                   LD (DE),A
0xa688 00           |                   NOP
0xa689 C0           |                   RET NZ
0xa68a 00           |                   NOP
0xa68b 00           |                   NOP
0xa68c 00           |                   NOP
0xa68d 00           |                   NOP
0xa68e 00           |                   NOP
0xa68f 00           |                   NOP
0xa690 00           |                   NOP
0xa691 00           |                   NOP
0xa692 00           |                   NOP
0xa693 00           |                   NOP
0xa694 00           |                   NOP
0xa695 00           |                   NOP
0xa696 00           |                   NOP
0xa697 00           |                   NOP
0xa698 00           |                   NOP
0xa699 00           |                   NOP
0xa69a 00           |                   NOP
0xa69b 00           |                   NOP
0xa69c 00           |                   NOP
0xa69d 00           |                   NOP
0xa69e 00           |                   NOP
0xa69f 00           |                   NOP
0xa6a0 00           |                   NOP
0xa6a1 00           |                   NOP
0xa6a2 FF           |                   RST $38
0xa6a3 00           |                   NOP
0xa6a4 00           |                   NOP
0xa6a5 02           |                   LD (BC),A
0xa6a6 00           |                   NOP
0xa6a7 00           |                   NOP
0xa6a8 01 00 00     |                   LD BC,$0000
0xa6ab 00           |                   NOP
0xa6ac 00           |                   NOP
0xa6ad 00           |                   NOP
0xa6ae 00           |                   NOP
0xa6af 00           |                   NOP
0xa6b0 00           |                   NOP
0xa6b1 00           |                   NOP
0xa6b2 B1           |                   OR C
0xa6b3 C5           |                   PUSH BC
0xa6b4 80           |                   AA,B
0xa6b5 A1           |                   AND C
0xa6b6 49           |                   LD C,C
0xa6b7 4E           |                   LD C,(HL)
0xa6b8 49           |                   LD C,C
0xa6b9 52           |                   LD D,D
0xa6ba 00           |                   NOP
0xa6bb 01 FF ED     |                   LD BC,$EDFF
0xa6be BA           |                   CP D
0xa6bf 00           |                   NOP
0xa6c0 00           |                   NOP
0xa6c1 FF           |                   RST $38
0xa6c2 AA           |                   XOR D
0xa6c3 FE 01        |                   CP $01
0xa6c5 EE DD        |                   XOR $DD
0xa6c7 0D           |                   DEC C
0xa6c8 88           |                   ADC A,B
0xa6c9 88           |                   ADC A,B
0xa6ca DD 77 FD     |                   LD (IX+$FD),A
0xa6cd 34           |                   INC (HL)
0xa6ce 12           |                   LD (DE),A
0xa6cf 00           |                   NOP
0xa6d0 C0           |                   RET NZ
0xa6d1 00           |                   NOP
0xa6d2 00           |                   NOP
0xa6d3 00           |                   NOP
0xa6d4 00           |                   NOP
0xa6d5 00           |                   NOP
0xa6d6 00           |                   NOP
0xa6d7 00           |                   NOP
0xa6d8 00           |                   NOP
0xa6d9 00           |                   NOP
0xa6da 00           |                   NOP
0xa6db 00           |                   NOP
0xa6dc 00           |                   NOP
0xa6dd 00           |                   NOP
0xa6de 00           |                   NOP
0xa6df 00           |                   NOP
0xa6e0 00           |                   NOP
0xa6e1 00           |                   NOP
0xa6e2 00           |                   NOP
0xa6e3 00           |                   NOP
0xa6e4 00           |                   NOP
0xa6e5 00           |                   NOP
0xa6e6 00           |                   NOP
0xa6e7 00           |                   NOP
0xa6e8 00           |                   NOP
0xa6e9 FF           |                   RST $38
0xa6ea 00           |                   NOP
0xa6eb 00           |                   NOP
0xa6ec 02           |                   LD (BC),A
0xa6ed 00           |                   NOP
0xa6ee 00           |                   NOP
0xa6ef 01 00 00     |                   LD BC,$0000
0xa6f2 00           |                   NOP
0xa6f3 00           |                   NOP
0xa6f4 00           |                   NOP
0xa6f5 00           |                   NOP
0xa6f6 00           |                   NOP
0xa6f7 00           |                   NOP
0xa6f8 00           |                   NOP
0xa6f9 88           |                   ADC A,B
0xa6fa F0           |                   RET P
0xa6fb 04           |                   INC B
0xa6fc AA           |                   XOR D
0xa6fd 49           |                   LD C,C
0xa6fe 4E           |                   LD C,(HL)
0xa6ff 44           |                   LD B,H
0xa700 52           |                   LD D,D
0xa701 00           |                   NOP
0xa702 01 FF ED     |                   LD BC,$EDFF
0xa705 B2           |                   OR D
0xa706 00           |                   NOP
0xa707 00           |                   NOP
0xa708 FF           |                   RST $38
0xa709 AA           |                   XOR D
0xa70a FE 00        |                   CP $00
0xa70c EE DD        |                   XOR $DD
0xa70e 2C           |                   INC L
0xa70f 83           |                   AA,E
0xa710 88           |                   ADC A,B
0xa711 DD 77 FD     |                   LD (IX+$FD),A
0xa714 00           |                   NOP
0xa715 00           |                   NOP
0xa716 00           |                   NOP
0xa717 C0           |                   RET NZ
0xa718 00           |                   NOP
0xa719 00           |                   NOP
0xa71a 00           |                   NOP
0xa71b 00           |                   NOP
0xa71c 38 00        |                   JR C,$00
0xa71e 00           |                   NOP
0xa71f 01 00 00     |                   LD BC,$0000
0xa722 00           |                   NOP
0xa723 00           |                   NOP
0xa724 00           |                   NOP
0xa725 00           |                   NOP
0xa726 00           |                   NOP
0xa727 00           |                   NOP
0xa728 00           |                   NOP
0xa729 00           |                   NOP
0xa72a 00           |                   NOP
0xa72b 00           |                   NOP
0xa72c 00           |                   NOP
0xa72d 00           |                   NOP
0xa72e 00           |                   NOP
0xa72f 00           |                   NOP
0xa730 C7           |                   RST $00
0xa731 00           |                   NOP
0xa732 00           |                   NOP
0xa733 FE 00        |                   CP $00
0xa735 00           |                   NOP
0xa736 00           |                   NOP
0xa737 00           |                   NOP
0xa738 00           |                   NOP
0xa739 00           |                   NOP
0xa73a 00           |                   NOP
0xa73b 00           |                   NOP
0xa73c 00           |                   NOP
0xa73d 00           |                   NOP
0xa73e 00           |                   NOP
0xa73f 00           |                   NOP
0xa740 45           |                   LD B,L
0xa741 4E           |                   LD C,(HL)
0xa742 35           |                   DEC (HL)
0xa743 31 49 4E     |                   LD SP,$4E49
0xa746 49           |                   LD C,C
0xa747 52           |                   LD D,D
0xa748 2D           |                   DEC L
0xa749 3E 4E        |                   LD A,$4E
0xa74b 4F           |                   LD C,A
0xa74c 50           |                   LD D,B
0xa74d 27           |                   DAA
0xa74e 00           |                   NOP
0xa74f 01 FF ED     |                   LD BC,$EDFF
0xa752 BA           |                   CP D
0xa753 00           |                   NOP
0xa754 00           |                   NOP
0xa755 FF           |                   RST $38
0xa756 AA           |                   XOR D
0xa757 FE 00        |                   CP $00
0xa759 EE DD        |                   XOR $DD
0xa75b 2C           |                   INC L
0xa75c 83           |                   AA,E
0xa75d 88           |                   ADC A,B
0xa75e DD 77 FD     |                   LD (IX+$FD),A
0xa761 00           |                   NOP
0xa762 00           |                   NOP
0xa763 00           |                   NOP
0xa764 C0           |                   RET NZ
0xa765 00           |                   NOP
0xa766 00           |                   NOP
0xa767 00           |                   NOP
0xa768 00           |                   NOP
0xa769 38 00        |                   JR C,$00
0xa76b 00           |                   NOP
0xa76c 01 00 00     |                   LD BC,$0000
0xa76f 00           |                   NOP
0xa770 00           |                   NOP
0xa771 00           |                   NOP
0xa772 00           |                   NOP
0xa773 00           |                   NOP
0xa774 00           |                   NOP
0xa775 00           |                   NOP
0xa776 00           |                   NOP
0xa777 00           |                   NOP
0xa778 00           |                   NOP
0xa779 00           |                   NOP
0xa77a 00           |                   NOP
0xa77b 00           |                   NOP
0xa77c 00           |                   NOP
0xa77d C7           |                   RST $00
0xa77e 00           |                   NOP
0xa77f 00           |                   NOP
0xa780 FE 00        |                   CP $00
0xa782 00           |                   NOP
0xa783 00           |                   NOP
0xa784 00           |                   NOP
0xa785 00           |                   NOP
0xa786 00           |                   NOP
0xa787 00           |                   NOP
0xa788 00           |                   NOP
0xa789 00           |                   NOP
0xa78a 00           |                   NOP
0xa78b 00           |                   NOP
0xa78c 00           |                   NOP
0xa78d 06 BC        |                   LD B,$BC
0xa78f 40           |                   LD B,B
0xa790 C4 49 4E     |                   CALL NZ,$4E49
0xa793 44           |                   LD B,H
0xa794 52           |                   LD D,D
0xa795 2D           |                   DEC L
0xa796 3E 4E        |                   LD A,$4E
0xa798 4F           |                   LD C,A
0xa799 50           |                   LD D,B
0xa79a 27           |                   DAA
0xa79b 00           |                   NOP
0xa79c 01 FF D3     |                   LD BC,$D3FF
0xa79f FE 00        |                   CP $00
0xa7a1 00           |                   NOP
0xa7a2 FF           |                   RST $38
0xa7a3 AA           |                   XOR D
0xa7a4 CC BB EE     |                   CALL Z,$EEBB
0xa7a7 DD           |                   *ILLEGAL*
0xa7a8 11 44 88     |                   LD DE,$8844
0xa7ab DD 77 FD     |                   LD (IX+$FD),A
0xa7ae 34           |                   INC (HL)
0xa7af 12           |                   LD (DE),A
0xa7b0 00           |                   NOP
0xa7b1 C0           |                   RET NZ
0xa7b2 00           |                   NOP
0xa7b3 00           |                   NOP
0xa7b4 00           |                   NOP
0xa7b5 00           |                   NOP
0xa7b6 00           |                   NOP
0xa7b7 FF           |                   RST $38
0xa7b8 00           |                   NOP
0xa7b9 00           |                   NOP
0xa7ba 00           |                   NOP
0xa7bb 00           |                   NOP
0xa7bc 00           |                   NOP
0xa7bd 00           |                   NOP
0xa7be 00           |                   NOP
0xa7bf 00           |                   NOP
0xa7c0 00           |                   NOP
0xa7c1 00           |                   NOP
0xa7c2 00           |                   NOP
0xa7c3 00           |                   NOP
0xa7c4 00           |                   NOP
0xa7c5 00           |                   NOP
0xa7c6 00           |                   NOP
0xa7c7 00           |                   NOP
0xa7c8 00           |                   NOP
0xa7c9 00           |                   NOP
0xa7ca FF           |                   RST $38
0xa7cb 00           |                   NOP
0xa7cc 00           |                   NOP
0xa7cd 00           |                   NOP
0xa7ce 00           |                   NOP
0xa7cf 00           |                   NOP
0xa7d0 00           |                   NOP
0xa7d1 00           |                   NOP
0xa7d2 00           |                   NOP
0xa7d3 00           |                   NOP
0xa7d4 00           |                   NOP
0xa7d5 00           |                   NOP
0xa7d6 00           |                   NOP
0xa7d7 00           |                   NOP
0xa7d8 00           |                   NOP
0xa7d9 00           |                   NOP
0xa7da FA AF A4     |                   JP M,$A4AF
0xa7dd D0           |                   RET NC
0xa7de 4F           |                   LD C,A
0xa7df 55           |                   LD D,L
0xa7e0 54           |                   LD D,H
0xa7e1 20 28        |                   JR NZ,$28
0xa7e3 4E           |                   LD C,(HL)
0xa7e4 29           |                   ADD HL,HL
0xa7e5 2C           |                   INC L
0xa7e6 41           |                   LD B,C
0xa7e7 00           |                   NOP
0xa7e8 FF           |                   RST $38
0xa7e9 ED 41        |                   OUT (C),B
0xa7eb 00           |                   NOP
0xa7ec 00           |                   NOP
0xa7ed FF           |                   RST $38
0xa7ee AA           |                   XOR D
0xa7ef FE 00        |                   CP $00
0xa7f1 EE DD        |                   XOR $DD
0xa7f3 11 44 88     |                   LD DE,$8844
0xa7f6 DD 77 FD     |                   LD (IX+$FD),A
0xa7f9 34           |                   INC (HL)
0xa7fa 12           |                   LD (DE),A
0xa7fb 00           |                   NOP
0xa7fc C0           |                   RET NZ
0xa7fd 00           |                   NOP
0xa7fe 38 00        |                   JR C,$00
0xa800 00           |                   NOP
0xa801 00           |                   NOP
0xa802 00           |                   NOP
0xa803 00           |                   NOP
0xa804 00           |                   NOP
0xa805 00           |                   NOP
0xa806 00           |                   NOP
0xa807 00           |                   NOP
0xa808 00           |                   NOP
0xa809 00           |                   NOP
0xa80a 00           |                   NOP
0xa80b 00           |                   NOP
0xa80c 00           |                   NOP
0xa80d 00           |                   NOP
0xa80e 00           |                   NOP
0xa80f 00           |                   NOP
0xa810 00           |                   NOP
0xa811 00           |                   NOP
0xa812 00           |                   NOP
0xa813 00           |                   NOP
0xa814 00           |                   NOP
0xa815 FF           |                   RST $38
0xa816 FF           |                   RST $38
0xa817 00           |                   NOP
0xa818 FF           |                   RST $38
0xa819 FF           |                   RST $38
0xa81a FF           |                   RST $38
0xa81b FF           |                   RST $38
0xa81c FF           |                   RST $38
0xa81d 00           |                   NOP
0xa81e 00           |                   NOP
0xa81f 00           |                   NOP
0xa820 00           |                   NOP
0xa821 00           |                   NOP
0xa822 00           |                   NOP
0xa823 00           |                   NOP
0xa824 00           |                   NOP
0xa825 57           |                   LD D,A
0xa826 E2 AF D4     |                   JP PO,$D4AF
0xa829 4F           |                   LD C,A
0xa82a 55           |                   LD D,L
0xa82b 54           |                   LD D,H
0xa82c 20 28        |                   JR NZ,$28
0xa82e 43           |                   LD B,E
0xa82f 29           |                   ADD HL,HL
0xa830 2C           |                   INC L
0xa831 52           |                   LD D,D
0xa832 00           |                   NOP
0xa833 FF           |                   RST $38
0xa834 ED 71        |                   OUT (C),F
0xa836 00           |                   NOP
0xa837 00           |                   NOP
0xa838 FF           |                   RST $38
0xa839 AA           |                   XOR D
0xa83a FE 00        |                   CP $00
0xa83c EE DD        |                   XOR $DD
0xa83e 11 44 88     |                   LD DE,$8844
0xa841 DD 77 FD     |                   LD (IX+$FD),A
0xa844 34           |                   INC (HL)
0xa845 12           |                   LD (DE),A
0xa846 00           |                   NOP
0xa847 C0           |                   RET NZ
0xa848 00           |                   NOP
0xa849 00           |                   NOP
0xa84a 00           |                   NOP
0xa84b 00           |                   NOP
0xa84c 00           |                   NOP
0xa84d 00           |                   NOP
0xa84e 00           |                   NOP
0xa84f 00           |                   NOP
0xa850 00           |                   NOP
0xa851 00           |                   NOP
0xa852 00           |                   NOP
0xa853 00           |                   NOP
0xa854 00           |                   NOP
0xa855 00           |                   NOP
0xa856 00           |                   NOP
0xa857 00           |                   NOP
0xa858 00           |                   NOP
0xa859 00           |                   NOP
0xa85a 00           |                   NOP
0xa85b 00           |                   NOP
0xa85c 00           |                   NOP
0xa85d 00           |                   NOP
0xa85e 00           |                   NOP
0xa85f 00           |                   NOP
0xa860 FF           |                   RST $38
0xa861 FF           |                   RST $38
0xa862 00           |                   NOP
0xa863 FF           |                   RST $38
0xa864 00           |                   NOP
0xa865 00           |                   NOP
0xa866 00           |                   NOP
0xa867 00           |                   NOP
0xa868 00           |                   NOP
0xa869 00           |                   NOP
0xa86a 00           |                   NOP
0xa86b 00           |                   NOP
0xa86c 00           |                   NOP
0xa86d 00           |                   NOP
0xa86e 00           |                   NOP
0xa86f 00           |                   NOP
0xa870 54           |                   LD D,H
0xa871 72           |                   LD (HL),D
0xa872 FB           |                   EI
0xa873 D0           |                   RET NC
0xa874 4F           |                   LD C,A
0xa875 55           |                   LD D,L
0xa876 54           |                   LD D,H
0xa877 20 28        |                   JR NZ,$28
0xa879 43           |                   LD B,E
0xa87a 29           |                   ADD HL,HL
0xa87b 2C           |                   INC L
0xa87c 30 00        |                   JR NC,$00
0xa87e FF           |                   RST $38
0xa87f ED A3        |                   OTI
0xa881 00           |                   NOP
0xa882 00           |                   NOP
0xa883 FF           |                   RST $38
0xa884 AA           |                   XOR D
0xa885 FE 00        |                   CP $00
0xa887 EE DD        |                   XOR $DD
0xa889 0C           |                   INC C
0xa88a 88           |                   ADC A,B
0xa88b 88           |                   ADC A,B
0xa88c DD 77 FD     |                   LD (IX+$FD),A
0xa88f 00           |                   NOP
0xa890 00           |                   NOP
0xa891 00           |                   NOP
0xa892 C0           |                   RET NZ
0xa893 00           |                   NOP
0xa894 00           |                   NOP
0xa895 00           |                   NOP
0xa896 00           |                   NOP
0xa897 00           |                   NOP
0xa898 00           |                   NOP
0xa899 00           |                   NOP
0xa89a 87           |                   AA,A
0xa89b 00           |                   NOP
0xa89c 00           |                   NOP
0xa89d 00           |                   NOP
0xa89e 00           |                   NOP
0xa89f 00           |                   NOP
0xa8a0 00           |                   NOP
0xa8a1 00           |                   NOP
0xa8a2 00           |                   NOP
0xa8a3 87           |                   AA,A
0xa8a4 00           |                   NOP
0xa8a5 00           |                   NOP
0xa8a6 00           |                   NOP
0xa8a7 00           |                   NOP
0xa8a8 00           |                   NOP
0xa8a9 00           |                   NOP
0xa8aa 00           |                   NOP
0xa8ab FF           |                   RST $38
0xa8ac 00           |                   NOP
0xa8ad 00           |                   NOP
0xa8ae 78           |                   LD A,B
0xa8af 00           |                   NOP
0xa8b0 00           |                   NOP
0xa8b1 01 00 00     |                   LD BC,$0000
0xa8b4 00           |                   NOP
0xa8b5 00           |                   NOP
0xa8b6 00           |                   NOP
0xa8b7 78           |                   LD A,B
0xa8b8 00           |                   NOP
0xa8b9 00           |                   NOP
0xa8ba 00           |                   NOP
0xa8bb 6B           |                   LD L,E
0xa8bc 09           |                   ADD HL,BC
0xa8bd C8           |                   RET Z
0xa8be E2 4F 55     |                   JP PO,$554F
0xa8c1 54           |                   LD D,H
0xa8c2 49           |                   LD C,C
0xa8c3 00           |                   NOP
0xa8c4 FF           |                   RST $38
0xa8c5 ED AB        |                   OTD
0xa8c7 00           |                   NOP
0xa8c8 00           |                   NOP
0xa8c9 FF           |                   RST $38
0xa8ca AA           |                   XOR D
0xa8cb FE 00        |                   CP $00
0xa8cd EE DD        |                   XOR $DD
0xa8cf 0C           |                   INC C
0xa8d0 88           |                   ADC A,B
0xa8d1 88           |                   ADC A,B
0xa8d2 DD 77 FD     |                   LD (IX+$FD),A
0xa8d5 00           |                   NOP
0xa8d6 00           |                   NOP
0xa8d7 00           |                   NOP
0xa8d8 C0           |                   RET NZ
0xa8d9 00           |                   NOP
0xa8da 00           |                   NOP
0xa8db 00           |                   NOP
0xa8dc 00           |                   NOP
0xa8dd 00           |                   NOP
0xa8de 00           |                   NOP
0xa8df 00           |                   NOP
0xa8e0 87           |                   AA,A
0xa8e1 00           |                   NOP
0xa8e2 00           |                   NOP
0xa8e3 00           |                   NOP
0xa8e4 00           |                   NOP
0xa8e5 00           |                   NOP
0xa8e6 00           |                   NOP
0xa8e7 00           |                   NOP
0xa8e8 00           |                   NOP
0xa8e9 87           |                   AA,A
0xa8ea 00           |                   NOP
0xa8eb 00           |                   NOP
0xa8ec 00           |                   NOP
0xa8ed 00           |                   NOP
0xa8ee 00           |                   NOP
0xa8ef 00           |                   NOP
0xa8f0 00           |                   NOP
0xa8f1 FF           |                   RST $38
0xa8f2 00           |                   NOP
0xa8f3 00           |                   NOP
0xa8f4 78           |                   LD A,B
0xa8f5 00           |                   NOP
0xa8f6 00           |                   NOP
0xa8f7 01 00 00     |                   LD BC,$0000
0xa8fa 00           |                   NOP
0xa8fb 00           |                   NOP
0xa8fc 00           |                   NOP
0xa8fd 78           |                   LD A,B
0xa8fe 00           |                   NOP
0xa8ff 00           |                   NOP
0xa900 00           |                   NOP
0xa901 C1           |                   POP BC
0xa902 86           |                   AA,(HL)
0xa903 ED           |                   *ILLEGAL*
0xa904 7F           |                   LD A,A
0xa905 4F           |                   LD C,A
0xa906 55           |                   LD D,L
0xa907 54           |                   LD D,H
0xa908 44           |                   LD B,H
0xa909 00           |                   NOP
0xa90a FF           |                   RST $38
0xa90b ED B3        |                   OTIR
0xa90d 00           |                   NOP
0xa90e 00           |                   NOP
0xa90f FF           |                   RST $38
0xa910 AA           |                   XOR D
0xa911 FE 01        |                   CP $01
0xa913 EE DD        |                   XOR $DD
0xa915 0C           |                   INC C
0xa916 88           |                   ADC A,B
0xa917 88           |                   ADC A,B
0xa918 DD 77 FD     |                   LD (IX+$FD),A
0xa91b 00           |                   NOP
0xa91c 00           |                   NOP
0xa91d 00           |                   NOP
0xa91e C0           |                   RET NZ
0xa91f 00           |                   NOP
0xa920 00           |                   NOP
0xa921 00           |                   NOP
0xa922 00           |                   NOP
0xa923 00           |                   NOP
0xa924 00           |                   NOP
0xa925 00           |                   NOP
0xa926 00           |                   NOP
0xa927 00           |                   NOP
0xa928 00           |                   NOP
0xa929 00           |                   NOP
0xa92a 00           |                   NOP
0xa92b 00           |                   NOP
0xa92c 00           |                   NOP
0xa92d 00           |                   NOP
0xa92e 00           |                   NOP
0xa92f 87           |                   AA,A
0xa930 00           |                   NOP
0xa931 00           |                   NOP
0xa932 00           |                   NOP
0xa933 00           |                   NOP
0xa934 00           |                   NOP
0xa935 00           |                   NOP
0xa936 00           |                   NOP
0xa937 FF           |                   RST $38
0xa938 00           |                   NOP
0xa939 00           |                   NOP
0xa93a 02           |                   LD (BC),A
0xa93b 00           |                   NOP
0xa93c 00           |                   NOP
0xa93d 01 00 00     |                   LD BC,$0000
0xa940 00           |                   NOP
0xa941 00           |                   NOP
0xa942 00           |                   NOP
0xa943 78           |                   LD A,B
0xa944 00           |                   NOP
0xa945 00           |                   NOP
0xa946 00           |                   NOP
0xa947 36 6E        |                   LD (HL),$6E
0xa949 15           |                   DEC D
0xa94a 54           |                   LD D,H
0xa94b 4F           |                   LD C,A
0xa94c 54           |                   LD D,H
0xa94d 49           |                   LD C,C
0xa94e 52           |                   LD D,D
0xa94f 00           |                   NOP
0xa950 FF           |                   RST $38
0xa951 ED BB        |                   OTDR
0xa953 00           |                   NOP
0xa954 00           |                   NOP
0xa955 FF           |                   RST $38
0xa956 AA           |                   XOR D
0xa957 FE 01        |                   CP $01
0xa959 EE DD        |                   XOR $DD
0xa95b 0D           |                   DEC C
0xa95c 88           |                   ADC A,B
0xa95d 88           |                   ADC A,B
0xa95e DD 77 FD     |                   LD (IX+$FD),A
0xa961 00           |                   NOP
0xa962 00           |                   NOP
0xa963 00           |                   NOP
0xa964 C0           |                   RET NZ
0xa965 00           |                   NOP
0xa966 00           |                   NOP
0xa967 00           |                   NOP
0xa968 00           |                   NOP
0xa969 00           |                   NOP
0xa96a 00           |                   NOP
0xa96b 00           |                   NOP
0xa96c 00           |                   NOP
0xa96d 00           |                   NOP
0xa96e 00           |                   NOP
0xa96f 00           |                   NOP
0xa970 00           |                   NOP
0xa971 00           |                   NOP
0xa972 00           |                   NOP
0xa973 00           |                   NOP
0xa974 00           |                   NOP
0xa975 00           |                   NOP
0xa976 87           |                   AA,A
0xa977 00           |                   NOP
0xa978 00           |                   NOP
0xa979 00           |                   NOP
0xa97a 00           |                   NOP
0xa97b 00           |                   NOP
0xa97c 00           |                   NOP
0xa97d FF           |                   RST $38
0xa97e 00           |                   NOP
0xa97f 00           |                   NOP
0xa980 02           |                   LD (BC),A
0xa981 00           |                   NOP
0xa982 00           |                   NOP
0xa983 01 00 00     |                   LD BC,$0000
0xa986 00           |                   NOP
0xa987 00           |                   NOP
0xa988 00           |                   NOP
0xa989 00           |                   NOP
0xa98a 78           |                   LD A,B
0xa98b 00           |                   NOP
0xa98c 00           |                   NOP
0xa98d 17           |                   RLA
0xa98e 81           |                   AA,C
0xa98f B9           |                   CP C
0xa990 76           |                   HALT
0xa991 4F           |                   LD C,A
0xa992 54           |                   LD D,H
0xa993 44           |                   LD B,H
0xa994 52           |                   LD D,D
0xa995 00           |                   NOP
0xa996 FF           |                   RST $38
0xa997 C3 10 88     |                   JP $8810
0xa99a 00           |                   NOP
0xa99b FF           |                   RST $38
0xa99c AA           |                   XOR D
0xa99d CC BB EE     |                   CALL Z,$EEBB
0xa9a0 DD           |                   *ILLEGAL*
0xa9a1 11 44 88     |                   LD DE,$8844
0xa9a4 DD 77 FD     |                   LD (IX+$FD),A
0xa9a7 34           |                   INC (HL)
0xa9a8 12           |                   LD (DE),A
0xa9a9 00           |                   NOP
0xa9aa C0           |                   RET NZ
0xa9ab 00           |                   NOP
0xa9ac 00           |                   NOP
0xa9ad 00           |                   NOP
0xa9ae 00           |                   NOP
0xa9af 00           |                   NOP
0xa9b0 00           |                   NOP
0xa9b1 00           |                   NOP
0xa9b2 00           |                   NOP
0xa9b3 00           |                   NOP
0xa9b4 00           |                   NOP
0xa9b5 00           |                   NOP
0xa9b6 00           |                   NOP
0xa9b7 00           |                   NOP
0xa9b8 00           |                   NOP
0xa9b9 00           |                   NOP
0xa9ba 00           |                   NOP
0xa9bb 00           |                   NOP
0xa9bc 00           |                   NOP
0xa9bd 00           |                   NOP
0xa9be 00           |                   NOP
0xa9bf 00           |                   NOP
0xa9c0 00           |                   NOP
0xa9c1 00           |                   NOP
0xa9c2 00           |                   NOP
0xa9c3 FF           |                   RST $38
0xa9c4 00           |                   NOP
0xa9c5 00           |                   NOP
0xa9c6 00           |                   NOP
0xa9c7 00           |                   NOP
0xa9c8 00           |                   NOP
0xa9c9 00           |                   NOP
0xa9ca 00           |                   NOP
0xa9cb 00           |                   NOP
0xa9cc 00           |                   NOP
0xa9cd 00           |                   NOP
0xa9ce 00           |                   NOP
0xa9cf 00           |                   NOP
0xa9d0 00           |                   NOP
0xa9d1 00           |                   NOP
0xa9d2 00           |                   NOP
0xa9d3 71           |                   LD (HL),C
0xa9d4 9D           |                   SBC A,L
0xa9d5 5E           |                   LD E,(HL)
0xa9d6 47           |                   LD B,A
0xa9d7 4A           |                   LD C,D
0xa9d8 50           |                   LD D,B
0xa9d9 20 4E        |                   JR NZ,$4E
0xa9db 4E           |                   LD C,(HL)
0xa9dc 00           |                   NOP
0xa9dd FF           |                   RST $38
0xa9de C2 10 88     |                   JP NZ,$8810
0xa9e1 00           |                   NOP
0xa9e2 FF           |                   RST $38
0xa9e3 AA           |                   XOR D
0xa9e4 CC BB EE     |                   CALL Z,$EEBB
0xa9e7 DD           |                   *ILLEGAL*
0xa9e8 11 44 88     |                   LD DE,$8844
0xa9eb DD 77 FD     |                   LD (IX+$FD),A
0xa9ee 34           |                   INC (HL)
0xa9ef 12           |                   LD (DE),A
0xa9f0 00           |                   NOP
0xa9f1 C0           |                   RET NZ
0xa9f2 38 00        |                   JR C,$00
0xa9f4 00           |                   NOP
0xa9f5 00           |                   NOP
0xa9f6 00           |                   NOP
0xa9f7 00           |                   NOP
0xa9f8 00           |                   NOP
0xa9f9 00           |                   NOP
0xa9fa 00           |                   NOP
0xa9fb 00           |                   NOP
0xa9fc 00           |                   NOP
0xa9fd 00           |                   NOP
0xa9fe 00           |                   NOP
0xa9ff 00           |                   NOP
0xaa00 00           |                   NOP
0xaa01 00           |                   NOP
0xaa02 00           |                   NOP
0xaa03 00           |                   NOP
0xaa04 00           |                   NOP
0xaa05 00           |                   NOP
0xaa06 00           |                   NOP
0xaa07 00           |                   NOP
0xaa08 00           |                   NOP
0xaa09 00           |                   NOP
0xaa0a FF           |                   RST $38
0xaa0b 00           |                   NOP
0xaa0c 00           |                   NOP
0xaa0d 00           |                   NOP
0xaa0e 00           |                   NOP
0xaa0f 00           |                   NOP
0xaa10 00           |                   NOP
0xaa11 00           |                   NOP
0xaa12 00           |                   NOP
0xaa13 00           |                   NOP
0xaa14 00           |                   NOP
0xaa15 00           |                   NOP
0xaa16 00           |                   NOP
0xaa17 00           |                   NOP
0xaa18 00           |                   NOP
0xaa19 00           |                   NOP
0xaa1a 0F           |                   RRCA
0xaa1b 8B           |                   ADC A,E
0xaa1c 6D           |                   LD L,L
0xaa1d CB 4A        |                   BIT 1,D
0xaa1f 50           |                   LD D,B
0xaa20 20 43        |                   JR NZ,$43
0xaa22 43           |                   LD B,E
0xaa23 2C           |                   INC L
0xaa24 4E           |                   LD C,(HL)
0xaa25 4E           |                   LD C,(HL)
0xaa26 00           |                   NOP
0xaa27 FF           |                   RST $38
0xaa28 E9           |                   JP (HL)
0xaa29 00           |                   NOP
0xaa2a 00           |                   NOP
0xaa2b 00           |                   NOP
0xaa2c FF           |                   RST $38
0xaa2d AA           |                   XOR D
0xaa2e CC BB EE     |                   CALL Z,$EEBB
0xaa31 DD           |                   *ILLEGAL*
0xaa32 10 88        |                   DJNZ $88
0xaa34 88           |                   ADC A,B
0xaa35 DD 77 FD     |                   LD (IX+$FD),A
0xaa38 34           |                   INC (HL)
0xaa39 12           |                   LD (DE),A
0xaa3a 00           |                   NOP
0xaa3b C0           |                   RET NZ
0xaa3c 00           |                   NOP
0xaa3d 00           |                   NOP
0xaa3e 00           |                   NOP
0xaa3f 00           |                   NOP
0xaa40 00           |                   NOP
0xaa41 00           |                   NOP
0xaa42 00           |                   NOP
0xaa43 00           |                   NOP
0xaa44 00           |                   NOP
0xaa45 00           |                   NOP
0xaa46 00           |                   NOP
0xaa47 00           |                   NOP
0xaa48 00           |                   NOP
0xaa49 00           |                   NOP
0xaa4a 00           |                   NOP
0xaa4b 00           |                   NOP
0xaa4c 00           |                   NOP
0xaa4d 00           |                   NOP
0xaa4e 00           |                   NOP
0xaa4f 00           |                   NOP
0xaa50 00           |                   NOP
0xaa51 00           |                   NOP
0xaa52 00           |                   NOP
0xaa53 00           |                   NOP
0xaa54 FF           |                   RST $38
0xaa55 00           |                   NOP
0xaa56 00           |                   NOP
0xaa57 00           |                   NOP
0xaa58 00           |                   NOP
0xaa59 00           |                   NOP
0xaa5a 01 00 00     |                   LD BC,$0000
0xaa5d 00           |                   NOP
0xaa5e 00           |                   NOP
0xaa5f 00           |                   NOP
0xaa60 00           |                   NOP
0xaa61 00           |                   NOP
0xaa62 00           |                   NOP
0xaa63 00           |                   NOP
0xaa64 C4 5F 00     |                   CALL NZ,$005F
0xaa67 BE           |                   CP (HL)
0xaa68 4A           |                   LD C,D
0xaa69 50           |                   LD D,B
0xaa6a 20 28        |                   JR NZ,$28
0xaa6c 48           |                   LD C,B
0xaa6d 4C           |                   LD C,H
0xaa6e 29           |                   ADD HL,HL
0xaa6f 00           |                   NOP
0xaa70 FF           |                   RST $38
0xaa71 DD E9        |                   JP (IX)
0xaa73 00           |                   NOP
0xaa74 00           |                   NOP
0xaa75 FF           |                   RST $38
0xaa76 AA           |                   XOR D
0xaa77 CC BB EE     |                   CALL Z,$EEBB
0xaa7a DD           |                   *ILLEGAL*
0xaa7b 11 44 10     |                   LD DE,$1044
0xaa7e 88           |                   ADC A,B
0xaa7f 10 88        |                   DJNZ $88
0xaa81 34           |                   INC (HL)
0xaa82 12           |                   LD (DE),A
0xaa83 00           |                   NOP
0xaa84 C0           |                   RET NZ
0xaa85 20 00        |                   JR NZ,$00
0xaa87 00           |                   NOP
0xaa88 00           |                   NOP
0xaa89 00           |                   NOP
0xaa8a 00           |                   NOP
0xaa8b 00           |                   NOP
0xaa8c 00           |                   NOP
0xaa8d 00           |                   NOP
0xaa8e 00           |                   NOP
0xaa8f 00           |                   NOP
0xaa90 00           |                   NOP
0xaa91 00           |                   NOP
0xaa92 00           |                   NOP
0xaa93 00           |                   NOP
0xaa94 00           |                   NOP
0xaa95 00           |                   NOP
0xaa96 00           |                   NOP
0xaa97 00           |                   NOP
0xaa98 00           |                   NOP
0xaa99 00           |                   NOP
0xaa9a 00           |                   NOP
0xaa9b 00           |                   NOP
0xaa9c 00           |                   NOP
0xaa9d FF           |                   RST $38
0xaa9e 00           |                   NOP
0xaa9f 00           |                   NOP
0xaaa0 00           |                   NOP
0xaaa1 00           |                   NOP
0xaaa2 00           |                   NOP
0xaaa3 00           |                   NOP
0xaaa4 00           |                   NOP
0xaaa5 01 00 01     |                   LD BC,$0100
0xaaa8 00           |                   NOP
0xaaa9 00           |                   NOP
0xaaaa 00           |                   NOP
0xaaab 00           |                   NOP
0xaaac 00           |                   NOP
0xaaad 79           |                   LD A,C
0xaaae 90           |                   SUB A,B
0xaaaf 89           |                   ADC A,C
0xaab0 DF           |                   RST $18
0xaab1 4A           |                   LD C,D
0xaab2 50           |                   LD D,B
0xaab3 20 28        |                   JR NZ,$28
0xaab5 58           |                   LD E,B
0xaab6 59           |                   LD E,C
0xaab7 29           |                   ADD HL,HL
0xaab8 00           |                   NOP
0xaab9 FF           |                   RST $38
0xaaba 18 00        |                   JR $00
0xaabc 03           |                   INC BC
0xaabd 00           |                   NOP
0xaabe FF           |                   RST $38
0xaabf AA           |                   XOR D
0xaac0 CC BB EE     |                   CALL Z,$EEBB
0xaac3 DD           |                   *ILLEGAL*
0xaac4 11 44 88     |                   LD DE,$8844
0xaac7 DD 77 FD     |                   LD (IX+$FD),A
0xaaca 34           |                   INC (HL)
0xaacb 12           |                   LD (DE),A
0xaacc 00           |                   NOP
0xaacd C0           |                   RET NZ
0xaace 00           |                   NOP
0xaacf 01 00 00     |                   LD BC,$0000
0xaad2 00           |                   NOP
0xaad3 00           |                   NOP
0xaad4 00           |                   NOP
0xaad5 00           |                   NOP
0xaad6 00           |                   NOP
0xaad7 00           |                   NOP
0xaad8 00           |                   NOP
0xaad9 00           |                   NOP
0xaada 00           |                   NOP
0xaadb 00           |                   NOP
0xaadc 00           |                   NOP
0xaadd 00           |                   NOP
0xaade 00           |                   NOP
0xaadf 00           |                   NOP
0xaae0 00           |                   NOP
0xaae1 00           |                   NOP
0xaae2 00           |                   NOP
0xaae3 00           |                   NOP
0xaae4 00           |                   NOP
0xaae5 00           |                   NOP
0xaae6 FF           |                   RST $38
0xaae7 00           |                   NOP
0xaae8 00           |                   NOP
0xaae9 00           |                   NOP
0xaaea 00           |                   NOP
0xaaeb 00           |                   NOP
0xaaec 00           |                   NOP
0xaaed 00           |                   NOP
0xaaee 00           |                   NOP
0xaaef 00           |                   NOP
0xaaf0 00           |                   NOP
0xaaf1 00           |                   NOP
0xaaf2 00           |                   NOP
0xaaf3 00           |                   NOP
0xaaf4 00           |                   NOP
0xaaf5 00           |                   NOP
0xaaf6 47           |                   LD B,A
0xaaf7 C8           |                   RET Z
0xaaf8 F3           |                   DI
0xaaf9 63           |                   LD H,E
0xaafa 4A           |                   LD C,D
0xaafb 52           |                   LD D,D
0xaafc 20 4E        |                   JR NZ,$4E
0xaafe 00           |                   NOP
0xaaff FF           |                   RST $38
0xab00 20 00        |                   JR NZ,$00
0xab02 03           |                   INC BC
0xab03 00           |                   NOP
0xab04 FF           |                   RST $38
0xab05 AA           |                   XOR D
0xab06 CC BB EE     |                   CALL Z,$EEBB
0xab09 DD           |                   *ILLEGAL*
0xab0a 11 44 88     |                   LD DE,$8844
0xab0d DD 77 FD     |                   LD (IX+$FD),A
0xab10 34           |                   INC (HL)
0xab11 12           |                   LD (DE),A
0xab12 00           |                   NOP
0xab13 C0           |                   RET NZ
0xab14 18 01        |                   JR $01
0xab16 00           |                   NOP
0xab17 00           |                   NOP
0xab18 00           |                   NOP
0xab19 00           |                   NOP
0xab1a 00           |                   NOP
0xab1b 00           |                   NOP
0xab1c 00           |                   NOP
0xab1d 00           |                   NOP
0xab1e 00           |                   NOP
0xab1f 00           |                   NOP
0xab20 00           |                   NOP
0xab21 00           |                   NOP
0xab22 00           |                   NOP
0xab23 00           |                   NOP
0xab24 00           |                   NOP
0xab25 00           |                   NOP
0xab26 00           |                   NOP
0xab27 00           |                   NOP
0xab28 00           |                   NOP
0xab29 00           |                   NOP
0xab2a 00           |                   NOP
0xab2b 00           |                   NOP
0xab2c FF           |                   RST $38
0xab2d 00           |                   NOP
0xab2e 00           |                   NOP
0xab2f 00           |                   NOP
0xab30 00           |                   NOP
0xab31 00           |                   NOP
0xab32 00           |                   NOP
0xab33 00           |                   NOP
0xab34 00           |                   NOP
0xab35 00           |                   NOP
0xab36 00           |                   NOP
0xab37 00           |                   NOP
0xab38 00           |                   NOP
0xab39 00           |                   NOP
0xab3a 00           |                   NOP
0xab3b 00           |                   NOP
0xab3c C7           |                   RST $00
0xab3d EF           |                   RST $28
0xab3e 0F           |                   RRCA
0xab3f BD           |                   CP L
0xab40 4A           |                   LD C,D
0xab41 52           |                   LD D,D
0xab42 20 43        |                   JR NZ,$43
0xab44 43           |                   LD B,E
0xab45 2C           |                   INC L
0xab46 4E           |                   LD C,(HL)
0xab47 00           |                   NOP
0xab48 FF           |                   RST $38
0xab49 10 00        |                   DJNZ $00
0xab4b 03           |                   INC BC
0xab4c 00           |                   NOP
0xab4d FF           |                   RST $38
0xab4e AA           |                   XOR D
0xab4f CC BB EE     |                   CALL Z,$EEBB
0xab52 DD           |                   *ILLEGAL*
0xab53 11 44 88     |                   LD DE,$8844
0xab56 DD 77 FD     |                   LD (IX+$FD),A
0xab59 34           |                   INC (HL)
0xab5a 12           |                   LD (DE),A
0xab5b 00           |                   NOP
0xab5c C0           |                   RET NZ
0xab5d 00           |                   NOP
0xab5e 01 00 00     |                   LD BC,$0000
0xab61 00           |                   NOP
0xab62 00           |                   NOP
0xab63 00           |                   NOP
0xab64 FF           |                   RST $38
0xab65 00           |                   NOP
0xab66 00           |                   NOP
0xab67 00           |                   NOP
0xab68 00           |                   NOP
0xab69 00           |                   NOP
0xab6a 00           |                   NOP
0xab6b 00           |                   NOP
0xab6c 00           |                   NOP
0xab6d 00           |                   NOP
0xab6e 00           |                   NOP
0xab6f 00           |                   NOP
0xab70 00           |                   NOP
0xab71 00           |                   NOP
0xab72 00           |                   NOP
0xab73 00           |                   NOP
0xab74 00           |                   NOP
0xab75 FF           |                   RST $38
0xab76 00           |                   NOP
0xab77 00           |                   NOP
0xab78 00           |                   NOP
0xab79 00           |                   NOP
0xab7a 00           |                   NOP
0xab7b 00           |                   NOP
0xab7c 00           |                   NOP
0xab7d 00           |                   NOP
0xab7e 00           |                   NOP
0xab7f 00           |                   NOP
0xab80 00           |                   NOP
0xab81 00           |                   NOP
0xab82 00           |                   NOP
0xab83 00           |                   NOP
0xab84 00           |                   NOP
0xab85 6C           |                   LD L,H
0xab86 92           |                   SUB A,D
0xab87 B0           |                   OR B
0xab88 B3           |                   OR E
0xab89 44           |                   LD B,H
0xab8a 4A           |                   LD C,D
0xab8b 4E           |                   LD C,(HL)
0xab8c 5A           |                   LD E,D
0xab8d 20 4E        |                   JR NZ,$4E
0xab8f 00           |                   NOP
0xab90 FF           |                   RST $38
0xab91 CD 10 88     |                   CALL $8810
0xab94 00           |                   NOP
0xab95 FF           |                   RST $38
0xab96 AA           |                   XOR D
0xab97 CC BB EE     |                   CALL Z,$EEBB
0xab9a DD           |                   *ILLEGAL*
0xab9b 11 44 88     |                   LD DE,$8844
0xab9e DD 77 FD     |                   LD (IX+$FD),A
0xaba1 34           |                   INC (HL)
0xaba2 12           |                   LD (DE),A
0xaba3 0C           |                   INC C
0xaba4 88           |                   ADC A,B
0xaba5 00           |                   NOP
0xaba6 00           |                   NOP
0xaba7 00           |                   NOP
0xaba8 00           |                   NOP
0xaba9 00           |                   NOP
0xabaa 00           |                   NOP
0xabab 00           |                   NOP
0xabac 00           |                   NOP
0xabad 00           |                   NOP
0xabae 00           |                   NOP
0xabaf 00           |                   NOP
0xabb0 00           |                   NOP
0xabb1 00           |                   NOP
0xabb2 00           |                   NOP
0xabb3 00           |                   NOP
0xabb4 00           |                   NOP
0xabb5 00           |                   NOP
0xabb6 00           |                   NOP
0xabb7 00           |                   NOP
0xabb8 00           |                   NOP
0xabb9 00           |                   NOP
0xabba 00           |                   NOP
0xabbb 00           |                   NOP
0xabbc 00           |                   NOP
0xabbd FF           |                   RST $38
0xabbe 00           |                   NOP
0xabbf 00           |                   NOP
0xabc0 00           |                   NOP
0xabc1 00           |                   NOP
0xabc2 00           |                   NOP
0xabc3 00           |                   NOP
0xabc4 00           |                   NOP
0xabc5 00           |                   NOP
0xabc6 00           |                   NOP
0xabc7 00           |                   NOP
0xabc8 00           |                   NOP
0xabc9 00           |                   NOP
0xabca 00           |                   NOP
0xabcb 00           |                   NOP
0xabcc 00           |                   NOP
0xabcd 95           |                   SUB A,L
0xabce EB           |                   EX DE,HL
0xabcf 15           |                   DEC D
0xabd0 99           |                   SBC A,C
0xabd1 43           |                   LD B,E
0xabd2 41           |                   LD B,C
0xabd3 4C           |                   LD C,H
0xabd4 4C           |                   LD C,H
0xabd5 20 4E        |                   JR NZ,$4E
0xabd7 4E           |                   LD C,(HL)
0xabd8 00           |                   NOP
0xabd9 FF           |                   RST $38
0xabda C4 10 88     |                   CALL NZ,$8810
0xabdd 00           |                   NOP
0xabde FF           |                   RST $38
0xabdf AA           |                   XOR D
0xabe0 CC BB EE     |                   CALL Z,$EEBB
0xabe3 DD           |                   *ILLEGAL*
0xabe4 11 44 88     |                   LD DE,$8844
0xabe7 DD 77 FD     |                   LD (IX+$FD),A
0xabea 34           |                   INC (HL)
0xabeb 12           |                   LD (DE),A
0xabec 0C           |                   INC C
0xabed 88           |                   ADC A,B
0xabee 38 00        |                   JR C,$00
0xabf0 00           |                   NOP
0xabf1 00           |                   NOP
0xabf2 00           |                   NOP
0xabf3 00           |                   NOP
0xabf4 00           |                   NOP
0xabf5 00           |                   NOP
0xabf6 00           |                   NOP
0xabf7 00           |                   NOP
0xabf8 00           |                   NOP
0xabf9 00           |                   NOP
0xabfa 00           |                   NOP
0xabfb 00           |                   NOP
0xabfc 00           |                   NOP
0xabfd 00           |                   NOP
0xabfe 00           |                   NOP
0xabff 00           |                   NOP
0xac00 00           |                   NOP
0xac01 00           |                   NOP
0xac02 00           |                   NOP
0xac03 00           |                   NOP
0xac04 00           |                   NOP
0xac05 00           |                   NOP
0xac06 FF           |                   RST $38
0xac07 00           |                   NOP
0xac08 00           |                   NOP
0xac09 00           |                   NOP
0xac0a 00           |                   NOP
0xac0b 00           |                   NOP
0xac0c 00           |                   NOP
0xac0d 00           |                   NOP
0xac0e 00           |                   NOP
0xac0f 00           |                   NOP
0xac10 00           |                   NOP
0xac11 00           |                   NOP
0xac12 00           |                   NOP
0xac13 00           |                   NOP
0xac14 00           |                   NOP
0xac15 00           |                   NOP
0xac16 87           |                   AA,A
0xac17 B3           |                   OR E
0xac18 2D           |                   DEC L
0xac19 29           |                   ADD HL,HL
0xac1a 43           |                   LD B,E
0xac1b 41           |                   LD B,C
0xac1c 4C           |                   LD C,H
0xac1d 4C           |                   LD C,H
0xac1e 20 43        |                   JR NZ,$43
0xac20 43           |                   LD B,E
0xac21 2C           |                   INC L
0xac22 4E           |                   LD C,(HL)
0xac23 4E           |                   LD C,(HL)
0xac24 00           |                   NOP
0xac25 FF           |                   RST $38
0xac26 C9           |                   RET
0xac27 00           |                   NOP
0xac28 00           |                   NOP
0xac29 00           |                   NOP
0xac2a FF           |                   RST $38
0xac2b AA           |                   XOR D
0xac2c CC BB EE     |                   CALL Z,$EEBB
0xac2f DD           |                   *ILLEGAL*
0xac30 11 44 88     |                   LD DE,$8844
0xac33 DD 77 FD     |                   LD (IX+$FD),A
0xac36 10 88        |                   DJNZ $88
0xac38 0C           |                   INC C
0xac39 88           |                   ADC A,B
0xac3a 00           |                   NOP
0xac3b 00           |                   NOP
0xac3c 00           |                   NOP
0xac3d 00           |                   NOP
0xac3e 00           |                   NOP
0xac3f 00           |                   NOP
0xac40 00           |                   NOP
0xac41 00           |                   NOP
0xac42 00           |                   NOP
0xac43 00           |                   NOP
0xac44 00           |                   NOP
0xac45 00           |                   NOP
0xac46 00           |                   NOP
0xac47 00           |                   NOP
0xac48 00           |                   NOP
0xac49 00           |                   NOP
0xac4a 00           |                   NOP
0xac4b 00           |                   NOP
0xac4c 00           |                   NOP
0xac4d 00           |                   NOP
0xac4e 00           |                   NOP
0xac4f 00           |                   NOP
0xac50 00           |                   NOP
0xac51 00           |                   NOP
0xac52 FF           |                   RST $38
0xac53 00           |                   NOP
0xac54 00           |                   NOP
0xac55 00           |                   NOP
0xac56 00           |                   NOP
0xac57 00           |                   NOP
0xac58 00           |                   NOP
0xac59 00           |                   NOP
0xac5a 00           |                   NOP
0xac5b 00           |                   NOP
0xac5c 00           |                   NOP
0xac5d 00           |                   NOP
0xac5e 00           |                   NOP
0xac5f 00           |                   NOP
0xac60 00           |                   NOP
0xac61 00           |                   NOP
0xac62 B2           |                   OR D
0xac63 4F           |                   LD C,A
0xac64 5C           |                   LD E,H
0xac65 05           |                   DEC B
0xac66 52           |                   LD D,D
0xac67 45           |                   LD B,L
0xac68 54           |                   LD D,H
0xac69 00           |                   NOP
0xac6a FF           |                   RST $38
0xac6b C0           |                   RET NZ
0xac6c 00           |                   NOP
0xac6d 00           |                   NOP
0xac6e 00           |                   NOP
0xac6f FF           |                   RST $38
0xac70 AA           |                   XOR D
0xac71 CC BB EE     |                   CALL Z,$EEBB
0xac74 DD           |                   *ILLEGAL*
0xac75 11 44 88     |                   LD DE,$8844
0xac78 DD 77 FD     |                   LD (IX+$FD),A
0xac7b 10 88        |                   DJNZ $88
0xac7d 0C           |                   INC C
0xac7e 88           |                   ADC A,B
0xac7f 38 00        |                   JR C,$00
0xac81 00           |                   NOP
0xac82 00           |                   NOP
0xac83 00           |                   NOP
0xac84 00           |                   NOP
0xac85 00           |                   NOP
0xac86 00           |                   NOP
0xac87 00           |                   NOP
0xac88 00           |                   NOP
0xac89 00           |                   NOP
0xac8a 00           |                   NOP
0xac8b 00           |                   NOP
0xac8c 00           |                   NOP
0xac8d 00           |                   NOP
0xac8e 00           |                   NOP
0xac8f 00           |                   NOP
0xac90 00           |                   NOP
0xac91 00           |                   NOP
0xac92 00           |                   NOP
0xac93 00           |                   NOP
0xac94 00           |                   NOP
0xac95 00           |                   NOP
0xac96 00           |                   NOP
0xac97 FF           |                   RST $38
0xac98 00           |                   NOP
0xac99 00           |                   NOP
0xac9a 00           |                   NOP
0xac9b 00           |                   NOP
0xac9c 00           |                   NOP
0xac9d 00           |                   NOP
0xac9e 00           |                   NOP
0xac9f 00           |                   NOP
0xaca0 00           |                   NOP
0xaca1 00           |                   NOP
0xaca2 00           |                   NOP
0xaca3 00           |                   NOP
0xaca4 00           |                   NOP
0xaca5 00           |                   NOP
0xaca6 00           |                   NOP
0xaca7 2B           |                   DEC HL
0xaca8 7F           |                   LD A,A
0xaca9 37           |                   SCF
0xacaa EC 52 45     |                   CALL P,$4552
0xacad 54           |                   LD D,H
0xacae 20 43        |                   JR NZ,$43
0xacb0 43           |                   LD B,E
0xacb1 00           |                   NOP
0xacb2 FF           |                   RST $38
0xacb3 ED 45        |                   RETN
0xacb5 00           |                   NOP
0xacb6 00           |                   NOP
0xacb7 FF           |                   RST $38
0xacb8 AA           |                   XOR D
0xacb9 CC BB EE     |                   CALL Z,$EEBB
0xacbc DD           |                   *ILLEGAL*
0xacbd 11 44 88     |                   LD DE,$8844
0xacc0 DD 77 FD     |                   LD (IX+$FD),A
0xacc3 10 88        |                   DJNZ $88
0xacc5 0C           |                   INC C
0xacc6 88           |                   ADC A,B
0xacc7 00           |                   NOP
0xacc8 00           |                   NOP
0xacc9 00           |                   NOP
0xacca 00           |                   NOP
0xaccb 00           |                   NOP
0xaccc 00           |                   NOP
0xaccd 00           |                   NOP
0xacce 00           |                   NOP
0xaccf 00           |                   NOP
0xacd0 00           |                   NOP
0xacd1 00           |                   NOP
0xacd2 00           |                   NOP
0xacd3 00           |                   NOP
0xacd4 00           |                   NOP
0xacd5 00           |                   NOP
0xacd6 00           |                   NOP
0xacd7 00           |                   NOP
0xacd8 00           |                   NOP
0xacd9 00           |                   NOP
0xacda 00           |                   NOP
0xacdb 00           |                   NOP
0xacdc 00           |                   NOP
0xacdd 00           |                   NOP
0xacde 00           |                   NOP
0xacdf FF           |                   RST $38
0xace0 00           |                   NOP
0xace1 00           |                   NOP
0xace2 00           |                   NOP
0xace3 00           |                   NOP
0xace4 00           |                   NOP
0xace5 00           |                   NOP
0xace6 00           |                   NOP
0xace7 00           |                   NOP
0xace8 00           |                   NOP
0xace9 00           |                   NOP
0xacea 00           |                   NOP
0xaceb 00           |                   NOP
0xacec 00           |                   NOP
0xaced 00           |                   NOP
0xacee 00           |                   NOP
0xacef B2           |                   OR D
0xacf0 4F           |                   LD C,A
0xacf1 5C           |                   LD E,H
0xacf2 05           |                   DEC B
0xacf3 52           |                   LD D,D
0xacf4 45           |                   LD B,L
0xacf5 54           |                   LD D,H
0xacf6 4E           |                   LD C,(HL)
0xacf7 00           |                   NOP
0xacf8 FF           |                   RST $38
0xacf9 ED 4D        |                   RETI
0xacfb 00           |                   NOP
0xacfc 00           |                   NOP
0xacfd FF           |                   RST $38
0xacfe AA           |                   XOR D
0xacff CC BB EE     |                   CALL Z,$EEBB
0xad02 DD           |                   *ILLEGAL*
0xad03 11 44 88     |                   LD DE,$8844
0xad06 DD 77 FD     |                   LD (IX+$FD),A
0xad09 10 88        |                   DJNZ $88
0xad0b 0C           |                   INC C
0xad0c 88           |                   ADC A,B
0xad0d 00           |                   NOP
0xad0e 00           |                   NOP
0xad0f 00           |                   NOP
0xad10 00           |                   NOP
0xad11 00           |                   NOP
0xad12 00           |                   NOP
0xad13 00           |                   NOP
0xad14 00           |                   NOP
0xad15 00           |                   NOP
0xad16 00           |                   NOP
0xad17 00           |                   NOP
0xad18 00           |                   NOP
0xad19 00           |                   NOP
0xad1a 00           |                   NOP
0xad1b 00           |                   NOP
0xad1c 00           |                   NOP
0xad1d 00           |                   NOP
0xad1e 00           |                   NOP
0xad1f 00           |                   NOP
0xad20 00           |                   NOP
0xad21 00           |                   NOP
0xad22 00           |                   NOP
0xad23 00           |                   NOP
0xad24 00           |                   NOP
0xad25 FF           |                   RST $38
0xad26 00           |                   NOP
0xad27 00           |                   NOP
0xad28 00           |                   NOP
0xad29 00           |                   NOP
0xad2a 00           |                   NOP
0xad2b 00           |                   NOP
0xad2c 00           |                   NOP
0xad2d 00           |                   NOP
0xad2e 00           |                   NOP
0xad2f 00           |                   NOP
0xad30 00           |                   NOP
0xad31 00           |                   NOP
0xad32 00           |                   NOP
0xad33 00           |                   NOP
0xad34 00           |                   NOP
0xad35 B2           |                   OR D
0xad36 4F           |                   LD C,A
0xad37 5C           |                   LD E,H
0xad38 05           |                   DEC B
0xad39 52           |                   LD D,D
0xad3a 45           |                   LD B,L
0xad3b 54           |                   LD D,H
0xad3c 49           |                   LD C,C
0xad3d 00           |                   NOP
0xad3e FF           |                   RST $38
0xad3f ED 45        |                   RETN
0xad41 00           |                   NOP
0xad42 00           |                   NOP
0xad43 FF           |                   RST $38
0xad44 AA           |                   XOR D
0xad45 CC BB EE     |                   CALL Z,$EEBB
0xad48 DD           |                   *ILLEGAL*
0xad49 11 44 88     |                   LD DE,$8844
0xad4c DD 77 FD     |                   LD (IX+$FD),A
0xad4f 10 88        |                   DJNZ $88
0xad51 0C           |                   INC C
0xad52 88           |                   ADC A,B
0xad53 00           |                   NOP
0xad54 38 00        |                   JR C,$00
0xad56 00           |                   NOP
0xad57 00           |                   NOP
0xad58 00           |                   NOP
0xad59 00           |                   NOP
0xad5a 00           |                   NOP
0xad5b 00           |                   NOP
0xad5c 00           |                   NOP
0xad5d 00           |                   NOP
0xad5e 00           |                   NOP
0xad5f 00           |                   NOP
0xad60 00           |                   NOP
0xad61 00           |                   NOP
0xad62 00           |                   NOP
0xad63 00           |                   NOP
0xad64 00           |                   NOP
0xad65 00           |                   NOP
0xad66 00           |                   NOP
0xad67 00           |                   NOP
0xad68 00           |                   NOP
0xad69 00           |                   NOP
0xad6a 00           |                   NOP
0xad6b FF           |                   RST $38
0xad6c 00           |                   NOP
0xad6d 00           |                   NOP
0xad6e 00           |                   NOP
0xad6f 00           |                   NOP
0xad70 00           |                   NOP
0xad71 00           |                   NOP
0xad72 00           |                   NOP
0xad73 00           |                   NOP
0xad74 00           |                   NOP
0xad75 00           |                   NOP
0xad76 00           |                   NOP
0xad77 00           |                   NOP
0xad78 00           |                   NOP
0xad79 00           |                   NOP
0xad7a 00           |                   NOP
0xad7b 1A           |                   LD A,(DE)
0xad7c FC 36 B0     |                   CALL M,$B036
0xad7f 52           |                   LD D,D
0xad80 45           |                   LD B,L
0xad81 54           |                   LD D,H
0xad82 49           |                   LD C,C
0xad83 2F           |                   CPL
0xad84 52           |                   LD D,D
0xad85 45           |                   LD B,L
0xad86 54           |                   LD D,H
0xad87 4E           |                   LD C,(HL)
0xad88 00           |                   NOP
0xad89 FF           |                   RST $38
0xad8a C5           |                   PUSH BC
0xad8b C1           |                   POP BC
0xad8c 00           |                   NOP
0xad8d 00           |                   NOP
0xad8e FF           |                   RST $38
0xad8f AA           |                   XOR D
0xad90 CC BB EE     |                   CALL Z,$EEBB
0xad93 DD           |                   *ILLEGAL*
0xad94 11 44 88     |                   LD DE,$8844
0xad97 DD 77 FD     |                   LD (IX+$FD),A
0xad9a 34           |                   INC (HL)
0xad9b 12           |                   LD (DE),A
0xad9c 0E 88        |                   LD C,$88
0xad9e 30 30        |                   JR NC,$30
0xada0 00           |                   NOP
0xada1 00           |                   NOP
0xada2 00           |                   NOP
0xada3 00           |                   NOP
0xada4 00           |                   NOP
0xada5 00           |                   NOP
0xada6 00           |                   NOP
0xada7 00           |                   NOP
0xada8 00           |                   NOP
0xada9 00           |                   NOP
0xadaa 00           |                   NOP
0xadab 00           |                   NOP
0xadac 00           |                   NOP
0xadad 00           |                   NOP
0xadae 00           |                   NOP
0xadaf 00           |                   NOP
0xadb0 00           |                   NOP
0xadb1 00           |                   NOP
0xadb2 00           |                   NOP
0xadb3 00           |                   NOP
0xadb4 00           |                   NOP
0xadb5 00           |                   NOP
0xadb6 FF           |                   RST $38
0xadb7 80           |                   AA,B
0xadb8 01 80 01     |                   LD BC,$0180
0xadbb 80           |                   AA,B
0xadbc 01 80 00     |                   LD BC,$0080
0xadbf 00           |                   NOP
0xadc0 00           |                   NOP
0xadc1 00           |                   NOP
0xadc2 00           |                   NOP
0xadc3 00           |                   NOP
0xadc4 00           |                   NOP
0xadc5 00           |                   NOP
0xadc6 24           |                   INC H
0xadc7 9C           |                   SBC A,H
0xadc8 42           |                   LD B,D
0xadc9 E7           |                   RST $20
0xadca 50           |                   LD D,B
0xadcb 55           |                   LD D,L
0xadcc 53           |                   LD D,E
0xadcd 48           |                   LD C,B
0xadce 2B           |                   DEC HL
0xadcf 50           |                   LD D,B
0xadd0 4F           |                   LD C,A
0xadd1 50           |                   LD D,B
0xadd2 20 52        |                   JR NZ,$52
0xadd4 52           |                   LD D,D
0xadd5 00           |                   NOP
0xadd6 FF           |                   RST $38
0xadd7 F1           |                   POP AF
0xadd8 F5           |                   PUSH AF
0xadd9 00           |                   NOP
0xadda 00           |                   NOP
0xaddb FF           |                   RST $38
0xaddc AA           |                   XOR D
0xaddd CC BB EE     |                   CALL Z,$EEBB
0xade0 DD           |                   *ILLEGAL*
0xade1 11 44 88     |                   LD DE,$8844
0xade4 DD 77 FD     |                   LD (IX+$FD),A
0xade7 00           |                   NOP
0xade8 00           |                   NOP
0xade9 0C           |                   INC C
0xadea 88           |                   ADC A,B
0xadeb 00           |                   NOP
0xadec 00           |                   NOP
0xaded 00           |                   NOP
0xadee 00           |                   NOP
0xadef 00           |                   NOP
0xadf0 00           |                   NOP
0xadf1 00           |                   NOP
0xadf2 00           |                   NOP
0xadf3 00           |                   NOP
0xadf4 00           |                   NOP
0xadf5 00           |                   NOP
0xadf6 00           |                   NOP
0xadf7 00           |                   NOP
0xadf8 00           |                   NOP
0xadf9 00           |                   NOP
0xadfa 00           |                   NOP
0xadfb FF           |                   RST $38
0xadfc 00           |                   NOP
0xadfd 00           |                   NOP
0xadfe 00           |                   NOP
0xadff 00           |                   NOP
0xae00 00           |                   NOP
0xae01 00           |                   NOP
0xae02 00           |                   NOP
0xae03 00           |                   NOP
0xae04 00           |                   NOP
0xae05 00           |                   NOP
0xae06 00           |                   NOP
0xae07 00           |                   NOP
0xae08 00           |                   NOP
0xae09 00           |                   NOP
0xae0a 00           |                   NOP
0xae0b 00           |                   NOP
0xae0c 00           |                   NOP
0xae0d 00           |                   NOP
0xae0e 00           |                   NOP
0xae0f 00           |                   NOP
0xae10 81           |                   AA,C
0xae11 00           |                   NOP
0xae12 00           |                   NOP
0xae13 0D           |                   DEC C
0xae14 EA C4 69     |                   JP PE,$69C4
0xae17 50           |                   LD D,B
0xae18 4F           |                   LD C,A
0xae19 50           |                   LD D,B
0xae1a 2B           |                   DEC HL
0xae1b 50           |                   LD D,B
0xae1c 55           |                   LD D,L
0xae1d 53           |                   LD D,E
0xae1e 48           |                   LD C,B
0xae1f 20 41        |                   JR NZ,$41
0xae21 46           |                   LD B,(HL)
0xae22 00           |                   NOP
0xae23 FF           |                   RST $38
0xae24 DD E5        |                   PUSH IX
0xae26 DD E1        |                   POP IX
0xae28 FF           |                   RST $38
0xae29 AA           |                   XOR D
0xae2a CC BB EE     |                   CALL Z,$EEBB
0xae2d DD           |                   *ILLEGAL*
0xae2e 11 44 88     |                   LD DE,$8844
0xae31 DD 77 FD     |                   LD (IX+$FD),A
0xae34 34           |                   INC (HL)
0xae35 12           |                   LD (DE),A
0xae36 0E 88        |                   LD C,$88
0xae38 20 00        |                   JR NZ,$00
0xae3a 20 00        |                   JR NZ,$00
0xae3c 00           |                   NOP
0xae3d 00           |                   NOP
0xae3e 00           |                   NOP
0xae3f 00           |                   NOP
0xae40 00           |                   NOP
0xae41 00           |                   NOP
0xae42 00           |                   NOP
0xae43 00           |                   NOP
0xae44 00           |                   NOP
0xae45 00           |                   NOP
0xae46 00           |                   NOP
0xae47 00           |                   NOP
0xae48 00           |                   NOP
0xae49 00           |                   NOP
0xae4a 00           |                   NOP
0xae4b 00           |                   NOP
0xae4c 00           |                   NOP
0xae4d 00           |                   NOP
0xae4e 00           |                   NOP
0xae4f 00           |                   NOP
0xae50 FF           |                   RST $38
0xae51 00           |                   NOP
0xae52 00           |                   NOP
0xae53 00           |                   NOP
0xae54 00           |                   NOP
0xae55 00           |                   NOP
0xae56 00           |                   NOP
0xae57 00           |                   NOP
0xae58 01 80 01     |                   LD BC,$0180
0xae5b 80           |                   AA,B
0xae5c 00           |                   NOP
0xae5d 00           |                   NOP
0xae5e 00           |                   NOP
0xae5f 00           |                   NOP
0xae60 68           |                   LD L,B
0xae61 43           |                   LD B,E
0xae62 6A           |                   LD L,D
0xae63 76           |                   HALT
0xae64 50           |                   LD D,B
0xae65 55           |                   LD D,L
0xae66 53           |                   LD D,E
0xae67 48           |                   LD C,B
0xae68 2B           |                   DEC HL
0xae69 50           |                   LD D,B
0xae6a 4F           |                   LD C,A
0xae6b 50           |                   LD D,B
0xae6c 20 58        |                   JR NZ,$58
0xae6e 59           |                   LD E,C
0xae6f 00           |                   NOP
0xae70 FF           |                   RST $38
0xae71 EB           |                   EX DE,HL
0xae72 00           |                   NOP
0xae73 00           |                   NOP
0xae74 00           |                   NOP
0xae75 FF           |                   RST $38
0xae76 AA           |                   XOR D
0xae77 CC BB EE     |                   CALL Z,$EEBB
0xae7a DD           |                   *ILLEGAL*
0xae7b 11 44 88     |                   LD DE,$8844
0xae7e DD 77 FD     |                   LD (IX+$FD),A
0xae81 34           |                   INC (HL)
0xae82 12           |                   LD (DE),A
0xae83 00           |                   NOP
0xae84 C0           |                   RET NZ
0xae85 00           |                   NOP
0xae86 00           |                   NOP
0xae87 00           |                   NOP
0xae88 00           |                   NOP
0xae89 00           |                   NOP
0xae8a 00           |                   NOP
0xae8b 00           |                   NOP
0xae8c 00           |                   NOP
0xae8d 00           |                   NOP
0xae8e 00           |                   NOP
0xae8f 00           |                   NOP
0xae90 00           |                   NOP
0xae91 00           |                   NOP
0xae92 00           |                   NOP
0xae93 00           |                   NOP
0xae94 00           |                   NOP
0xae95 00           |                   NOP
0xae96 00           |                   NOP
0xae97 00           |                   NOP
0xae98 00           |                   NOP
0xae99 00           |                   NOP
0xae9a 00           |                   NOP
0xae9b 00           |                   NOP
0xae9c 00           |                   NOP
0xae9d FF           |                   RST $38
0xae9e 00           |                   NOP
0xae9f 00           |                   NOP
0xaea0 00           |                   NOP
0xaea1 01 80 01     |                   LD BC,$0180
0xaea4 80           |                   AA,B
0xaea5 00           |                   NOP
0xaea6 00           |                   NOP
0xaea7 00           |                   NOP
0xaea8 00           |                   NOP
0xaea9 00           |                   NOP
0xaeaa 00           |                   NOP
0xaeab 00           |                   NOP
0xaeac 00           |                   NOP
0xaead 21 21 55     |                   LD HL,$5521
0xaeb0 FF           |                   RST $38
0xaeb1 45           |                   LD B,L
0xaeb2 58           |                   LD E,B
0xaeb3 20 44        |                   JR NZ,$44
0xaeb5 45           |                   LD B,L
0xaeb6 2C           |                   INC L
0xaeb7 48           |                   LD C,B
0xaeb8 4C           |                   LD C,H
0xaeb9 00           |                   NOP
0xaeba FF           |                   RST $38
0xaebb 08           |                   EX AF,AF'
0xaebc F1           |                   POP AF
0xaebd C5           |                   PUSH BC
0xaebe 08           |                   EX AF,AF'
0xaebf FF           |                   RST $38
0xaec0 AA           |                   XOR D
0xaec1 CC BB EE     |                   CALL Z,$EEBB
0xaec4 DD           |                   *ILLEGAL*
0xaec5 11 44 88     |                   LD DE,$8844
0xaec8 DD 77 FD     |                   LD (IX+$FD),A
0xaecb 34           |                   INC (HL)
0xaecc 12           |                   LD (DE),A
0xaecd 0C           |                   INC C
0xaece 88           |                   ADC A,B
0xaecf 00           |                   NOP
0xaed0 00           |                   NOP
0xaed1 30 00        |                   JR NC,$00
0xaed3 00           |                   NOP
0xaed4 00           |                   NOP
0xaed5 00           |                   NOP
0xaed6 00           |                   NOP
0xaed7 00           |                   NOP
0xaed8 00           |                   NOP
0xaed9 00           |                   NOP
0xaeda 00           |                   NOP
0xaedb 00           |                   NOP
0xaedc 00           |                   NOP
0xaedd 00           |                   NOP
0xaede 00           |                   NOP
0xaedf 00           |                   NOP
0xaee0 00           |                   NOP
0xaee1 00           |                   NOP
0xaee2 00           |                   NOP
0xaee3 00           |                   NOP
0xaee4 00           |                   NOP
0xaee5 00           |                   NOP
0xaee6 00           |                   NOP
0xaee7 FF           |                   RST $38
0xaee8 81           |                   AA,C
0xaee9 01 80 01     |                   LD BC,$0180
0xaeec 80           |                   AA,B
0xaeed 01 80 00     |                   LD BC,$0080
0xaef0 00           |                   NOP
0xaef1 00           |                   NOP
0xaef2 00           |                   NOP
0xaef3 FF           |                   RST $38
0xaef4 81           |                   AA,C
0xaef5 00           |                   NOP
0xaef6 00           |                   NOP
0xaef7 7F           |                   LD A,A
0xaef8 6C           |                   LD L,H
0xaef9 68           |                   LD L,B
0xaefa DB 45        |                   IN A,($45)
0xaefc 58           |                   LD E,B
0xaefd 20 41        |                   JR NZ,$41
0xaeff 46           |                   LD B,(HL)
0xaf00 2C           |                   INC L
0xaf01 41           |                   LD B,C
0xaf02 46           |                   LD B,(HL)
0xaf03 27           |                   DAA
0xaf04 00           |                   NOP
0xaf05 FF           |                   RST $38
0xaf06 D9           |                   EXX
0xaf07 E1           |                   POP HL
0xaf08 C5           |                   PUSH BC
0xaf09 D9           |                   EXX
0xaf0a FF           |                   RST $38
0xaf0b AA           |                   XOR D
0xaf0c CC BB EE     |                   CALL Z,$EEBB
0xaf0f DD           |                   *ILLEGAL*
0xaf10 11 44 88     |                   LD DE,$8844
0xaf13 DD 77 FD     |                   LD (IX+$FD),A
0xaf16 34           |                   INC (HL)
0xaf17 12           |                   LD (DE),A
0xaf18 0C           |                   INC C
0xaf19 88           |                   ADC A,B
0xaf1a 00           |                   NOP
0xaf1b 00           |                   NOP
0xaf1c 30 00        |                   JR NC,$00
0xaf1e 00           |                   NOP
0xaf1f 00           |                   NOP
0xaf20 00           |                   NOP
0xaf21 00           |                   NOP
0xaf22 00           |                   NOP
0xaf23 00           |                   NOP
0xaf24 00           |                   NOP
0xaf25 00           |                   NOP
0xaf26 00           |                   NOP
0xaf27 00           |                   NOP
0xaf28 00           |                   NOP
0xaf29 00           |                   NOP
0xaf2a 00           |                   NOP
0xaf2b 00           |                   NOP
0xaf2c 00           |                   NOP
0xaf2d 00           |                   NOP
0xaf2e 00           |                   NOP
0xaf2f 00           |                   NOP
0xaf30 00           |                   NOP
0xaf31 00           |                   NOP
0xaf32 FF           |                   RST $38
0xaf33 81           |                   AA,C
0xaf34 01 80 01     |                   LD BC,$0180
0xaf37 80           |                   AA,B
0xaf38 01 80 00     |                   LD BC,$0080
0xaf3b 00           |                   NOP
0xaf3c 00           |                   NOP
0xaf3d 00           |                   NOP
0xaf3e 01 80 00     |                   LD BC,$0080
0xaf41 00           |                   NOP
0xaf42 CF           |                   RST $08
0xaf43 11 CE 0B     |                   LD DE,$0BCE
0xaf46 45           |                   LD B,L
0xaf47 58           |                   LD E,B
0xaf48 58           |                   LD E,B
0xaf49 00           |                   NOP
0xaf4a FF           |                   RST $38
0xaf4b E3           |                   EX (SP),HL
0xaf4c 00           |                   NOP
0xaf4d 00           |                   NOP
0xaf4e 00           |                   NOP
0xaf4f FF           |                   RST $38
0xaf50 AA           |                   XOR D
0xaf51 CC BB EE     |                   CALL Z,$EEBB
0xaf54 DD           |                   *ILLEGAL*
0xaf55 11 44 88     |                   LD DE,$8844
0xaf58 DD 77 FD     |                   LD (IX+$FD),A
0xaf5b 34           |                   INC (HL)
0xaf5c 12           |                   LD (DE),A
0xaf5d 0C           |                   INC C
0xaf5e 88           |                   ADC A,B
0xaf5f 00           |                   NOP
0xaf60 00           |                   NOP
0xaf61 00           |                   NOP
0xaf62 00           |                   NOP
0xaf63 00           |                   NOP
0xaf64 00           |                   NOP
0xaf65 00           |                   NOP
0xaf66 00           |                   NOP
0xaf67 00           |                   NOP
0xaf68 00           |                   NOP
0xaf69 00           |                   NOP
0xaf6a 00           |                   NOP
0xaf6b 00           |                   NOP
0xaf6c 00           |                   NOP
0xaf6d 00           |                   NOP
0xaf6e 00           |                   NOP
0xaf6f 00           |                   NOP
0xaf70 00           |                   NOP
0xaf71 00           |                   NOP
0xaf72 00           |                   NOP
0xaf73 00           |                   NOP
0xaf74 00           |                   NOP
0xaf75 00           |                   NOP
0xaf76 00           |                   NOP
0xaf77 FF           |                   RST $38
0xaf78 00           |                   NOP
0xaf79 00           |                   NOP
0xaf7a 00           |                   NOP
0xaf7b 00           |                   NOP
0xaf7c 00           |                   NOP
0xaf7d 01 80 00     |                   LD BC,$0080
0xaf80 00           |                   NOP
0xaf81 00           |                   NOP
0xaf82 00           |                   NOP
0xaf83 01 80 00     |                   LD BC,$0080
0xaf86 00           |                   NOP
0xaf87 42           |                   LD B,D
0xaf88 4B           |                   LD C,E
0xaf89 55           |                   LD D,L
0xaf8a 72           |                   LD (HL),D
0xaf8b 45           |                   LD B,L
0xaf8c 58           |                   LD E,B
0xaf8d 20 28        |                   JR NZ,$28
0xaf8f 53           |                   LD D,E
0xaf90 50           |                   LD D,B
0xaf91 29           |                   ADD HL,HL
0xaf92 2C           |                   INC L
0xaf93 48           |                   LD C,B
0xaf94 4C           |                   LD C,H
0xaf95 00           |                   NOP
0xaf96 FF           |                   RST $38
0xaf97 DD E3        |                   EX (SP),IX
0xaf99 00           |                   NOP
0xaf9a 00           |                   NOP
0xaf9b FF           |                   RST $38
0xaf9c AA           |                   XOR D
0xaf9d CC BB EE     |                   CALL Z,$EEBB
0xafa0 DD           |                   *ILLEGAL*
0xafa1 11 44 88     |                   LD DE,$8844
0xafa4 DD 77 FD     |                   LD (IX+$FD),A
0xafa7 34           |                   INC (HL)
0xafa8 12           |                   LD (DE),A
0xafa9 0C           |                   INC C
0xafaa 88           |                   ADC A,B
0xafab 20 00        |                   JR NZ,$00
0xafad 00           |                   NOP
0xafae 00           |                   NOP
0xafaf 00           |                   NOP
0xafb0 00           |                   NOP
0xafb1 00           |                   NOP
0xafb2 00           |                   NOP
0xafb3 00           |                   NOP
0xafb4 00           |                   NOP
0xafb5 00           |                   NOP
0xafb6 00           |                   NOP
0xafb7 00           |                   NOP
0xafb8 00           |                   NOP
0xafb9 00           |                   NOP
0xafba 00           |                   NOP
0xafbb 00           |                   NOP
0xafbc 00           |                   NOP
0xafbd 00           |                   NOP
0xafbe 00           |                   NOP
0xafbf 00           |                   NOP
0xafc0 00           |                   NOP
0xafc1 00           |                   NOP
0xafc2 00           |                   NOP
0xafc3 FF           |                   RST $38
0xafc4 00           |                   NOP
0xafc5 00           |                   NOP
0xafc6 00           |                   NOP
0xafc7 00           |                   NOP
0xafc8 00           |                   NOP
0xafc9 00           |                   NOP
0xafca 00           |                   NOP
0xafcb 01 80 01     |                   LD BC,$0180
0xafce 80           |                   AA,B
0xafcf 01 80 00     |                   LD BC,$0080
0xafd2 00           |                   NOP
0xafd3 4F           |                   LD C,A
0xafd4 61           |                   LD H,C
0xafd5 23           |                   INC HL
0xafd6 B9           |                   CP C
0xafd7 45           |                   LD B,L
0xafd8 58           |                   LD E,B
0xafd9 20 28        |                   JR NZ,$28
0xafdb 53           |                   LD D,E
0xafdc 50           |                   LD D,B
0xafdd 29           |                   ADD HL,HL
0xafde 2C           |                   INC L
0xafdf 58           |                   LD E,B
0xafe0 59           |                   LD E,C
0xafe1 00           |                   NOP
0xafe2 FF           |                   RST $38
0xafe3 40           |                   LD B,B
0xafe4 00           |                   NOP
0xafe5 00           |                   NOP
0xafe6 00           |                   NOP
0xafe7 FF           |                   RST $38
0xafe8 AA           |                   XOR D
0xafe9 CC BB EE     |                   CALL Z,$EEBB
0xafec DD           |                   *ILLEGAL*
0xafed 0C           |                   INC C
0xafee 88           |                   ADC A,B
0xafef 88           |                   ADC A,B
0xaff0 DD 77 FD     |                   LD (IX+$FD),A
0xaff3 34           |                   INC (HL)
0xaff4 12           |                   LD (DE),A
0xaff5 00           |                   NOP
0xaff6 C0           |                   RET NZ
0xaff7 3F           |                   CCF
0xaff8 00           |                   NOP
0xaff9 00           |                   NOP
0xaffa 00           |                   NOP
0xaffb 00           |                   NOP
0xaffc 00           |                   NOP
0xaffd 00           |                   NOP
0xaffe 00           |                   NOP
0xafff 00           |                   NOP
0xb000 00           |                   NOP
0xb001 00           |                   NOP
0xb002 00           |                   NOP
0xb003 00           |                   NOP
0xb004 00           |                   NOP
0xb005 00           |                   NOP
0xb006 00           |                   NOP
0xb007 00           |                   NOP
0xb008 00           |                   NOP
0xb009 00           |                   NOP
0xb00a 00           |                   NOP
0xb00b 00           |                   NOP
0xb00c 00           |                   NOP
0xb00d 00           |                   NOP
0xb00e 00           |                   NOP
0xb00f FF           |                   RST $38
0xb010 01 01 80     |                   LD BC,$8001
0xb013 01 80 01     |                   LD BC,$0180
0xb016 00           |                   NOP
0xb017 00           |                   NOP
0xb018 00           |                   NOP
0xb019 00           |                   NOP
0xb01a 00           |                   NOP
0xb01b 01 80 00     |                   LD BC,$0080
0xb01e 00           |                   NOP
0xb01f 48           |                   LD C,B
0xb020 95           |                   SUB A,L
0xb021 68           |                   LD L,B
0xb022 EF           |                   RST $28
0xb023 4C           |                   LD C,H
0xb024 44           |                   LD B,H
0xb025 20 5B        |                   JR NZ,$5B
0xb027 52           |                   LD D,D
0xb028 2C           |                   INC L
0xb029 28 48        |                   JR Z,$48
0xb02b 4C           |                   LD C,H
0xb02c 29           |                   ADD HL,HL
0xb02d 5D           |                   LD E,L
0xb02e 2C           |                   INC L
0xb02f 5B           |                   LD E,E
0xb030 52           |                   LD D,D
0xb031 2C           |                   INC L
0xb032 28 48        |                   JR Z,$48
0xb034 4C           |                   LD C,H
0xb035 29           |                   ADD HL,HL
0xb036 5D           |                   LD E,L
0xb037 00           |                   NOP
0xb038 FF           |                   RST $38
0xb039 DD           |                   *ILLEGAL*
0xb03a 40           |                   LD B,B
0xb03b 00           |                   NOP
0xb03c 00           |                   NOP
0xb03d FF           |                   RST $38
0xb03e AA           |                   XOR D
0xb03f CC BB EE     |                   CALL Z,$EEBB
0xb042 DD           |                   *ILLEGAL*
0xb043 11 44 0C     |                   LD DE,$0C44
0xb046 88           |                   ADC A,B
0xb047 0C           |                   INC C
0xb048 88           |                   ADC A,B
0xb049 34           |                   INC (HL)
0xb04a 12           |                   LD (DE),A
0xb04b 00           |                   NOP
0xb04c C0           |                   RET NZ
0xb04d 20 3F        |                   JR NZ,$3F
0xb04f 00           |                   NOP
0xb050 00           |                   NOP
0xb051 00           |                   NOP
0xb052 00           |                   NOP
0xb053 00           |                   NOP
0xb054 00           |                   NOP
0xb055 00           |                   NOP
0xb056 00           |                   NOP
0xb057 00           |                   NOP
0xb058 00           |                   NOP
0xb059 00           |                   NOP
0xb05a 00           |                   NOP
0xb05b 00           |                   NOP
0xb05c 00           |                   NOP
0xb05d 00           |                   NOP
0xb05e 00           |                   NOP
0xb05f 00           |                   NOP
0xb060 00           |                   NOP
0xb061 00           |                   NOP
0xb062 00           |                   NOP
0xb063 00           |                   NOP
0xb064 00           |                   NOP
0xb065 FF           |                   RST $38
0xb066 01 01 80     |                   LD BC,$8001
0xb069 01 80 01     |                   LD BC,$0180
0xb06c 80           |                   AA,B
0xb06d 01 00 01     |                   LD BC,$0100
0xb070 00           |                   NOP
0xb071 01 80 00     |                   LD BC,$0080
0xb074 00           |                   NOP
0xb075 F9           |                   LD SP,HL
0xb076 A8           |                   XOR B
0xb077 0F           |                   RRCA
0xb078 96           |                   SUB A,(HL)
0xb079 4C           |                   LD C,H
0xb07a 44           |                   LD B,H
0xb07b 20 5B        |                   JR NZ,$5B
0xb07d 58           |                   LD E,B
0xb07e 2C           |                   INC L
0xb07f 28 58        |                   JR Z,$58
0xb081 59           |                   LD E,C
0xb082 29           |                   ADD HL,HL
0xb083 5D           |                   LD E,L
0xb084 2C           |                   INC L
0xb085 5B           |                   LD E,E
0xb086 58           |                   LD E,B
0xb087 2C           |                   INC L
0xb088 28 58        |                   JR Z,$58
0xb08a 59           |                   LD E,C
0xb08b 29           |                   ADD HL,HL
0xb08c 5D           |                   LD E,L
0xb08d 00           |                   NOP
0xb08e FF           |                   RST $38
0xb08f DD 46 80     |                   LD B,(IX+$80)
0xb092 00           |                   NOP
0xb093 FF           |                   RST $38
0xb094 AA           |                   XOR D
0xb095 CC BB EE     |                   CALL Z,$EEBB
0xb098 DD           |                   *ILLEGAL*
0xb099 11 44 8C     |                   LD DE,$8C44
0xb09c 88           |                   ADC A,B
0xb09d 8C           |                   ADC A,H
0xb09e 88           |                   ADC A,B
0xb09f 34           |                   INC (HL)
0xb0a0 12           |                   LD (DE),A
0xb0a1 00           |                   NOP
0xb0a2 C0           |                   RET NZ
0xb0a3 20 38        |                   JR NZ,$38
0xb0a5 00           |                   NOP
0xb0a6 00           |                   NOP
0xb0a7 00           |                   NOP
0xb0a8 00           |                   NOP
0xb0a9 00           |                   NOP
0xb0aa 00           |                   NOP
0xb0ab 00           |                   NOP
0xb0ac 00           |                   NOP
0xb0ad 00           |                   NOP
0xb0ae 00           |                   NOP
0xb0af 00           |                   NOP
0xb0b0 00           |                   NOP
0xb0b1 00           |                   NOP
0xb0b2 00           |                   NOP
0xb0b3 00           |                   NOP
0xb0b4 00           |                   NOP
0xb0b5 00           |                   NOP
0xb0b6 00           |                   NOP
0xb0b7 00           |                   NOP
0xb0b8 00           |                   NOP
0xb0b9 01 00 FF     |                   LD BC,$FF00
0xb0bc 01 01 80     |                   LD BC,$8001
0xb0bf 01 80 01     |                   LD BC,$0180
0xb0c2 80           |                   AA,B
0xb0c3 01 00 01     |                   LD BC,$0100
0xb0c6 00           |                   NOP
0xb0c7 01 80 00     |                   LD BC,$0080
0xb0ca 00           |                   NOP
0xb0cb C4 C0 B4     |                   CALL NZ,$B4C0
0xb0ce FE 4C        |                   CP $4C
0xb0d0 44           |                   LD B,H
0xb0d1 20 52        |                   JR NZ,$52
0xb0d3 2C           |                   INC L
0xb0d4 28 58        |                   JR Z,$58
0xb0d6 59           |                   LD E,C
0xb0d7 29           |                   ADD HL,HL
0xb0d8 00           |                   NOP
0xb0d9 FF           |                   RST $38
0xb0da DD 70 7E     |                   LD (IX+$7E),B
0xb0dd 00           |                   NOP
0xb0de FF           |                   RST $38
0xb0df AA           |                   XOR D
0xb0e0 CC BB EE     |                   CALL Z,$EEBB
0xb0e3 DD           |                   *ILLEGAL*
0xb0e4 11 44 8E     |                   LD DE,$8E44
0xb0e7 87           |                   AA,A
0xb0e8 8E           |                   ADC A,(HL)
0xb0e9 87           |                   AA,A
0xb0ea 34           |                   INC (HL)
0xb0eb 12           |                   LD (DE),A
0xb0ec 00           |                   NOP
0xb0ed C0           |                   RET NZ
0xb0ee 20 07        |                   JR NZ,$07
0xb0f0 00           |                   NOP
0xb0f1 00           |                   NOP
0xb0f2 00           |                   NOP
0xb0f3 00           |                   NOP
0xb0f4 00           |                   NOP
0xb0f5 00           |                   NOP
0xb0f6 00           |                   NOP
0xb0f7 00           |                   NOP
0xb0f8 00           |                   NOP
0xb0f9 00           |                   NOP
0xb0fa 00           |                   NOP
0xb0fb 00           |                   NOP
0xb0fc 00           |                   NOP
0xb0fd 00           |                   NOP
0xb0fe 00           |                   NOP
0xb0ff 00           |                   NOP
0xb100 00           |                   NOP
0xb101 00           |                   NOP
0xb102 00           |                   NOP
0xb103 00           |                   NOP
0xb104 01 00 FF     |                   LD BC,$FF00
0xb107 01 01 80     |                   LD BC,$8001
0xb10a 01 80 01     |                   LD BC,$0180
0xb10d 80           |                   AA,B
0xb10e 01 00 01     |                   LD BC,$0100
0xb111 00           |                   NOP
0xb112 01 80 00     |                   LD BC,$0080
0xb115 00           |                   NOP
0xb116 F6 4A        |                   OR $4A
0xb118 56           |                   LD D,(HL)
0xb119 33           |                   INC SP
0xb11a 4C           |                   LD C,H
0xb11b 44           |                   LD B,H
0xb11c 20 28        |                   JR NZ,$28
0xb11e 58           |                   LD E,B
0xb11f 59           |                   LD E,C
0xb120 29           |                   ADD HL,HL
0xb121 2C           |                   INC L
0xb122 52           |                   LD D,D
0xb123 00           |                   NOP
0xb124 FF           |                   RST $38
0xb125 06 00        |                   LD B,$00
0xb127 00           |                   NOP
0xb128 00           |                   NOP
0xb129 FF           |                   RST $38
0xb12a AA           |                   XOR D
0xb12b CC BB EE     |                   CALL Z,$EEBB
0xb12e DD           |                   *ILLEGAL*
0xb12f 0C           |                   INC C
0xb130 88           |                   ADC A,B
0xb131 88           |                   ADC A,B
0xb132 DD 77 FD     |                   LD (IX+$FD),A
0xb135 34           |                   INC (HL)
0xb136 12           |                   LD (DE),A
0xb137 00           |                   NOP
0xb138 C0           |                   RET NZ
0xb139 38 00        |                   JR C,$00
0xb13b 00           |                   NOP
0xb13c 00           |                   NOP
0xb13d 00           |                   NOP
0xb13e 00           |                   NOP
0xb13f 00           |                   NOP
0xb140 00           |                   NOP
0xb141 00           |                   NOP
0xb142 00           |                   NOP
0xb143 00           |                   NOP
0xb144 00           |                   NOP
0xb145 00           |                   NOP
0xb146 00           |                   NOP
0xb147 00           |                   NOP
0xb148 00           |                   NOP
0xb149 00           |                   NOP
0xb14a 00           |                   NOP
0xb14b 00           |                   NOP
0xb14c 00           |                   NOP
0xb14d 00           |                   NOP
0xb14e FF           |                   RST $38
0xb14f 00           |                   NOP
0xb150 00           |                   NOP
0xb151 FF           |                   RST $38
0xb152 00           |                   NOP
0xb153 00           |                   NOP
0xb154 00           |                   NOP
0xb155 00           |                   NOP
0xb156 00           |                   NOP
0xb157 00           |                   NOP
0xb158 00           |                   NOP
0xb159 00           |                   NOP
0xb15a 00           |                   NOP
0xb15b 00           |                   NOP
0xb15c 00           |                   NOP
0xb15d 00           |                   NOP
0xb15e 00           |                   NOP
0xb15f 00           |                   NOP
0xb160 00           |                   NOP
0xb161 54           |                   LD D,H
0xb162 C1           |                   POP BC
0xb163 DE 93        |                   SBC A,$93
0xb165 4C           |                   LD C,H
0xb166 44           |                   LD B,H
0xb167 20 5B        |                   JR NZ,$5B
0xb169 52           |                   LD D,D
0xb16a 2C           |                   INC L
0xb16b 28 48        |                   JR Z,$48
0xb16d 4C           |                   LD C,H
0xb16e 29           |                   ADD HL,HL
0xb16f 5D           |                   LD E,L
0xb170 2C           |                   INC L
0xb171 4E           |                   LD C,(HL)
0xb172 00           |                   NOP
0xb173 FF           |                   RST $38
0xb174 DD 26 00     |                   LD IXH,$00
0xb177 00           |                   NOP
0xb178 FF           |                   RST $38
0xb179 AA           |                   XOR D
0xb17a CC BB EE     |                   CALL Z,$EEBB
0xb17d DD           |                   *ILLEGAL*
0xb17e 11 44 88     |                   LD DE,$8844
0xb181 DD 77 FD     |                   LD (IX+$FD),A
0xb184 34           |                   INC (HL)
0xb185 12           |                   LD (DE),A
0xb186 00           |                   NOP
0xb187 C0           |                   RET NZ
0xb188 20 08        |                   JR NZ,$08
0xb18a 00           |                   NOP
0xb18b 00           |                   NOP
0xb18c 00           |                   NOP
0xb18d 00           |                   NOP
0xb18e 00           |                   NOP
0xb18f 00           |                   NOP
0xb190 00           |                   NOP
0xb191 00           |                   NOP
0xb192 00           |                   NOP
0xb193 00           |                   NOP
0xb194 00           |                   NOP
0xb195 00           |                   NOP
0xb196 00           |                   NOP
0xb197 00           |                   NOP
0xb198 00           |                   NOP
0xb199 00           |                   NOP
0xb19a 00           |                   NOP
0xb19b 00           |                   NOP
0xb19c 00           |                   NOP
0xb19d 00           |                   NOP
0xb19e FF           |                   RST $38
0xb19f 00           |                   NOP
0xb1a0 FF           |                   RST $38
0xb1a1 00           |                   NOP
0xb1a2 00           |                   NOP
0xb1a3 00           |                   NOP
0xb1a4 00           |                   NOP
0xb1a5 00           |                   NOP
0xb1a6 00           |                   NOP
0xb1a7 00           |                   NOP
0xb1a8 00           |                   NOP
0xb1a9 00           |                   NOP
0xb1aa 00           |                   NOP
0xb1ab 00           |                   NOP
0xb1ac 00           |                   NOP
0xb1ad 00           |                   NOP
0xb1ae 00           |                   NOP
0xb1af 00           |                   NOP
0xb1b0 96           |                   SUB A,(HL)
0xb1b1 B8           |                   CP B
0xb1b2 60           |                   LD H,B
0xb1b3 77           |                   LD (HL),A
0xb1b4 4C           |                   LD C,H
0xb1b5 44           |                   LD B,H
0xb1b6 20 58        |                   JR NZ,$58
0xb1b8 2C           |                   INC L
0xb1b9 4E           |                   LD C,(HL)
0xb1ba 00           |                   NOP
0xb1bb FF           |                   RST $38
0xb1bc DD           |                   *ILLEGAL*
0xb1bd 36 00        |                   LD (HL),$00
0xb1bf 00           |                   NOP
0xb1c0 FF           |                   RST $38
0xb1c1 AA           |                   XOR D
0xb1c2 CC BB EE     |                   CALL Z,$EEBB
0xb1c5 DD           |                   *ILLEGAL*
0xb1c6 11 44 0C     |                   LD DE,$0C44
0xb1c9 88           |                   ADC A,B
0xb1ca 0C           |                   INC C
0xb1cb 88           |                   ADC A,B
0xb1cc 34           |                   INC (HL)
0xb1cd 12           |                   LD (DE),A
0xb1ce 00           |                   NOP
0xb1cf C0           |                   RET NZ
0xb1d0 20 00        |                   JR NZ,$00
0xb1d2 00           |                   NOP
0xb1d3 00           |                   NOP
0xb1d4 00           |                   NOP
0xb1d5 00           |                   NOP
0xb1d6 00           |                   NOP
0xb1d7 00           |                   NOP
0xb1d8 00           |                   NOP
0xb1d9 00           |                   NOP
0xb1da 00           |                   NOP
0xb1db 00           |                   NOP
0xb1dc 00           |                   NOP
0xb1dd 00           |                   NOP
0xb1de 00           |                   NOP
0xb1df 00           |                   NOP
0xb1e0 00           |                   NOP
0xb1e1 00           |                   NOP
0xb1e2 00           |                   NOP
0xb1e3 00           |                   NOP
0xb1e4 00           |                   NOP
0xb1e5 00           |                   NOP
0xb1e6 01 FF FF     |                   LD BC,$FFFF
0xb1e9 00           |                   NOP
0xb1ea 00           |                   NOP
0xb1eb 00           |                   NOP
0xb1ec 00           |                   NOP
0xb1ed 00           |                   NOP
0xb1ee 00           |                   NOP
0xb1ef 00           |                   NOP
0xb1f0 01 00 01     |                   LD BC,$0100
0xb1f3 00           |                   NOP
0xb1f4 00           |                   NOP
0xb1f5 00           |                   NOP
0xb1f6 00           |                   NOP
0xb1f7 00           |                   NOP
0xb1f8 5F           |                   LD E,A
0xb1f9 B4           |                   OR H
0xb1fa 95           |                   SUB A,L
0xb1fb 29           |                   ADD HL,HL
0xb1fc 4C           |                   LD C,H
0xb1fd 44           |                   LD B,H
0xb1fe 20 28        |                   JR NZ,$28
0xb200 58           |                   LD E,B
0xb201 59           |                   LD E,C
0xb202 29           |                   ADD HL,HL
0xb203 2C           |                   INC L
0xb204 4E           |                   LD C,(HL)
0xb205 00           |                   NOP
0xb206 FF           |                   RST $38
0xb207 0A           |                   LD A,(BC)
0xb208 00           |                   NOP
0xb209 00           |                   NOP
0xb20a 00           |                   NOP
0xb20b FF           |                   RST $38
0xb20c AA           |                   XOR D
0xb20d 0C           |                   INC C
0xb20e 88           |                   ADC A,B
0xb20f 0C           |                   INC C
0xb210 88           |                   ADC A,B
0xb211 11 44 88     |                   LD DE,$8844
0xb214 DD 77 FD     |                   LD (IX+$FD),A
0xb217 34           |                   INC (HL)
0xb218 12           |                   LD (DE),A
0xb219 00           |                   NOP
0xb21a C0           |                   RET NZ
0xb21b 10 00        |                   DJNZ $00
0xb21d 00           |                   NOP
0xb21e 00           |                   NOP
0xb21f 00           |                   NOP
0xb220 00           |                   NOP
0xb221 01 00 01     |                   LD BC,$0100
0xb224 00           |                   NOP
0xb225 00           |                   NOP
0xb226 00           |                   NOP
0xb227 00           |                   NOP
0xb228 00           |                   NOP
0xb229 00           |                   NOP
0xb22a 00           |                   NOP
0xb22b 00           |                   NOP
0xb22c 00           |                   NOP
0xb22d 00           |                   NOP
0xb22e 00           |                   NOP
0xb22f 00           |                   NOP
0xb230 00           |                   NOP
0xb231 00           |                   NOP
0xb232 00           |                   NOP
0xb233 FF           |                   RST $38
0xb234 00           |                   NOP
0xb235 00           |                   NOP
0xb236 00           |                   NOP
0xb237 00           |                   NOP
0xb238 00           |                   NOP
0xb239 00           |                   NOP
0xb23a 00           |                   NOP
0xb23b 00           |                   NOP
0xb23c 00           |                   NOP
0xb23d 00           |                   NOP
0xb23e 00           |                   NOP
0xb23f 00           |                   NOP
0xb240 00           |                   NOP
0xb241 00           |                   NOP
0xb242 00           |                   NOP
0xb243 44           |                   LD B,H
0xb244 65           |                   LD H,L
0xb245 9E           |                   SBC A,(HL)
0xb246 CA 4C 44     |                   JP Z,$444C
0xb249 20 41        |                   JR NZ,$41
0xb24b 2C           |                   INC L
0xb24c 28 5B        |                   JR Z,$5B
0xb24e 42           |                   LD B,D
0xb24f 43           |                   LD B,E
0xb250 2C           |                   INC L
0xb251 44           |                   LD B,H
0xb252 45           |                   LD B,L
0xb253 5D           |                   LD E,L
0xb254 29           |                   ADD HL,HL
0xb255 00           |                   NOP
0xb256 FF           |                   RST $38
0xb257 02           |                   LD (BC),A
0xb258 00           |                   NOP
0xb259 00           |                   NOP
0xb25a 00           |                   NOP
0xb25b FF           |                   RST $38
0xb25c AA           |                   XOR D
0xb25d 0C           |                   INC C
0xb25e 88           |                   ADC A,B
0xb25f 0C           |                   INC C
0xb260 88           |                   ADC A,B
0xb261 11 44 88     |                   LD DE,$8844
0xb264 DD 77 FD     |                   LD (IX+$FD),A
0xb267 34           |                   INC (HL)
0xb268 12           |                   LD (DE),A
0xb269 00           |                   NOP
0xb26a C0           |                   RET NZ
0xb26b 10 00        |                   DJNZ $00
0xb26d 00           |                   NOP
0xb26e 00           |                   NOP
0xb26f 00           |                   NOP
0xb270 01 01 00     |                   LD BC,$0001
0xb273 01 00 00     |                   LD BC,$0000
0xb276 00           |                   NOP
0xb277 00           |                   NOP
0xb278 00           |                   NOP
0xb279 00           |                   NOP
0xb27a 00           |                   NOP
0xb27b 00           |                   NOP
0xb27c 00           |                   NOP
0xb27d 00           |                   NOP
0xb27e 00           |                   NOP
0xb27f 00           |                   NOP
0xb280 00           |                   NOP
0xb281 00           |                   NOP
0xb282 00           |                   NOP
0xb283 FF           |                   RST $38
0xb284 00           |                   NOP
0xb285 00           |                   NOP
0xb286 00           |                   NOP
0xb287 00           |                   NOP
0xb288 00           |                   NOP
0xb289 00           |                   NOP
0xb28a 00           |                   NOP
0xb28b 00           |                   NOP
0xb28c 00           |                   NOP
0xb28d 00           |                   NOP
0xb28e 00           |                   NOP
0xb28f 00           |                   NOP
0xb290 00           |                   NOP
0xb291 00           |                   NOP
0xb292 00           |                   NOP
0xb293 17           |                   RLA
0xb294 FC A3 0A     |                   CALL M,$0AA3
0xb297 4C           |                   LD C,H
0xb298 44           |                   LD B,H
0xb299 20 28        |                   JR NZ,$28
0xb29b 5B           |                   LD E,E
0xb29c 42           |                   LD B,D
0xb29d 43           |                   LD B,E
0xb29e 2C           |                   INC L
0xb29f 44           |                   LD B,H
0xb2a0 45           |                   LD B,L
0xb2a1 5D           |                   LD E,L
0xb2a2 29           |                   ADD HL,HL
0xb2a3 2C           |                   INC L
0xb2a4 41           |                   LD B,C
0xb2a5 00           |                   NOP
0xb2a6 FF           |                   RST $38
0xb2a7 3A 0C 88     |                   LD A,($880C)
0xb2aa 00           |                   NOP
0xb2ab FF           |                   RST $38
0xb2ac AA           |                   XOR D
0xb2ad CC BB EE     |                   CALL Z,$EEBB
0xb2b0 DD           |                   *ILLEGAL*
0xb2b1 11 44 88     |                   LD DE,$8844
0xb2b4 DD 77 FD     |                   LD (IX+$FD),A
0xb2b7 34           |                   INC (HL)
0xb2b8 12           |                   LD (DE),A
0xb2b9 00           |                   NOP
0xb2ba C0           |                   RET NZ
0xb2bb 00           |                   NOP
0xb2bc 01 00 00     |                   LD BC,$0000
0xb2bf 00           |                   NOP
0xb2c0 00           |                   NOP
0xb2c1 00           |                   NOP
0xb2c2 00           |                   NOP
0xb2c3 00           |                   NOP
0xb2c4 00           |                   NOP
0xb2c5 00           |                   NOP
0xb2c6 00           |                   NOP
0xb2c7 00           |                   NOP
0xb2c8 00           |                   NOP
0xb2c9 00           |                   NOP
0xb2ca 00           |                   NOP
0xb2cb 00           |                   NOP
0xb2cc 00           |                   NOP
0xb2cd 00           |                   NOP
0xb2ce 00           |                   NOP
0xb2cf 00           |                   NOP
0xb2d0 00           |                   NOP
0xb2d1 00           |                   NOP
0xb2d2 00           |                   NOP
0xb2d3 FF           |                   RST $38
0xb2d4 00           |                   NOP
0xb2d5 00           |                   NOP
0xb2d6 00           |                   NOP
0xb2d7 00           |                   NOP
0xb2d8 00           |                   NOP
0xb2d9 00           |                   NOP
0xb2da 00           |                   NOP
0xb2db 00           |                   NOP
0xb2dc 00           |                   NOP
0xb2dd 00           |                   NOP
0xb2de 00           |                   NOP
0xb2df 00           |                   NOP
0xb2e0 00           |                   NOP
0xb2e1 00           |                   NOP
0xb2e2 00           |                   NOP
0xb2e3 6E           |                   LD L,(HL)
0xb2e4 96           |                   SUB A,(HL)
0xb2e5 FA 8F 4C     |                   JP M,$4C8F
0xb2e8 44           |                   LD B,H
0xb2e9 20 41        |                   JR NZ,$41
0xb2eb 2C           |                   INC L
0xb2ec 28 4E        |                   JR Z,$4E
0xb2ee 4E           |                   LD C,(HL)
0xb2ef 29           |                   ADD HL,HL
0xb2f0 00           |                   NOP
0xb2f1 FF           |                   RST $38
0xb2f2 32 0C 88     |                   LD ($880C),A
0xb2f5 00           |                   NOP
0xb2f6 FF           |                   RST $38
0xb2f7 AA           |                   XOR D
0xb2f8 CC BB EE     |                   CALL Z,$EEBB
0xb2fb DD           |                   *ILLEGAL*
0xb2fc 11 44 88     |                   LD DE,$8844
0xb2ff DD 77 FD     |                   LD (IX+$FD),A
0xb302 34           |                   INC (HL)
0xb303 12           |                   LD (DE),A
0xb304 00           |                   NOP
0xb305 C0           |                   RET NZ
0xb306 00           |                   NOP
0xb307 01 00 00     |                   LD BC,$0000
0xb30a 00           |                   NOP
0xb30b 01 00 00     |                   LD BC,$0000
0xb30e 00           |                   NOP
0xb30f 00           |                   NOP
0xb310 00           |                   NOP
0xb311 00           |                   NOP
0xb312 00           |                   NOP
0xb313 00           |                   NOP
0xb314 00           |                   NOP
0xb315 00           |                   NOP
0xb316 00           |                   NOP
0xb317 00           |                   NOP
0xb318 00           |                   NOP
0xb319 00           |                   NOP
0xb31a 00           |                   NOP
0xb31b 00           |                   NOP
0xb31c 00           |                   NOP
0xb31d 00           |                   NOP
0xb31e FF           |                   RST $38
0xb31f 00           |                   NOP
0xb320 00           |                   NOP
0xb321 00           |                   NOP
0xb322 00           |                   NOP
0xb323 00           |                   NOP
0xb324 00           |                   NOP
0xb325 00           |                   NOP
0xb326 00           |                   NOP
0xb327 00           |                   NOP
0xb328 00           |                   NOP
0xb329 00           |                   NOP
0xb32a 00           |                   NOP
0xb32b 00           |                   NOP
0xb32c 00           |                   NOP
0xb32d 00           |                   NOP
0xb32e F5           |                   PUSH AF
0xb32f 40           |                   LD B,B
0xb330 8E           |                   ADC A,(HL)
0xb331 38 4C        |                   JR C,$4C
0xb333 44           |                   LD B,H
0xb334 20 28        |                   JR NZ,$28
0xb336 4E           |                   LD C,(HL)
0xb337 4E           |                   LD C,(HL)
0xb338 29           |                   ADD HL,HL
0xb339 2C           |                   INC L
0xb33a 41           |                   LD B,C
0xb33b 00           |                   NOP
0xb33c FF           |                   RST $38
0xb33d 01 00 00     |                   LD BC,$0000
0xb340 00           |                   NOP
0xb341 FF           |                   RST $38
0xb342 AA           |                   XOR D
0xb343 CC BB EE     |                   CALL Z,$EEBB
0xb346 DD           |                   *ILLEGAL*
0xb347 11 44 88     |                   LD DE,$8844
0xb34a DD 77 FD     |                   LD (IX+$FD),A
0xb34d 34           |                   INC (HL)
0xb34e 12           |                   LD (DE),A
0xb34f 00           |                   NOP
0xb350 C0           |                   RET NZ
0xb351 30 00        |                   JR NC,$00
0xb353 00           |                   NOP
0xb354 00           |                   NOP
0xb355 00           |                   NOP
0xb356 00           |                   NOP
0xb357 00           |                   NOP
0xb358 00           |                   NOP
0xb359 00           |                   NOP
0xb35a 00           |                   NOP
0xb35b 00           |                   NOP
0xb35c 00           |                   NOP
0xb35d 00           |                   NOP
0xb35e 00           |                   NOP
0xb35f 00           |                   NOP
0xb360 00           |                   NOP
0xb361 00           |                   NOP
0xb362 00           |                   NOP
0xb363 00           |                   NOP
0xb364 00           |                   NOP
0xb365 00           |                   NOP
0xb366 FF           |                   RST $38
0xb367 FF           |                   RST $38
0xb368 00           |                   NOP
0xb369 FF           |                   RST $38
0xb36a 00           |                   NOP
0xb36b 00           |                   NOP
0xb36c 00           |                   NOP
0xb36d 00           |                   NOP
0xb36e 00           |                   NOP
0xb36f 00           |                   NOP
0xb370 00           |                   NOP
0xb371 00           |                   NOP
0xb372 00           |                   NOP
0xb373 00           |                   NOP
0xb374 00           |                   NOP
0xb375 00           |                   NOP
0xb376 00           |                   NOP
0xb377 00           |                   NOP
0xb378 00           |                   NOP
0xb379 1A           |                   LD A,(DE)
0xb37a 6B           |                   LD L,E
0xb37b 8A           |                   ADC A,D
0xb37c BC           |                   CP H
0xb37d 4C           |                   LD C,H
0xb37e 44           |                   LD B,H
0xb37f 20 52        |                   JR NZ,$52
0xb381 52           |                   LD D,D
0xb382 2C           |                   INC L
0xb383 4E           |                   LD C,(HL)
0xb384 4E           |                   LD C,(HL)
0xb385 00           |                   NOP
0xb386 FF           |                   RST $38
0xb387 DD 21 00 00  |                   LD IX,$0000
0xb38b FF           |                   RST $38
0xb38c AA           |                   XOR D
0xb38d CC BB EE     |                   CALL Z,$EEBB
0xb390 DD           |                   *ILLEGAL*
0xb391 11 44 88     |                   LD DE,$8844
0xb394 DD 77 FD     |                   LD (IX+$FD),A
0xb397 34           |                   INC (HL)
0xb398 12           |                   LD (DE),A
0xb399 00           |                   NOP
0xb39a C0           |                   RET NZ
0xb39b 20 00        |                   JR NZ,$00
0xb39d 00           |                   NOP
0xb39e 00           |                   NOP
0xb39f 00           |                   NOP
0xb3a0 00           |                   NOP
0xb3a1 00           |                   NOP
0xb3a2 00           |                   NOP
0xb3a3 00           |                   NOP
0xb3a4 00           |                   NOP
0xb3a5 00           |                   NOP
0xb3a6 00           |                   NOP
0xb3a7 00           |                   NOP
0xb3a8 00           |                   NOP
0xb3a9 00           |                   NOP
0xb3aa 00           |                   NOP
0xb3ab 00           |                   NOP
0xb3ac 00           |                   NOP
0xb3ad 00           |                   NOP
0xb3ae 00           |                   NOP
0xb3af 00           |                   NOP
0xb3b0 00           |                   NOP
0xb3b1 FF           |                   RST $38
0xb3b2 FF           |                   RST $38
0xb3b3 FF           |                   RST $38
0xb3b4 00           |                   NOP
0xb3b5 00           |                   NOP
0xb3b6 00           |                   NOP
0xb3b7 00           |                   NOP
0xb3b8 00           |                   NOP
0xb3b9 00           |                   NOP
0xb3ba 00           |                   NOP
0xb3bb 00           |                   NOP
0xb3bc 00           |                   NOP
0xb3bd 00           |                   NOP
0xb3be 00           |                   NOP
0xb3bf 00           |                   NOP
0xb3c0 00           |                   NOP
0xb3c1 00           |                   NOP
0xb3c2 00           |                   NOP
0xb3c3 F7           |                   RST $30
0xb3c4 28 DF        |                   JR Z,$DF
0xb3c6 10 4C        |                   DJNZ $4C
0xb3c8 44           |                   LD B,H
0xb3c9 20 58        |                   JR NZ,$58
0xb3cb 59           |                   LD E,C
0xb3cc 2C           |                   INC L
0xb3cd 4E           |                   LD C,(HL)
0xb3ce 4E           |                   LD C,(HL)
0xb3cf 00           |                   NOP
0xb3d0 FF           |                   RST $38
0xb3d1 2A 0C 88     |                   LD HL,($880C)
0xb3d4 00           |                   NOP
0xb3d5 FF           |                   RST $38
0xb3d6 AA           |                   XOR D
0xb3d7 CC BB EE     |                   CALL Z,$EEBB
0xb3da DD           |                   *ILLEGAL*
0xb3db 11 44 88     |                   LD DE,$8844
0xb3de DD 77 FD     |                   LD (IX+$FD),A
0xb3e1 34           |                   INC (HL)
0xb3e2 12           |                   LD (DE),A
0xb3e3 00           |                   NOP
0xb3e4 C0           |                   RET NZ
0xb3e5 00           |                   NOP
0xb3e6 00           |                   NOP
0xb3e7 00           |                   NOP
0xb3e8 00           |                   NOP
0xb3e9 00           |                   NOP
0xb3ea 00           |                   NOP
0xb3eb 00           |                   NOP
0xb3ec 00           |                   NOP
0xb3ed 00           |                   NOP
0xb3ee 00           |                   NOP
0xb3ef 00           |                   NOP
0xb3f0 00           |                   NOP
0xb3f1 00           |                   NOP
0xb3f2 00           |                   NOP
0xb3f3 00           |                   NOP
0xb3f4 00           |                   NOP
0xb3f5 00           |                   NOP
0xb3f6 00           |                   NOP
0xb3f7 00           |                   NOP
0xb3f8 00           |                   NOP
0xb3f9 00           |                   NOP
0xb3fa 00           |                   NOP
0xb3fb 00           |                   NOP
0xb3fc 00           |                   NOP
0xb3fd FF           |                   RST $38
0xb3fe 00           |                   NOP
0xb3ff 00           |                   NOP
0xb400 00           |                   NOP
0xb401 00           |                   NOP
0xb402 00           |                   NOP
0xb403 00           |                   NOP
0xb404 00           |                   NOP
0xb405 00           |                   NOP
0xb406 00           |                   NOP
0xb407 00           |                   NOP
0xb408 00           |                   NOP
0xb409 01 80 00     |                   LD BC,$0080
0xb40c 00           |                   NOP
0xb40d 31 03 F8     |                   LD SP,$F803
0xb410 8D           |                   ADC A,L
0xb411 4C           |                   LD C,H
0xb412 44           |                   LD B,H
0xb413 20 48        |                   JR NZ,$48
0xb415 4C           |                   LD C,H
0xb416 2C           |                   INC L
0xb417 28 4E        |                   JR Z,$4E
0xb419 4E           |                   LD C,(HL)
0xb41a 29           |                   ADD HL,HL
0xb41b 00           |                   NOP
0xb41c FF           |                   RST $38
0xb41d DD 2A 0C 88  |                   LD IX,($880C)
0xb421 FF           |                   RST $38
0xb422 AA           |                   XOR D
0xb423 CC BB EE     |                   CALL Z,$EEBB
0xb426 DD           |                   *ILLEGAL*
0xb427 11 44 88     |                   LD DE,$8844
0xb42a DD 77 FD     |                   LD (IX+$FD),A
0xb42d 34           |                   INC (HL)
0xb42e 12           |                   LD (DE),A
0xb42f 00           |                   NOP
0xb430 C0           |                   RET NZ
0xb431 20 00        |                   JR NZ,$00
0xb433 00           |                   NOP
0xb434 00           |                   NOP
0xb435 00           |                   NOP
0xb436 00           |                   NOP
0xb437 00           |                   NOP
0xb438 00           |                   NOP
0xb439 00           |                   NOP
0xb43a 00           |                   NOP
0xb43b 00           |                   NOP
0xb43c 00           |                   NOP
0xb43d 00           |                   NOP
0xb43e 00           |                   NOP
0xb43f 00           |                   NOP
0xb440 00           |                   NOP
0xb441 00           |                   NOP
0xb442 00           |                   NOP
0xb443 00           |                   NOP
0xb444 00           |                   NOP
0xb445 00           |                   NOP
0xb446 00           |                   NOP
0xb447 00           |                   NOP
0xb448 00           |                   NOP
0xb449 FF           |                   RST $38
0xb44a 00           |                   NOP
0xb44b 00           |                   NOP
0xb44c 00           |                   NOP
0xb44d 00           |                   NOP
0xb44e 00           |                   NOP
0xb44f 00           |                   NOP
0xb450 00           |                   NOP
0xb451 00           |                   NOP
0xb452 00           |                   NOP
0xb453 00           |                   NOP
0xb454 00           |                   NOP
0xb455 01 80 00     |                   LD BC,$0080
0xb458 00           |                   NOP
0xb459 68           |                   LD L,B
0xb45a 57           |                   LD D,A
0xb45b 91           |                   SUB A,C
0xb45c 89           |                   ADC A,C
0xb45d 4C           |                   LD C,H
0xb45e 44           |                   LD B,H
0xb45f 20 58        |                   JR NZ,$58
0xb461 59           |                   LD E,C
0xb462 2C           |                   INC L
0xb463 28 4E        |                   JR Z,$4E
0xb465 4E           |                   LD C,(HL)
0xb466 29           |                   ADD HL,HL
0xb467 00           |                   NOP
0xb468 FF           |                   RST $38
0xb469 ED 4B 0C 88  |                   LD BC,($880C)
0xb46d FF           |                   RST $38
0xb46e AA           |                   XOR D
0xb46f CC BB EE     |                   CALL Z,$EEBB
0xb472 DD           |                   *ILLEGAL*
0xb473 11 44 88     |                   LD DE,$8844
0xb476 DD 77 FD     |                   LD (IX+$FD),A
0xb479 34           |                   INC (HL)
0xb47a 12           |                   LD (DE),A
0xb47b 00           |                   NOP
0xb47c C0           |                   RET NZ
0xb47d 00           |                   NOP
0xb47e 30 00        |                   JR NC,$00
0xb480 00           |                   NOP
0xb481 00           |                   NOP
0xb482 00           |                   NOP
0xb483 00           |                   NOP
0xb484 00           |                   NOP
0xb485 00           |                   NOP
0xb486 00           |                   NOP
0xb487 00           |                   NOP
0xb488 00           |                   NOP
0xb489 00           |                   NOP
0xb48a 00           |                   NOP
0xb48b 00           |                   NOP
0xb48c 00           |                   NOP
0xb48d 00           |                   NOP
0xb48e 00           |                   NOP
0xb48f 00           |                   NOP
0xb490 00           |                   NOP
0xb491 00           |                   NOP
0xb492 00           |                   NOP
0xb493 00           |                   NOP
0xb494 00           |                   NOP
0xb495 FF           |                   RST $38
0xb496 00           |                   NOP
0xb497 00           |                   NOP
0xb498 00           |                   NOP
0xb499 00           |                   NOP
0xb49a 00           |                   NOP
0xb49b 00           |                   NOP
0xb49c 00           |                   NOP
0xb49d 00           |                   NOP
0xb49e 00           |                   NOP
0xb49f 00           |                   NOP
0xb4a0 00           |                   NOP
0xb4a1 01 80 00     |                   LD BC,$0080
0xb4a4 00           |                   NOP
0xb4a5 19           |                   ADD HL,DE
0xb4a6 1F           |                   RRA
0xb4a7 2B           |                   DEC HL
0xb4a8 C3 4C 44     |                   JP $444C
0xb4ab 20 52        |                   JR NZ,$52
0xb4ad 52           |                   LD D,D
0xb4ae 2C           |                   INC L
0xb4af 28 4E        |                   JR Z,$4E
0xb4b1 4E           |                   LD C,(HL)
0xb4b2 29           |                   ADD HL,HL
0xb4b3 00           |                   NOP
0xb4b4 FF           |                   RST $38
0xb4b5 22 0C 88     |                   LD ($880C),HL
0xb4b8 00           |                   NOP
0xb4b9 FF           |                   RST $38
0xb4ba AA           |                   XOR D
0xb4bb CC BB EE     |                   CALL Z,$EEBB
0xb4be DD           |                   *ILLEGAL*
0xb4bf 11 44 88     |                   LD DE,$8844
0xb4c2 DD 77 FD     |                   LD (IX+$FD),A
0xb4c5 34           |                   INC (HL)
0xb4c6 12           |                   LD (DE),A
0xb4c7 00           |                   NOP
0xb4c8 C0           |                   RET NZ
0xb4c9 00           |                   NOP
0xb4ca 00           |                   NOP
0xb4cb 00           |                   NOP
0xb4cc 00           |                   NOP
0xb4cd 00           |                   NOP
0xb4ce 00           |                   NOP
0xb4cf 00           |                   NOP
0xb4d0 00           |                   NOP
0xb4d1 00           |                   NOP
0xb4d2 00           |                   NOP
0xb4d3 00           |                   NOP
0xb4d4 00           |                   NOP
0xb4d5 00           |                   NOP
0xb4d6 00           |                   NOP
0xb4d7 00           |                   NOP
0xb4d8 00           |                   NOP
0xb4d9 00           |                   NOP
0xb4da 00           |                   NOP
0xb4db 00           |                   NOP
0xb4dc 00           |                   NOP
0xb4dd 00           |                   NOP
0xb4de 00           |                   NOP
0xb4df 00           |                   NOP
0xb4e0 00           |                   NOP
0xb4e1 FF           |                   RST $38
0xb4e2 00           |                   NOP
0xb4e3 00           |                   NOP
0xb4e4 00           |                   NOP
0xb4e5 00           |                   NOP
0xb4e6 00           |                   NOP
0xb4e7 01 80 00     |                   LD BC,$0080
0xb4ea 00           |                   NOP
0xb4eb 00           |                   NOP
0xb4ec 00           |                   NOP
0xb4ed 00           |                   NOP
0xb4ee 00           |                   NOP
0xb4ef 00           |                   NOP
0xb4f0 00           |                   NOP
0xb4f1 89           |                   ADC A,C
0xb4f2 EB           |                   EX DE,HL
0xb4f3 91           |                   SUB A,C
0xb4f4 0D           |                   DEC C
0xb4f5 4C           |                   LD C,H
0xb4f6 44           |                   LD B,H
0xb4f7 20 28        |                   JR NZ,$28
0xb4f9 4E           |                   LD C,(HL)
0xb4fa 4E           |                   LD C,(HL)
0xb4fb 29           |                   ADD HL,HL
0xb4fc 2C           |                   INC L
0xb4fd 48           |                   LD C,B
0xb4fe 4C           |                   LD C,H
0xb4ff 00           |                   NOP
0xb500 FF           |                   RST $38
0xb501 DD 22 0C 88  |                   LD ($880C),IX
0xb505 FF           |                   RST $38
0xb506 AA           |                   XOR D
0xb507 CC BB EE     |                   CALL Z,$EEBB
0xb50a DD           |                   *ILLEGAL*
0xb50b 11 44 88     |                   LD DE,$8844
0xb50e DD 77 FD     |                   LD (IX+$FD),A
0xb511 34           |                   INC (HL)
0xb512 12           |                   LD (DE),A
0xb513 00           |                   NOP
0xb514 C0           |                   RET NZ
0xb515 20 00        |                   JR NZ,$00
0xb517 00           |                   NOP
0xb518 00           |                   NOP
0xb519 00           |                   NOP
0xb51a 00           |                   NOP
0xb51b 00           |                   NOP
0xb51c 00           |                   NOP
0xb51d 00           |                   NOP
0xb51e 00           |                   NOP
0xb51f 00           |                   NOP
0xb520 00           |                   NOP
0xb521 00           |                   NOP
0xb522 00           |                   NOP
0xb523 00           |                   NOP
0xb524 00           |                   NOP
0xb525 00           |                   NOP
0xb526 00           |                   NOP
0xb527 00           |                   NOP
0xb528 00           |                   NOP
0xb529 00           |                   NOP
0xb52a 00           |                   NOP
0xb52b 00           |                   NOP
0xb52c 00           |                   NOP
0xb52d FF           |                   RST $38
0xb52e 00           |                   NOP
0xb52f 00           |                   NOP
0xb530 00           |                   NOP
0xb531 00           |                   NOP
0xb532 00           |                   NOP
0xb533 00           |                   NOP
0xb534 00           |                   NOP
0xb535 01 80 01     |                   LD BC,$0180
0xb538 80           |                   AA,B
0xb539 00           |                   NOP
0xb53a 00           |                   NOP
0xb53b 00           |                   NOP
0xb53c 00           |                   NOP
0xb53d CE 4D        |                   ADC A,$4D
0xb53f 56           |                   LD D,(HL)
0xb540 43           |                   LD B,E
0xb541 4C           |                   LD C,H
0xb542 44           |                   LD B,H
0xb543 20 28        |                   JR NZ,$28
0xb545 4E           |                   LD C,(HL)
0xb546 4E           |                   LD C,(HL)
0xb547 29           |                   ADD HL,HL
0xb548 2C           |                   INC L
0xb549 58           |                   LD E,B
0xb54a 59           |                   LD E,C
0xb54b 00           |                   NOP
0xb54c FF           |                   RST $38
0xb54d ED 43 0C 88  |                   LD ($880C),BC
0xb551 FF           |                   RST $38
0xb552 AA           |                   XOR D
0xb553 CC BB EE     |                   CALL Z,$EEBB
0xb556 DD           |                   *ILLEGAL*
0xb557 11 44 88     |                   LD DE,$8844
0xb55a DD 77 FD     |                   LD (IX+$FD),A
0xb55d 34           |                   INC (HL)
0xb55e 12           |                   LD (DE),A
0xb55f 00           |                   NOP
0xb560 C0           |                   RET NZ
0xb561 00           |                   NOP
0xb562 30 00        |                   JR NC,$00
0xb564 00           |                   NOP
0xb565 00           |                   NOP
0xb566 00           |                   NOP
0xb567 00           |                   NOP
0xb568 00           |                   NOP
0xb569 00           |                   NOP
0xb56a 00           |                   NOP
0xb56b 00           |                   NOP
0xb56c 00           |                   NOP
0xb56d 00           |                   NOP
0xb56e 00           |                   NOP
0xb56f 00           |                   NOP
0xb570 00           |                   NOP
0xb571 00           |                   NOP
0xb572 00           |                   NOP
0xb573 00           |                   NOP
0xb574 00           |                   NOP
0xb575 00           |                   NOP
0xb576 00           |                   NOP
0xb577 00           |                   NOP
0xb578 00           |                   NOP
0xb579 FF           |                   RST $38
0xb57a 00           |                   NOP
0xb57b 01 80 01     |                   LD BC,$0180
0xb57e 80           |                   AA,B
0xb57f 01 80 00     |                   LD BC,$0080
0xb582 00           |                   NOP
0xb583 00           |                   NOP
0xb584 00           |                   NOP
0xb585 00           |                   NOP
0xb586 00           |                   NOP
0xb587 01 80 23     |                   LD BC,$2380
0xb58a 1A           |                   LD A,(DE)
0xb58b CF           |                   RST $08
0xb58c 55           |                   LD D,L
0xb58d 4C           |                   LD C,H
0xb58e 44           |                   LD B,H
0xb58f 20 28        |                   JR NZ,$28
0xb591 4E           |                   LD C,(HL)
0xb592 4E           |                   LD C,(HL)
0xb593 29           |                   ADD HL,HL
0xb594 2C           |                   INC L
0xb595 52           |                   LD D,D
0xb596 52           |                   LD D,D
0xb597 00           |                   NOP
0xb598 FF           |                   RST $38
0xb599 F9           |                   LD SP,HL
0xb59a 00           |                   NOP
0xb59b 00           |                   NOP
0xb59c 00           |                   NOP
0xb59d FF           |                   RST $38
0xb59e AA           |                   XOR D
0xb59f CC BB EE     |                   CALL Z,$EEBB
0xb5a2 DD           |                   *ILLEGAL*
0xb5a3 11 44 88     |                   LD DE,$8844
0xb5a6 DD 77 FD     |                   LD (IX+$FD),A
0xb5a9 34           |                   INC (HL)
0xb5aa 12           |                   LD (DE),A
0xb5ab 00           |                   NOP
0xb5ac C0           |                   RET NZ
0xb5ad 00           |                   NOP
0xb5ae 00           |                   NOP
0xb5af 00           |                   NOP
0xb5b0 00           |                   NOP
0xb5b1 00           |                   NOP
0xb5b2 00           |                   NOP
0xb5b3 00           |                   NOP
0xb5b4 00           |                   NOP
0xb5b5 00           |                   NOP
0xb5b6 00           |                   NOP
0xb5b7 00           |                   NOP
0xb5b8 00           |                   NOP
0xb5b9 00           |                   NOP
0xb5ba 00           |                   NOP
0xb5bb 00           |                   NOP
0xb5bc 00           |                   NOP
0xb5bd 00           |                   NOP
0xb5be 00           |                   NOP
0xb5bf 00           |                   NOP
0xb5c0 00           |                   NOP
0xb5c1 00           |                   NOP
0xb5c2 00           |                   NOP
0xb5c3 00           |                   NOP
0xb5c4 00           |                   NOP
0xb5c5 FF           |                   RST $38
0xb5c6 00           |                   NOP
0xb5c7 00           |                   NOP
0xb5c8 00           |                   NOP
0xb5c9 00           |                   NOP
0xb5ca 00           |                   NOP
0xb5cb 01 80 00     |                   LD BC,$0080
0xb5ce 00           |                   NOP
0xb5cf 00           |                   NOP
0xb5d0 00           |                   NOP
0xb5d1 00           |                   NOP
0xb5d2 00           |                   NOP
0xb5d3 00           |                   NOP
0xb5d4 00           |                   NOP
0xb5d5 C8           |                   RET Z
0xb5d6 52           |                   LD D,D
0xb5d7 66           |                   LD H,(HL)
0xb5d8 F2 4C 44     |                   JP P,$444C
0xb5db 20 53        |                   JR NZ,$53
0xb5dd 50           |                   LD D,B
0xb5de 2C           |                   INC L
0xb5df 48           |                   LD C,B
0xb5e0 4C           |                   LD C,H
0xb5e1 00           |                   NOP
0xb5e2 FF           |                   RST $38
0xb5e3 DD           |                   *ILLEGAL*
0xb5e4 F9           |                   LD SP,HL
0xb5e5 00           |                   NOP
0xb5e6 00           |                   NOP
0xb5e7 FF           |                   RST $38
0xb5e8 AA           |                   XOR D
0xb5e9 CC BB EE     |                   CALL Z,$EEBB
0xb5ec DD           |                   *ILLEGAL*
0xb5ed 11 44 88     |                   LD DE,$8844
0xb5f0 DD 77 FD     |                   LD (IX+$FD),A
0xb5f3 34           |                   INC (HL)
0xb5f4 12           |                   LD (DE),A
0xb5f5 00           |                   NOP
0xb5f6 C0           |                   RET NZ
0xb5f7 20 00        |                   JR NZ,$00
0xb5f9 00           |                   NOP
0xb5fa 00           |                   NOP
0xb5fb 00           |                   NOP
0xb5fc 00           |                   NOP
0xb5fd 00           |                   NOP
0xb5fe 00           |                   NOP
0xb5ff 00           |                   NOP
0xb600 00           |                   NOP
0xb601 00           |                   NOP
0xb602 00           |                   NOP
0xb603 00           |                   NOP
0xb604 00           |                   NOP
0xb605 00           |                   NOP
0xb606 00           |                   NOP
0xb607 00           |                   NOP
0xb608 00           |                   NOP
0xb609 00           |                   NOP
0xb60a 00           |                   NOP
0xb60b 00           |                   NOP
0xb60c 00           |                   NOP
0xb60d 00           |                   NOP
0xb60e 00           |                   NOP
0xb60f FF           |                   RST $38
0xb610 00           |                   NOP
0xb611 00           |                   NOP
0xb612 00           |                   NOP
0xb613 00           |                   NOP
0xb614 00           |                   NOP
0xb615 00           |                   NOP
0xb616 00           |                   NOP
0xb617 01 80 01     |                   LD BC,$0180
0xb61a 80           |                   AA,B
0xb61b 00           |                   NOP
0xb61c 00           |                   NOP
0xb61d 00           |                   NOP
0xb61e 00           |                   NOP
0xb61f 98           |                   SBC A,B
0xb620 2E 8C        |                   LD L,$8C
0xb622 00           |                   NOP
0xb623 4C           |                   LD C,H
0xb624 44           |                   LD B,H
0xb625 20 53        |                   JR NZ,$53
0xb627 50           |                   LD D,B
0xb628 2C           |                   INC L
0xb629 58           |                   LD E,B
0xb62a 59           |                   LD E,C
0xb62b 00           |                   NOP
0xb62c FF           |                   RST $38
0xb62d ED 47        |                   LD I,A
0xb62f 00           |                   NOP
0xb630 00           |                   NOP
0xb631 FF           |                   RST $38
0xb632 AA           |                   XOR D
0xb633 CC BB EE     |                   CALL Z,$EEBB
0xb636 DD           |                   *ILLEGAL*
0xb637 11 44 88     |                   LD DE,$8844
0xb63a DD 77 FD     |                   LD (IX+$FD),A
0xb63d 34           |                   INC (HL)
0xb63e 12           |                   LD (DE),A
0xb63f 00           |                   NOP
0xb640 C0           |                   RET NZ
0xb641 00           |                   NOP
0xb642 00           |                   NOP
0xb643 00           |                   NOP
0xb644 00           |                   NOP
0xb645 00           |                   NOP
0xb646 FF           |                   RST $38
0xb647 00           |                   NOP
0xb648 00           |                   NOP
0xb649 00           |                   NOP
0xb64a 00           |                   NOP
0xb64b 00           |                   NOP
0xb64c 00           |                   NOP
0xb64d 00           |                   NOP
0xb64e 00           |                   NOP
0xb64f 00           |                   NOP
0xb650 00           |                   NOP
0xb651 00           |                   NOP
0xb652 00           |                   NOP
0xb653 00           |                   NOP
0xb654 00           |                   NOP
0xb655 00           |                   NOP
0xb656 00           |                   NOP
0xb657 00           |                   NOP
0xb658 00           |                   NOP
0xb659 FF           |                   RST $38
0xb65a 00           |                   NOP
0xb65b 00           |                   NOP
0xb65c 00           |                   NOP
0xb65d 00           |                   NOP
0xb65e 00           |                   NOP
0xb65f 00           |                   NOP
0xb660 00           |                   NOP
0xb661 00           |                   NOP
0xb662 00           |                   NOP
0xb663 00           |                   NOP
0xb664 00           |                   NOP
0xb665 00           |                   NOP
0xb666 00           |                   NOP
0xb667 00           |                   NOP
0xb668 00           |                   NOP
0xb669 FA AF A4     |                   JP M,$A4AF
0xb66c D0           |                   RET NC
0xb66d 4C           |                   LD C,H
0xb66e 44           |                   LD B,H
0xb66f 20 49        |                   JR NZ,$49
0xb671 2C           |                   INC L
0xb672 41           |                   LD B,C
0xb673 00           |                   NOP
0xb674 FF           |                   RST $38
0xb675 ED 4F        |                   LD R,A
0xb677 00           |                   NOP
0xb678 00           |                   NOP
0xb679 FF           |                   RST $38
0xb67a AA           |                   XOR D
0xb67b CC BB EE     |                   CALL Z,$EEBB
0xb67e DD           |                   *ILLEGAL*
0xb67f 11 44 88     |                   LD DE,$8844
0xb682 DD 77 FD     |                   LD (IX+$FD),A
0xb685 34           |                   INC (HL)
0xb686 12           |                   LD (DE),A
0xb687 00           |                   NOP
0xb688 C0           |                   RET NZ
0xb689 00           |                   NOP
0xb68a 00           |                   NOP
0xb68b 00           |                   NOP
0xb68c 00           |                   NOP
0xb68d 00           |                   NOP
0xb68e FF           |                   RST $38
0xb68f 00           |                   NOP
0xb690 00           |                   NOP
0xb691 00           |                   NOP
0xb692 00           |                   NOP
0xb693 00           |                   NOP
0xb694 00           |                   NOP
0xb695 00           |                   NOP
0xb696 00           |                   NOP
0xb697 00           |                   NOP
0xb698 00           |                   NOP
0xb699 00           |                   NOP
0xb69a 00           |                   NOP
0xb69b 00           |                   NOP
0xb69c 00           |                   NOP
0xb69d 00           |                   NOP
0xb69e 00           |                   NOP
0xb69f 00           |                   NOP
0xb6a0 00           |                   NOP
0xb6a1 FF           |                   RST $38
0xb6a2 00           |                   NOP
0xb6a3 00           |                   NOP
0xb6a4 00           |                   NOP
0xb6a5 00           |                   NOP
0xb6a6 00           |                   NOP
0xb6a7 00           |                   NOP
0xb6a8 00           |                   NOP
0xb6a9 00           |                   NOP
0xb6aa 00           |                   NOP
0xb6ab 00           |                   NOP
0xb6ac 00           |                   NOP
0xb6ad 00           |                   NOP
0xb6ae 00           |                   NOP
0xb6af 00           |                   NOP
0xb6b0 00           |                   NOP
0xb6b1 FA AF A4     |                   JP M,$A4AF
0xb6b4 D0           |                   RET NC
0xb6b5 4C           |                   LD C,H
0xb6b6 44           |                   LD B,H
0xb6b7 20 52        |                   JR NZ,$52
0xb6b9 2C           |                   INC L
0xb6ba 41           |                   LD B,C
0xb6bb 00           |                   NOP
0xb6bc FF           |                   RST $38
0xb6bd ED 47        |                   LD I,A
0xb6bf ED 57        |                   LD A,I
0xb6c1 FF           |                   RST $38
0xb6c2 AA           |                   XOR D
0xb6c3 CC BB EE     |                   CALL Z,$EEBB
0xb6c6 DD           |                   *ILLEGAL*
0xb6c7 11 44 88     |                   LD DE,$8844
0xb6ca DD 77 FD     |                   LD (IX+$FD),A
0xb6cd 34           |                   INC (HL)
0xb6ce 12           |                   LD (DE),A
0xb6cf 00           |                   NOP
0xb6d0 C0           |                   RET NZ
0xb6d1 00           |                   NOP
0xb6d2 00           |                   NOP
0xb6d3 00           |                   NOP
0xb6d4 00           |                   NOP
0xb6d5 00           |                   NOP
0xb6d6 FF           |                   RST $38
0xb6d7 00           |                   NOP
0xb6d8 00           |                   NOP
0xb6d9 00           |                   NOP
0xb6da 00           |                   NOP
0xb6db 00           |                   NOP
0xb6dc 00           |                   NOP
0xb6dd 00           |                   NOP
0xb6de 00           |                   NOP
0xb6df 00           |                   NOP
0xb6e0 00           |                   NOP
0xb6e1 00           |                   NOP
0xb6e2 00           |                   NOP
0xb6e3 00           |                   NOP
0xb6e4 00           |                   NOP
0xb6e5 00           |                   NOP
0xb6e6 00           |                   NOP
0xb6e7 00           |                   NOP
0xb6e8 00           |                   NOP
0xb6e9 FF           |                   RST $38
0xb6ea 00           |                   NOP
0xb6eb 00           |                   NOP
0xb6ec 00           |                   NOP
0xb6ed 00           |                   NOP
0xb6ee 00           |                   NOP
0xb6ef 00           |                   NOP
0xb6f0 00           |                   NOP
0xb6f1 00           |                   NOP
0xb6f2 00           |                   NOP
0xb6f3 00           |                   NOP
0xb6f4 00           |                   NOP
0xb6f5 00           |                   NOP
0xb6f6 00           |                   NOP
0xb6f7 00           |                   NOP
0xb6f8 00           |                   NOP
0xb6f9 41           |                   LD B,C
0xb6fa C6 35        |                   ADD A,$35
0xb6fc 9B           |                   SBC A,E
0xb6fd 4C           |                   LD C,H
0xb6fe 44           |                   LD B,H
0xb6ff 20 41        |                   JR NZ,$41
0xb701 2C           |                   INC L
0xb702 49           |                   LD C,C
0xb703 00           |                   NOP
0xb704 FF           |                   RST $38
0xb705 ED 4F        |                   LD R,A
0xb707 ED 5F        |                   LD A,R
0xb709 FF           |                   RST $38
0xb70a AA           |                   XOR D
0xb70b CC BB EE     |                   CALL Z,$EEBB
0xb70e DD           |                   *ILLEGAL*
0xb70f 11 44 88     |                   LD DE,$8844
0xb712 DD 77 FD     |                   LD (IX+$FD),A
0xb715 34           |                   INC (HL)
0xb716 12           |                   LD (DE),A
0xb717 00           |                   NOP
0xb718 C0           |                   RET NZ
0xb719 00           |                   NOP
0xb71a 00           |                   NOP
0xb71b 00           |                   NOP
0xb71c 00           |                   NOP
0xb71d 00           |                   NOP
0xb71e FF           |                   RST $38
0xb71f 00           |                   NOP
0xb720 00           |                   NOP
0xb721 00           |                   NOP
0xb722 00           |                   NOP
0xb723 00           |                   NOP
0xb724 00           |                   NOP
0xb725 00           |                   NOP
0xb726 00           |                   NOP
0xb727 00           |                   NOP
0xb728 00           |                   NOP
0xb729 00           |                   NOP
0xb72a 00           |                   NOP
0xb72b 00           |                   NOP
0xb72c 00           |                   NOP
0xb72d 00           |                   NOP
0xb72e 00           |                   NOP
0xb72f 00           |                   NOP
0xb730 00           |                   NOP
0xb731 FF           |                   RST $38
0xb732 00           |                   NOP
0xb733 00           |                   NOP
0xb734 00           |                   NOP
0xb735 00           |                   NOP
0xb736 00           |                   NOP
0xb737 00           |                   NOP
0xb738 00           |                   NOP
0xb739 00           |                   NOP
0xb73a 00           |                   NOP
0xb73b 00           |                   NOP
0xb73c 00           |                   NOP
0xb73d 00           |                   NOP
0xb73e 00           |                   NOP
0xb73f 00           |                   NOP
0xb740 00           |                   NOP
0xb741 E3           |                   EX (SP),HL
0xb742 B3           |                   OR E
0xb743 D4 37 4C     |                   CALL NC,$4C37
0xb746 44           |                   LD B,H
0xb747 20 41        |                   JR NZ,$41
0xb749 2C           |                   INC L
0xb74a 52           |                   LD D,D
0xb74b 00           |                   NOP
0xb74c FF           |                   RST $38
0xb74d FB           |                   EI
0xb74e F3           |                   DI
0xb74f 00           |                   NOP
0xb750 00           |                   NOP
0xb751 FF           |                   RST $38
0xb752 AA           |                   XOR D
0xb753 CC BB EE     |                   CALL Z,$EEBB
0xb756 DD           |                   *ILLEGAL*
0xb757 11 44 88     |                   LD DE,$8844
0xb75a DD 77 FD     |                   LD (IX+$FD),A
0xb75d 34           |                   INC (HL)
0xb75e 12           |                   LD (DE),A
0xb75f 00           |                   NOP
0xb760 C0           |                   RET NZ
0xb761 00           |                   NOP
0xb762 00           |                   NOP
0xb763 00           |                   NOP
0xb764 00           |                   NOP
0xb765 00           |                   NOP
0xb766 00           |                   NOP
0xb767 00           |                   NOP
0xb768 00           |                   NOP
0xb769 00           |                   NOP
0xb76a 00           |                   NOP
0xb76b 00           |                   NOP
0xb76c 00           |                   NOP
0xb76d 00           |                   NOP
0xb76e 00           |                   NOP
0xb76f 00           |                   NOP
0xb770 00           |                   NOP
0xb771 00           |                   NOP
0xb772 00           |                   NOP
0xb773 00           |                   NOP
0xb774 00           |                   NOP
0xb775 00           |                   NOP
0xb776 00           |                   NOP
0xb777 00           |                   NOP
0xb778 00           |                   NOP
0xb779 FF           |                   RST $38
0xb77a 00           |                   NOP
0xb77b 00           |                   NOP
0xb77c 00           |                   NOP
0xb77d 00           |                   NOP
0xb77e 00           |                   NOP
0xb77f 00           |                   NOP
0xb780 00           |                   NOP
0xb781 00           |                   NOP
0xb782 00           |                   NOP
0xb783 00           |                   NOP
0xb784 00           |                   NOP
0xb785 00           |                   NOP
0xb786 00           |                   NOP
0xb787 00           |                   NOP
0xb788 00           |                   NOP
0xb789 31 08 B1     |                   LD SP,$B108
0xb78c A3           |                   AND E
0xb78d 45           |                   LD B,L
0xb78e 49           |                   LD C,C
0xb78f 2B           |                   DEC HL
0xb790 44           |                   LD B,H
0xb791 49           |                   LD C,C
0xb792 00           |                   NOP
0xb793 FF           |                   RST $38
0xb794 ED 46        |                   IM 0
0xb796 00           |                   NOP
0xb797 00           |                   NOP
0xb798 FF           |                   RST $38
0xb799 AA           |                   XOR D
0xb79a CC BB EE     |                   CALL Z,$EEBB
0xb79d DD           |                   *ILLEGAL*
0xb79e 11 44 88     |                   LD DE,$8844
0xb7a1 DD 77 FD     |                   LD (IX+$FD),A
0xb7a4 34           |                   INC (HL)
0xb7a5 12           |                   LD (DE),A
0xb7a6 00           |                   NOP
0xb7a7 C0           |                   RET NZ
0xb7a8 00           |                   NOP
0xb7a9 38 00        |                   JR C,$00
0xb7ab 00           |                   NOP
0xb7ac 00           |                   NOP
0xb7ad 00           |                   NOP
0xb7ae 00           |                   NOP
0xb7af 00           |                   NOP
0xb7b0 00           |                   NOP
0xb7b1 00           |                   NOP
0xb7b2 00           |                   NOP
0xb7b3 00           |                   NOP
0xb7b4 00           |                   NOP
0xb7b5 00           |                   NOP
0xb7b6 00           |                   NOP
0xb7b7 00           |                   NOP
0xb7b8 00           |                   NOP
0xb7b9 00           |                   NOP
0xb7ba 00           |                   NOP
0xb7bb 00           |                   NOP
0xb7bc 00           |                   NOP
0xb7bd 00           |                   NOP
0xb7be 00           |                   NOP
0xb7bf 00           |                   NOP
0xb7c0 FF           |                   RST $38
0xb7c1 00           |                   NOP
0xb7c2 00           |                   NOP
0xb7c3 00           |                   NOP
0xb7c4 00           |                   NOP
0xb7c5 00           |                   NOP
0xb7c6 00           |                   NOP
0xb7c7 00           |                   NOP
0xb7c8 00           |                   NOP
0xb7c9 00           |                   NOP
0xb7ca 00           |                   NOP
0xb7cb 00           |                   NOP
0xb7cc 00           |                   NOP
0xb7cd 00           |                   NOP
0xb7ce 00           |                   NOP
0xb7cf 00           |                   NOP
0xb7d0 44           |                   LD B,H
0xb7d1 05           |                   DEC B
0xb7d2 6D           |                   LD L,L
0xb7d3 8C           |                   ADC A,H
0xb7d4 49           |                   LD C,C
0xb7d5 4D           |                   LD C,L
0xb7d6 20 4E        |                   JR NZ,$4E
0xb7d8 00           |                   NOP
0xb7d9 FF           |                   RST $38
