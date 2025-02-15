
                              org 8000h

8000 F3           |           DI
8001 FD E5        |           PUSH IY
8003 D9           |           EXX
8004 E5           |           PUSH HL
8005 CD 5A 81     |           CALL 815Ah
8008 CD 5F 81     |           CALL 815Fh
800B 5A           |           LD E,D
800C 38 30        |           JR C,803Eh
800E 20 43        |           JR NZ,8053h
8010 43           |           LD B,E
8011 46           |           LD B,(HL)
8012 20 74        |           JR NZ,8088h
8014 65           |           LD H,L
8015 73           |           LD (HL),E
8016 74           |           LD (HL),H
8017 17           |           RLA
8018 13           |           INC DE
8019 01 7F 20     |           LD BC,207Fh
801C 32 30 31     |           LD (3130h),A
801F 32 20 52     |           LD (5220h),A
8022 41           |           LD B,C
8023 58           |           LD E,B
8024 4F           |           LD C,A
8025 46           |           LD B,(HL)
8026 54           |           LD D,H
8027 0D           |           DEC C
8028 0D           |           DEC C
8029 00           |           NOP
802A 01 00 00     |           LD BC,0000h
802D 21 7F 88     |           LD HL,887Fh
8030 18 0A        |           JR 803Ch
8032 E5           |           PUSH HL
8033 C5           |           PUSH BC
8034 CD 95 80     |           CALL 8095h
8037 C1           |           POP BC
8038 E1           |           POP HL
8039 80           |           ADD A,B
803A 47           |           LD B,A
803B 0C           |           INC C
803C 5E           |           LD E,(HL)
803D 23           |           INC HL
803E 56           |           LD D,(HL)
803F 23           |           INC HL
8040 7A           |           LD A,D
8041 B3           |           OR E
8042 20 EE        |           JR NZ,8032h
8044 CD 5F 81     |           CALL 815Fh
8047 0D           |           DEC C
8048 52           |           LD D,D
8049 65           |           LD H,L
804A 73           |           LD (HL),E
804B 75           |           LD (HL),L
804C 6C           |           LD L,H
804D 74           |           LD (HL),H
804E 3A 20 00     |           LD A,(0020h)
8051 78           |           LD A,B
8052 B7           |           OR A
8053 28 24        |           JR Z,8079h
8055 CD 6E 81     |           CALL 816Eh
8058 CD 5F 81     |           CALL 815Fh
805B 20 6F        |           JR NZ,80CCh
805D 66           |           LD H,(HL)
805E 20 00        |           JR NZ,8060h
8060 79           |           LD A,C
8061 CD 6E 81     |           CALL 816Eh
8064 CD 5F 81     |           CALL 815Fh
8067 20 74        |           JR NZ,80DDh
8069 65           |           LD H,L
806A 73           |           LD (HL),E
806B 74           |           LD (HL),H
806C 73           |           LD (HL),E
806D 20 66        |           JR NZ,80D5h
806F 61           |           LD H,C
8070 69           |           LD L,C
8071 6C           |           LD L,H
8072 65           |           LD H,L
8073 64           |           LD H,H
8074 2E 0D        |           LD L,0Dh
8076 00           |           NOP
8077 18 16        |           JR 808Fh
8079 CD 5F 81     |           CALL 815Fh
807C 61           |           LD H,C
807D 6C           |           LD L,H
807E 6C           |           LD L,H
807F 20 74        |           JR NZ,80F5h
8081 65           |           LD H,L
8082 73           |           LD (HL),E
8083 74           |           LD (HL),H
8084 73           |           LD (HL),E
8085 20 70        |           JR NZ,80F7h
8087 61           |           LD H,C
8088 73           |           LD (HL),E
8089 73           |           LD (HL),E
808A 65           |           LD H,L
808B 64           |           LD H,H
808C 2E 0D        |           LD L,0Dh
808E 00           |           NOP
808F E1           |           POP HL
8090 D9           |           EXX
8091 FD E1        |           POP IY
8093 FB           |           EI
8094 C9           |           RET
8095 C5           |           PUSH BC
8096 79           |           LD A,C
8097 CD 6E 81     |           CALL 816Eh
809A 3E 20        |           LD A,20h
809C CD A1 81     |           CALL 81A1h
809F 21 44 00     |           LD HL,0044h
80A2 19           |           ADD HL,DE
80A3 CD 65 81     |           CALL 8165h
80A6 C1           |           POP BC
80A7 7E           |           LD A,(HL)
80A8 FE 01        |           CP 01h
80AA 28 15        |           JR Z,80C1h
80AC 30 48        |           JR NC,80F6h
80AE B0           |           OR B
80AF 20 45        |           JR NZ,80F6h
80B1 CD 5F 81     |           CALL 815Fh
80B4 17           |           RLA
80B5 19           |           ADD HL,DE
80B6 01 53 6B     |           LD BC,6B53h
80B9 69           |           LD L,C
80BA 70           |           LD (HL),B
80BB 70           |           LD (HL),B
80BC 65           |           LD H,L
80BD 64           |           LD H,H
80BE 0D           |           DEC C
80BF 00           |           NOP
80C0 C9           |           RET
80C1 AF           |           XOR A
80C2 DB FE        |           IN A,(FEh)
80C4 FE BF        |           CP BFh
80C6 28 2E        |           JR Z,80F6h
80C8 5F           |           LD E,A
80C9 CD 5F 81     |           CALL 815Fh
80CC 17           |           RLA
80CD 1A           |           LD A,(DE)
80CE 01 46 41     |           LD BC,4146h
80D1 49           |           LD C,C
80D2 4C           |           LD C,H
80D3 45           |           LD B,L
80D4 44           |           LD B,H
80D5 0D           |           DEC C
80D6 49           |           LD C,C
80D7 4E           |           LD C,(HL)
80D8 20 46        |           JR NZ,8120h
80DA 45           |           LD B,L
80DB 3A 00 7B     |           LD A,(7B00h)
80DE CD 91 81     |           CALL 8191h
80E1 CD 5F 81     |           CALL 815Fh
80E4 17           |           RLA
80E5 15           |           DEC D
80E6 01 45 78     |           LD BC,7845h
80E9 70           |           LD (HL),B
80EA 65           |           LD H,L
80EB 63           |           LD H,E
80EC 74           |           LD (HL),H
80ED 65           |           LD H,L
80EE 64           |           LD H,H
80EF 3A 42 46     |           LD A,(4642h)
80F2 0D           |           DEC C
80F3 00           |           NOP
80F4 3C           |           INC A
80F5 C9           |           RET
80F6 21 40 00     |           LD HL,0040h
80F9 19           |           ADD HL,DE
80FA E5           |           PUSH HL
80FB EB           |           EX DE,HL
80FC CD 00 82     |           CALL 8200h
80FF 21 03 88     |           LD HL,8803h
8102 73           |           LD (HL),E
8103 2B           |           DEC HL
8104 72           |           LD (HL),D
8105 2B           |           DEC HL
8106 71           |           LD (HL),C
8107 2B           |           DEC HL
8108 70           |           LD (HL),B
8109 D1           |           POP DE
810A 06 04        |           LD B,04h
810C CD 4D 81     |           CALL 814Dh
810F 20 0B        |           JR NZ,811Ch
8111 CD 5F 81     |           CALL 815Fh
8114 17           |           RLA
8115 1E 01        |           LD E,01h
8117 4F           |           LD C,A
8118 4B           |           LD C,E
8119 0D           |           DEC C
811A 00           |           NOP
811B C9           |           RET
811C CD 5F 81     |           CALL 815Fh
811F 17           |           RLA
8120 1A           |           LD A,(DE)
8121 01 46 41     |           LD BC,4146h
8124 49           |           LD C,C
8125 4C           |           LD C,H
8126 45           |           LD B,L
8127 44           |           LD B,H
8128 0D           |           DEC C
8129 43           |           LD B,E
812A 52           |           LD D,D
812B 43           |           LD B,E
812C 3A 00 CD     |           LD A,(CD00h)
812F 87           |           ADD A,A
8130 81           |           ADD A,C
8131 CD 5F 81     |           CALL 815Fh
8134 20 20        |           JR NZ,8156h
8136 20 45        |           JR NZ,817Dh
8138 78           |           LD A,B
8139 70           |           LD (HL),B
813A 65           |           LD H,L
813B 63           |           LD H,E
813C 74           |           LD (HL),H
813D 65           |           LD H,L
813E 64           |           LD H,H
813F 3A 00 EB     |           LD A,(EB00h)
8142 CD 87 81     |           CALL 8187h
8145 3E 0D        |           LD A,0Dh
8147 CD A1 81     |           CALL 81A1h
814A 3E 01        |           LD A,01h
814C C9           |           RET
814D E5           |           PUSH HL
814E D5           |           PUSH DE
814F 1A           |           LD A,(DE)
8150 AE           |           XOR (HL)
8151 20 04        |           JR NZ,8157h
8153 13           |           INC DE
8154 23           |           INC HL
8155 10 F8        |           DJNZ 814Fh
8157 D1           |           POP DE
8158 E1           |           POP HL
8159 C9           |           RET
815A 3E 02        |           LD A,02h
815C C3 01 16     |           JP 1601h
815F E3           |           EX (SP),HL
8160 CD 65 81     |           CALL 8165h
8163 E3           |           EX (SP),HL
8164 C9           |           RET
8165 7E           |           LD A,(HL)
8166 23           |           INC HL
8167 B7           |           OR A
8168 C8           |           RET Z
8169 CD A1 81     |           CALL 81A1h
816C 18 F7        |           JR 8165h
816E 67           |           LD H,A
816F 06 9C        |           LD B,9Ch
8171 CD 7B 81     |           CALL 817Bh
8174 06 F6        |           LD B,F6h
8176 CD 7B 81     |           CALL 817Bh
8179 06 FF        |           LD B,FFh
817B 7C           |           LD A,H
817C 2E 2F        |           LD L,2Fh
817E 2C           |           INC L
817F 80           |           ADD A,B
8180 38 FC        |           JR C,817Eh
8182 90           |           SUB A,B
8183 67           |           LD H,A
8184 7D           |           LD A,L
8185 18 1A        |           JR 81A1h
8187 06 04        |           LD B,04h
8189 7E           |           LD A,(HL)
818A 23           |           INC HL
818B CD 91 81     |           CALL 8191h
818E 10 F9        |           DJNZ 8189h
8190 C9           |           RET
8191 F5           |           PUSH AF
8192 0F           |           RRCA
8193 0F           |           RRCA
8194 0F           |           RRCA
8195 0F           |           RRCA
8196 CD 9A 81     |           CALL 819Ah
8199 F1           |           POP AF
819A F6 F0        |           OR F0h
819C 27           |           DAA
819D C6 A0        |           ADD A,A0h
819F CE 40        |           ADC A,40h
81A1 FD E5        |           PUSH IY
81A3 FD 21 3A 5C  |           LD IY,5C3Ah
81A7 D5           |           PUSH DE
81A8 C5           |           PUSH BC
81A9 D9           |           EXX
81AA FB           |           EI
81AB D7           |           RST $10
81AC F3           |           DI
81AD D9           |           EXX
81AE C1           |           POP BC
81AF D1           |           POP DE
81B0 FD E1        |           POP IY
81B2 C9           |           RET
81B3 00           |           NOP
81B4 00           |           NOP
81B5 00           |           NOP
81B6 00           |           NOP
81B7 00           |           NOP
81B8 00           |           NOP
81B9 00           |           NOP
81BA 00           |           NOP
81BB 00           |           NOP
81BC 00           |           NOP
81BD 00           |           NOP
81BE 00           |           NOP
81BF 00           |           NOP
81C0 00           |           NOP
81C1 00           |           NOP
81C2 00           |           NOP
81C3 00           |           NOP
81C4 00           |           NOP
81C5 00           |           NOP
81C6 00           |           NOP
81C7 00           |           NOP
81C8 00           |           NOP
81C9 00           |           NOP
81CA 00           |           NOP
81CB 00           |           NOP
81CC 00           |           NOP
81CD 00           |           NOP
81CE 00           |           NOP
81CF 00           |           NOP
81D0 00           |           NOP
81D1 00           |           NOP
81D2 00           |           NOP
81D3 00           |           NOP
81D4 00           |           NOP
81D5 00           |           NOP
81D6 00           |           NOP
81D7 00           |           NOP
81D8 00           |           NOP
81D9 00           |           NOP
81DA 00           |           NOP
81DB 00           |           NOP
81DC 00           |           NOP
81DD 00           |           NOP
81DE 00           |           NOP
81DF 00           |           NOP
81E0 00           |           NOP
81E1 00           |           NOP
81E2 00           |           NOP
81E3 00           |           NOP
81E4 00           |           NOP
81E5 00           |           NOP
81E6 00           |           NOP
81E7 00           |           NOP
81E8 00           |           NOP
81E9 00           |           NOP
81EA 00           |           NOP
81EB 00           |           NOP
81EC 00           |           NOP
81ED 00           |           NOP
81EE 00           |           NOP
81EF 00           |           NOP
81F0 00           |           NOP
81F1 00           |           NOP
81F2 00           |           NOP
81F3 00           |           NOP
81F4 00           |           NOP
81F5 00           |           NOP
81F6 00           |           NOP
81F7 00           |           NOP
81F8 00           |           NOP
81F9 00           |           NOP
81FA 00           |           NOP
81FB 00           |           NOP
81FC 00           |           NOP
81FD 00           |           NOP
81FE 00           |           NOP
81FF 00           |           NOP
8200 ED 73 A3 83  |           LD (83A3h),SP
8204 23           |           INC HL
8205 11 14 88     |           LD DE,8814h
8208 01 15 00     |           LD BC,0015h
820B CD A6 83     |           CALL 83A6h
820E 09           |           ADD HL,BC
820F CD A6 83     |           CALL 83A6h
8212 CD A6 83     |           CALL 83A6h
8215 09           |           ADD HL,BC
8216 ED 53 7C 83  |           LD (837Ch),DE
821A 13           |           INC DE
821B CD AD 83     |           CALL 83ADh
821E ED 53 79 83  |           LD (8379h),DE
8222 AF           |           XOR A
8223 12           |           LD (DE),A
8224 13           |           INC DE
8225 CD A6 83     |           CALL 83A6h
8228 3E 07        |           LD A,07h
822A D3 FE        |           OUT (FEh),A
822C 3E A9        |           LD A,A9h
822E ED 47        |           LD I,A
8230 ED 4F        |           LD R,A
8232 B7           |           OR A
8233 08           |           EX AF,AF'
8234 01 FF FF     |           LD BC,FFFFh
8237 50           |           LD D,B
8238 59           |           LD E,C
8239 D9           |           EXX
823A 31 00 88     |           LD SP,8800h
823D 21 29 88     |           LD HL,8829h
8240 11 54 88     |           LD DE,8854h
8243 01 14 88     |           LD BC,8814h
8246 0A           |           LD A,(BC)
8247 AE           |           XOR (HL)
8248 EB           |           EX DE,HL
8249 AE           |           XOR (HL)
824A FE 76        |           CP 76h
824C CA 60 83     |           JP Z,8360h
824F 32 35 83     |           LD (8335h),A
8252 0C           |           INC C
8253 1C           |           INC E
8254 2C           |           INC L
8255 0A           |           LD A,(BC)
8256 AE           |           XOR (HL)
8257 EB           |           EX DE,HL
8258 AE           |           XOR (HL)
8259 32 36 83     |           LD (8336h),A
825C FE 76        |           CP 76h
825E C2 6B 82     |           JP NZ,826Bh
8261 3A 35 83     |           LD A,(8335h)
8264 E6 DF        |           AND DFh
8266 FE DD        |           CP DDh
8268 CA 60 83     |           JP Z,8360h
826B 0C           |           INC C
826C 1C           |           INC E
826D 2C           |           INC L
826E 0A           |           LD A,(BC)
826F AE           |           XOR (HL)
8270 EB           |           EX DE,HL
8271 AE           |           XOR (HL)
8272 32 37 83     |           LD (8337h),A
8275 0C           |           INC C
8276 1C           |           INC E
8277 2C           |           INC L
8278 0A           |           LD A,(BC)
8279 AE           |           XOR (HL)
827A EB           |           EX DE,HL
827B AE           |           XOR (HL)
827C 32 38 83     |           LD (8338h),A
827F 0C           |           INC C
8280 1C           |           INC E
8281 2C           |           INC L
8282 0A           |           LD A,(BC)
8283 AE           |           XOR (HL)
8284 EB           |           EX DE,HL
8285 AE           |           XOR (HL)
8286 32 39 83     |           LD (8339h),A
8289 0C           |           INC C
828A 1C           |           INC E
828B 2C           |           INC L
828C 0A           |           LD A,(BC)
828D AE           |           XOR (HL)
828E EB           |           EX DE,HL
828F AE           |           XOR (HL)
8290 32 00 88     |           LD (8800h),A
8293 0C           |           INC C
8294 1C           |           INC E
8295 2C           |           INC L
8296 0A           |           LD A,(BC)
8297 AE           |           XOR (HL)
8298 EB           |           EX DE,HL
8299 AE           |           XOR (HL)
829A 32 01 88     |           LD (8801h),A
829D 0C           |           INC C
829E 1C           |           INC E
829F 2C           |           INC L
82A0 0A           |           LD A,(BC)
82A1 AE           |           XOR (HL)
82A2 EB           |           EX DE,HL
82A3 AE           |           XOR (HL)
82A4 32 02 88     |           LD (8802h),A
82A7 0C           |           INC C
82A8 1C           |           INC E
82A9 2C           |           INC L
82AA 0A           |           LD A,(BC)
82AB AE           |           XOR (HL)
82AC EB           |           EX DE,HL
82AD AE           |           XOR (HL)
82AE 32 03 88     |           LD (8803h),A
82B1 0C           |           INC C
82B2 1C           |           INC E
82B3 2C           |           INC L
82B4 0A           |           LD A,(BC)
82B5 AE           |           XOR (HL)
82B6 EB           |           EX DE,HL
82B7 AE           |           XOR (HL)
82B8 32 04 88     |           LD (8804h),A
82BB 0C           |           INC C
82BC 1C           |           INC E
82BD 2C           |           INC L
82BE 0A           |           LD A,(BC)
82BF AE           |           XOR (HL)
82C0 EB           |           EX DE,HL
82C1 AE           |           XOR (HL)
82C2 32 05 88     |           LD (8805h),A
82C5 0C           |           INC C
82C6 1C           |           INC E
82C7 2C           |           INC L
82C8 0A           |           LD A,(BC)
82C9 AE           |           XOR (HL)
82CA EB           |           EX DE,HL
82CB AE           |           XOR (HL)
82CC 32 06 88     |           LD (8806h),A
82CF 0C           |           INC C
82D0 1C           |           INC E
82D1 2C           |           INC L
82D2 0A           |           LD A,(BC)
82D3 AE           |           XOR (HL)
82D4 EB           |           EX DE,HL
82D5 AE           |           XOR (HL)
82D6 32 07 88     |           LD (8807h),A
82D9 0C           |           INC C
82DA 1C           |           INC E
82DB 2C           |           INC L
82DC 0A           |           LD A,(BC)
82DD AE           |           XOR (HL)
82DE EB           |           EX DE,HL
82DF AE           |           XOR (HL)
82E0 32 08 88     |           LD (8808h),A
82E3 0C           |           INC C
82E4 1C           |           INC E
82E5 2C           |           INC L
82E6 0A           |           LD A,(BC)
82E7 AE           |           XOR (HL)
82E8 EB           |           EX DE,HL
82E9 AE           |           XOR (HL)
82EA 32 09 88     |           LD (8809h),A
82ED 0C           |           INC C
82EE 1C           |           INC E
82EF 2C           |           INC L
82F0 0A           |           LD A,(BC)
82F1 AE           |           XOR (HL)
82F2 EB           |           EX DE,HL
82F3 AE           |           XOR (HL)
82F4 32 0A 88     |           LD (880Ah),A
82F7 0C           |           INC C
82F8 1C           |           INC E
82F9 2C           |           INC L
82FA 0A           |           LD A,(BC)
82FB AE           |           XOR (HL)
82FC EB           |           EX DE,HL
82FD AE           |           XOR (HL)
82FE 32 0B 88     |           LD (880Bh),A
8301 0C           |           INC C
8302 1C           |           INC E
8303 2C           |           INC L
8304 0A           |           LD A,(BC)
8305 AE           |           XOR (HL)
8306 EB           |           EX DE,HL
8307 AE           |           XOR (HL)
8308 32 0C 88     |           LD (880Ch),A
830B 0C           |           INC C
830C 1C           |           INC E
830D 2C           |           INC L
830E 0A           |           LD A,(BC)
830F AE           |           XOR (HL)
8310 EB           |           EX DE,HL
8311 AE           |           XOR (HL)
8312 32 0D 88     |           LD (880Dh),A
8315 0C           |           INC C
8316 1C           |           INC E
8317 2C           |           INC L
8318 0A           |           LD A,(BC)
8319 AE           |           XOR (HL)
831A EB           |           EX DE,HL
831B AE           |           XOR (HL)
831C 32 0E 88     |           LD (880Eh),A
831F 0C           |           INC C
8320 1C           |           INC E
8321 2C           |           INC L
8322 0A           |           LD A,(BC)
8323 AE           |           XOR (HL)
8324 EB           |           EX DE,HL
8325 AE           |           XOR (HL)
8326 32 0F 88     |           LD (880Fh),A
8329 F1           |           POP AF
832A C1           |           POP BC
832B D1           |           POP DE
832C E1           |           POP HL
832D DD E1        |           POP IX
832F FD E1        |           POP IY
8331 ED 7B 0E 88  |           LD SP,(880Eh)
8335 00           |           NOP
8336 00           |           NOP
8337 00           |           NOP
8338 00           |           NOP
8339 00           |           NOP
833A ED 73 0E 88  |           LD (880Eh),SP
833E 31 0C 88     |           LD SP,880Ch
8341 FD E5        |           PUSH IY
8343 DD E5        |           PUSH IX
8345 E5           |           PUSH HL
8346 D5           |           PUSH DE
8347 C5           |           PUSH BC
8348 F5           |           PUSH AF
8349 21 00 88     |           LD HL,8800h
834C 7E           |           LD A,(HL)
834D D9           |           EXX
834E AB           |           XOR E
834F 6F           |           LD L,A
8350 26 84        |           LD H,84h
8352 7E           |           LD A,(HL)
8353 AA           |           XOR D
8354 5F           |           LD E,A
8355 24           |           INC H
8356 7E           |           LD A,(HL)
8357 A9           |           XOR C
8358 57           |           LD D,A
8359 24           |           INC H
835A 7E           |           LD A,(HL)
835B A8           |           XOR B
835C 4F           |           LD C,A
835D 24           |           INC H
835E 46           |           LD B,(HL)
835F D9           |           EXX
8360 21 3E 88     |           LD HL,883Eh
8363 11 29 88     |           LD DE,8829h
8366 06 15        |           LD B,15h
8368 1A           |           LD A,(DE)
8369 B7           |           OR A
836A 28 06        |           JR Z,8372h
836C 3D           |           DEC A
836D A6           |           AND (HL)
836E 12           |           LD (DE),A
836F C3 3D 82     |           JP 823Dh
8372 7E           |           LD A,(HL)
8373 12           |           LD (DE),A
8374 2C           |           INC L
8375 1C           |           INC E
8376 10 F0        |           DJNZ 8368h

8378 21 69 88     |           LD HL,8869h
837B 11 53 88     |           LD DE,8853h
837E 1A           |           LD A,(DE)
837F 87           |           ADD A,A
8380 ED 44        |           NEG
8382 86           |           ADD A,(HL)
8383 AE           |           XOR (HL)
8384 A6           |           AND (HL)
8385 12           |           LD (DE),A
8386 C2 3D 82     |           JP NZ,823Dh
8389 2C           |           INC L
838A 1C           |           INC E
838B 7B           |           LD A,E
838C FE 69        |           CP 69h
838E 28 11        |           JR Z,83A1h
8390 7E           |           LD A,(HL)
8391 3D           |           DEC A
8392 AE           |           XOR (HL)
8393 A6           |           AND (HL)
8394 28 F3        |           JR Z,8389h
8396 12           |           LD (DE),A
8397 22 79 83     |           LD (8379h),HL
839A ED 53 7C 83  |           LD (837Ch),DE
839E C3 3D 82     |           JP 823Dh
83A1 D9           |           EXX
83A2 31 00 00     |           LD SP,0000h
83A5 C9           |           RET
83A6 E5           |           PUSH HL
83A7 C5           |           PUSH BC
83A8 ED B0        |           LDIR
83AA C1           |           POP BC
83AB E1           |           POP HL
83AC C9           |           RET
83AD E5           |           PUSH HL
83AE C5           |           PUSH BC
83AF 62           |           LD H,D
83B0 6B           |           LD L,E
83B1 36 00        |           LD (HL),00h
83B3 13           |           INC DE
83B4 0B           |           DEC BC
83B5 ED B0        |           LDIR
83B7 C1           |           POP BC
83B8 E1           |           POP HL
83B9 C9           |           RET
83BA 00           |           NOP
83BB 00           |           NOP
83BC 00           |           NOP
83BD 00           |           NOP
83BE 00           |           NOP
83BF 00           |           NOP
83C0 00           |           NOP
83C1 00           |           NOP
83C2 00           |           NOP
83C3 00           |           NOP
83C4 00           |           NOP
83C5 00           |           NOP
83C6 00           |           NOP
83C7 00           |           NOP
83C8 00           |           NOP
83C9 00           |           NOP
83CA 00           |           NOP
83CB 00           |           NOP
83CC 00           |           NOP
83CD 00           |           NOP
83CE 00           |           NOP
83CF 00           |           NOP
83D0 00           |           NOP
83D1 00           |           NOP
83D2 00           |           NOP
83D3 00           |           NOP
83D4 00           |           NOP
83D5 00           |           NOP
83D6 00           |           NOP
83D7 00           |           NOP
83D8 00           |           NOP
83D9 00           |           NOP
83DA 00           |           NOP
83DB 00           |           NOP
83DC 00           |           NOP
83DD 00           |           NOP
83DE 00           |           NOP
83DF 00           |           NOP
83E0 00           |           NOP
83E1 00           |           NOP
83E2 00           |           NOP
83E3 00           |           NOP
83E4 00           |           NOP
83E5 00           |           NOP
83E6 00           |           NOP
83E7 00           |           NOP
83E8 00           |           NOP
83E9 00           |           NOP
83EA 00           |           NOP
83EB 00           |           NOP
83EC 00           |           NOP
83ED 00           |           NOP
83EE 00           |           NOP
83EF 00           |           NOP
83F0 00           |           NOP
83F1 00           |           NOP
83F2 00           |           NOP
83F3 00           |           NOP
83F4 00           |           NOP
83F5 00           |           NOP
83F6 00           |           NOP
83F7 00           |           NOP
83F8 00           |           NOP
83F9 00           |           NOP
83FA 00           |           NOP
83FB 00           |           NOP
83FC 00           |           NOP
83FD 00           |           NOP
83FE 00           |           NOP
83FF 00           |           NOP
8400 00           |           NOP
8401 96           |           SUB A,(HL)
8402 2C           |           INC L
8403 BA           |           CP D
8404 19           |           ADD HL,DE
8405 8F           |           ADC A,A
8406 35           |           DEC (HL)
8407 A3           |           AND E
8408 32 A4 1E     |           LD (1EA4h),A
840B 88           |           ADC A,B
840C 2B           |           DEC HL
840D BD           |           CP L
840E 07           |           RLCA
840F 91           |           SUB A,C
8410 64           |           LD H,H
8411 F2 48 DE     |           JP P,DE48h
8414 7D           |           LD A,L
8415 EB           |           EX DE,HL
8416 51           |           LD D,C
8417 C7           |           RST $00
8418 56           |           LD D,(HL)
8419 C0           |           RET NZ
841A 7A           |           LD A,D
841B EC 4F D9     |           CALL P,D94Fh
841E 63           |           LD H,E
841F F5           |           PUSH AF
8420 C8           |           RET Z
8421 5E           |           LD E,(HL)
8422 E4 72 D1     |           CALL PO,D172h
8425 47           |           LD B,A
8426 FD 6B        |           LD IYL,E
8428 FA 6C D6     |           JP M,D66Ch
842B 40           |           LD B,B
842C E3           |           EX (SP),HL
842D 75           |           LD (HL),L
842E CF           |           RST $08
842F 59           |           LD E,C
8430 AC           |           XOR H
8431 3A 80 16     |           LD A,(1680h)
8434 B5           |           OR L
8435 23           |           INC HL
8436 99           |           SBC A,C
8437 0F           |           RRCA
8438 9E           |           SBC A,(HL)
8439 08           |           EX AF,AF'
843A B2           |           OR D
843B 24           |           INC H
843C 87           |           ADD A,A
843D 11 AB 3D     |           LD DE,3DABh
8440 90           |           SUB A,B
8441 06 BC        |           LD B,BCh
8443 2A 89 1F     |           LD HL,(1F89h)
8446 A5           |           AND L
8447 33           |           INC SP
8448 A2           |           AND D
8449 34           |           INC (HL)
844A 8E           |           ADC A,(HL)
844B 18 BB        |           JR 8408h
844D 2D           |           DEC L
844E 97           |           SUB A,A
844F 01 F4 62     |           LD BC,62F4h
8452 D8           |           RET C
8453 4E           |           LD C,(HL)
8454 ED 7B C1 57  |           LD SP,(57C1h)
8458 C6 50        |           ADD A,50h
845A EA 7C DF     |           JP PE,DF7Ch
845D 49           |           LD C,C
845E F3           |           DI
845F 65           |           LD H,L
8460 58           |           LD E,B
8461 CE 74        |           ADC A,74h
8463 E2 41 D7     |           JP PO,D741h
8466 6D           |           LD L,L
8467 FB           |           EI
8468 6A           |           LD L,D
8469 FC 46 D0     |           CALL M,D046h
846C 73           |           LD (HL),E
846D E5           |           PUSH HL
846E 5F           |           LD E,A
846F C9           |           RET
8470 3C           |           INC A
8471 AA           |           XOR D
8472 10 86        |           DJNZ 83FAh
8474 25           |           DEC H
8475 B3           |           OR E
8476 09           |           ADD HL,BC
8477 9F           |           SBC A,A
8478 0E 98        |           LD C,98h
847A 22 B4 17     |           LD (17B4h),HL
847D 81           |           ADD A,C
847E 3B           |           DEC SP
847F AD           |           XOR L
8480 20 B6        |           JR NZ,8438h
8482 0C           |           INC C
8483 9A           |           SBC A,D
8484 39           |           ADD HL,SP
8485 AF           |           XOR A
8486 15           |           DEC D
8487 83           |           ADD A,E
8488 12           |           LD (DE),A
8489 84           |           ADD A,H
848A 3E A8        |           LD A,A8h
848C 0B           |           DEC BC
848D 9D           |           SBC A,L
848E 27           |           DAA
848F B1           |           OR C
8490 44           |           LD B,H
8491 D2 68 FE     |           JP NC,FE68h
8494 5D           |           LD E,L
8495 CB 71        |           BIT 6,C
8497 E7           |           RST $20
8498 76           |           HALT
8499 E0           |           RET PO
849A 5A           |           LD E,D
849B CC 6F F9     |           CALL Z,F96Fh
849E 43           |           LD B,E
849F D5           |           PUSH DE
84A0 E8           |           RET PE
84A1 7E           |           LD A,(HL)
84A2 C4 52 F1     |           CALL NZ,F152h
84A5 67           |           LD H,A
84A6 DD           |           *ILLEGAL*
84A7 4B           |           LD C,E
84A8 DA 4C F6     |           JP C,F64Ch
84AB 60           |           LD H,B
84AC C3 55 EF     |           JP EF55h
84AF 79           |           LD A,C
84B0 8C           |           ADC A,H
84B1 1A           |           LD A,(DE)
84B2 A0           |           AND B
84B3 36 95        |           LD (HL),95h
84B5 03           |           INC BC
84B6 B9           |           CP C
84B7 2F           |           CPL
84B8 BE           |           CP (HL)
84B9 28 92        |           JR Z,844Dh
84BB 04           |           INC B
84BC A7           |           AND A
84BD 31 8B 1D     |           LD SP,1D8Bh
84C0 B0           |           OR B
84C1 26 9C        |           LD H,9Ch
84C3 0A           |           LD A,(BC)
84C4 A9           |           XOR C
84C5 3F           |           CCF
84C6 85           |           ADD A,L
84C7 13           |           INC DE
84C8 82           |           ADD A,D
84C9 14           |           INC D
84CA AE           |           XOR (HL)
84CB 38 9B        |           JR C,8468h
84CD 0D           |           DEC C
84CE B7           |           OR A
84CF 21 D4 42     |           LD HL,42D4h
84D2 F8           |           RET M
84D3 6E           |           LD L,(HL)
84D4 CD 5B E1     |           CALL E15Bh
84D7 77           |           LD (HL),A
84D8 E6 70        |           AND 70h
84DA CA 5C FF     |           JP Z,FF5Ch
84DD 69           |           LD L,C
84DE D3 45        |           OUT (45h),A
84E0 78           |           LD A,B
84E1 EE 54        |           XOR 54h
84E3 C2 61 F7     |           JP NZ,F761h
84E6 4D           |           LD C,L
84E7 DB 4A        |           IN A,(4Ah)
84E9 DC 66 F0     |           CALL C,F066h
84EC 53           |           LD D,E
84ED C5           |           PUSH BC
84EE 7F           |           LD A,A
84EF E9           |           JP (HL)
84F0 1C           |           INC E
84F1 8A           |           ADC A,D
84F2 30 A6        |           JR NC,849Ah
84F4 05           |           DEC B
84F5 93           |           SUB A,E
84F6 29           |           ADD HL,HL
84F7 BF           |           CP A
84F8 2E B8        |           LD L,B8h
84FA 02           |           LD (BC),A
84FB 94           |           SUB A,H
84FC 37           |           SCF
84FD A1           |           AND C
84FE 1B           |           DEC DE
84FF 8D           |           ADC A,L
8500 00           |           NOP
8501 30 61        |           JR NC,8564h
8503 51           |           LD D,C
8504 C4 F4 A5     |           CALL NZ,A5F4h
8507 95           |           SUB A,L
8508 88           |           ADC A,B
8509 B8           |           CP B
850A E9           |           JP (HL)
850B D9           |           EXX
850C 4C           |           LD C,H
850D 7C           |           LD A,H
850E 2D           |           DEC L
850F 1D           |           DEC E
8510 10 20        |           DJNZ 8532h
8512 71           |           LD (HL),C
8513 41           |           LD B,C
8514 D4 E4 B5     |           CALL NC,B5E4h
8517 85           |           ADD A,L
8518 98           |           SBC A,B
8519 A8           |           XOR B
851A F9           |           LD SP,HL
851B C9           |           RET
851C 5C           |           LD E,H
851D 6C           |           LD L,H
851E 3D           |           DEC A
851F 0D           |           DEC C
8520 20 10        |           JR NZ,8532h
8522 41           |           LD B,C
8523 71           |           LD (HL),C
8524 E4 D4 85     |           CALL PO,85D4h
8527 B5           |           OR L
8528 A8           |           XOR B
8529 98           |           SBC A,B
852A C9           |           RET
852B F9           |           LD SP,HL
852C 6C           |           LD L,H
852D 5C           |           LD E,H
852E 0D           |           DEC C
852F 3D           |           DEC A
8530 30 00        |           JR NC,8532h
8532 51           |           LD D,C
8533 61           |           LD H,C
8534 F4 C4 95     |           CALL P,95C4h
8537 A5           |           AND L
8538 B8           |           CP B
8539 88           |           ADC A,B
853A D9           |           EXX
853B E9           |           JP (HL)
853C 7C           |           LD A,H
853D 4C           |           LD C,H
853E 1D           |           DEC E
853F 2D           |           DEC L
8540 41           |           LD B,C
8541 71           |           LD (HL),C
8542 20 10        |           JR NZ,8554h
8544 85           |           ADD A,L
8545 B5           |           OR L
8546 E4 D4 C9     |           CALL PO,C9D4h
8549 F9           |           LD SP,HL
854A A8           |           XOR B
854B 98           |           SBC A,B
854C 0D           |           DEC C
854D 3D           |           DEC A
854E 6C           |           LD L,H
854F 5C           |           LD E,H
8550 51           |           LD D,C
8551 61           |           LD H,C
8552 30 00        |           JR NC,8554h
8554 95           |           SUB A,L
8555 A5           |           AND L
8556 F4 C4 D9     |           CALL P,D9C4h
8559 E9           |           JP (HL)
855A B8           |           CP B
855B 88           |           ADC A,B
855C 1D           |           DEC E
855D 2D           |           DEC L
855E 7C           |           LD A,H
855F 4C           |           LD C,H
8560 61           |           LD H,C
8561 51           |           LD D,C
8562 00           |           NOP
8563 30 A5        |           JR NC,850Ah
8565 95           |           SUB A,L
8566 C4 F4 E9     |           CALL NZ,E9F4h
8569 D9           |           EXX
856A 88           |           ADC A,B
856B B8           |           CP B
856C 2D           |           DEC L
856D 1D           |           DEC E
856E 4C           |           LD C,H
856F 7C           |           LD A,H
8570 71           |           LD (HL),C
8571 41           |           LD B,C
8572 10 20        |           DJNZ 8594h
8574 B5           |           OR L
8575 85           |           ADD A,L
8576 D4 E4 F9     |           CALL NC,F9E4h
8579 C9           |           RET
857A 98           |           SBC A,B
857B A8           |           XOR B
857C 3D           |           DEC A
857D 0D           |           DEC C
857E 5C           |           LD E,H
857F 6C           |           LD L,H
8580 83           |           ADD A,E
8581 B3           |           OR E
8582 E2 D2 47     |           JP PO,47D2h
8585 77           |           LD (HL),A
8586 26 16        |           LD H,16h
8588 0B           |           DEC BC
8589 3B           |           DEC SP
858A 6A           |           LD L,D
858B 5A           |           LD E,D
858C CF           |           RST $08
858D FF           |           RST $38
858E AE           |           XOR (HL)
858F 9E           |           SBC A,(HL)
8590 93           |           SUB A,E
8591 A3           |           AND E
8592 F2 C2 57     |           JP P,57C2h
8595 67           |           LD H,A
8596 36 06        |           LD (HL),06h
8598 1B           |           DEC DE
8599 2B           |           DEC HL
859A 7A           |           LD A,D
859B 4A           |           LD C,D
859C DF           |           RST $18
859D EF           |           RST $28
859E BE           |           CP (HL)
859F 8E           |           ADC A,(HL)
85A0 A3           |           AND E
85A1 93           |           SUB A,E
85A2 C2 F2 67     |           JP NZ,67F2h
85A5 57           |           LD D,A
85A6 06 36        |           LD B,36h
85A8 2B           |           DEC HL
85A9 1B           |           DEC DE
85AA 4A           |           LD C,D
85AB 7A           |           LD A,D
85AC EF           |           RST $28
85AD DF           |           RST $18
85AE 8E           |           ADC A,(HL)
85AF BE           |           CP (HL)
85B0 B3           |           OR E
85B1 83           |           ADD A,E
85B2 D2 E2 77     |           JP NC,77E2h
85B5 47           |           LD B,A
85B6 16 26        |           LD D,26h
85B8 3B           |           DEC SP
85B9 0B           |           DEC BC
85BA 5A           |           LD E,D
85BB 6A           |           LD L,D
85BC FF           |           RST $38
85BD CF           |           RST $08
85BE 9E           |           SBC A,(HL)
85BF AE           |           XOR (HL)
85C0 C2 F2 A3     |           JP NZ,A3F2h
85C3 93           |           SUB A,E
85C4 06 36        |           LD B,36h
85C6 67           |           LD H,A
85C7 57           |           LD D,A
85C8 4A           |           LD C,D
85C9 7A           |           LD A,D
85CA 2B           |           DEC HL
85CB 1B           |           DEC DE
85CC 8E           |           ADC A,(HL)
85CD BE           |           CP (HL)
85CE EF           |           RST $28
85CF DF           |           RST $18
85D0 D2 E2 B3     |           JP NC,B3E2h
85D3 83           |           ADD A,E
85D4 16 26        |           LD D,26h
85D6 77           |           LD (HL),A
85D7 47           |           LD B,A
85D8 5A           |           LD E,D
85D9 6A           |           LD L,D
85DA 3B           |           DEC SP
85DB 0B           |           DEC BC
85DC 9E           |           SBC A,(HL)
85DD AE           |           XOR (HL)
85DE FF           |           RST $38
85DF CF           |           RST $08
85E0 E2 D2 83     |           JP PO,83D2h
85E3 B3           |           OR E
85E4 26 16        |           LD H,16h
85E6 47           |           LD B,A
85E7 77           |           LD (HL),A
85E8 6A           |           LD L,D
85E9 5A           |           LD E,D
85EA 0B           |           DEC BC
85EB 3B           |           DEC SP
85EC AE           |           XOR (HL)
85ED 9E           |           SBC A,(HL)
85EE CF           |           RST $08
85EF FF           |           RST $38
85F0 F2 C2 93     |           JP P,93C2h
85F3 A3           |           AND E
85F4 36 06        |           LD (HL),06h
85F6 57           |           LD D,A
85F7 67           |           LD H,A
85F8 7A           |           LD A,D
85F9 4A           |           LD C,D
85FA 1B           |           DEC DE
85FB 2B           |           DEC HL
85FC BE           |           CP (HL)
85FD 8E           |           ADC A,(HL)
85FE DF           |           RST $18
85FF EF           |           RST $28
8600 00           |           NOP
8601 07           |           RLCA
8602 0E 09        |           LD C,09h
8604 6D           |           LD L,L
8605 6A           |           LD L,D
8606 63           |           LD H,E
8607 64           |           LD H,H
8608 DB DC        |           IN A,(DCh)
860A D5           |           PUSH DE
860B D2 B6 B1     |           JP NC,B1B6h
860E B8           |           CP B
860F BF           |           CP A
8610 B7           |           OR A
8611 B0           |           OR B
8612 B9           |           CP C
8613 BE           |           CP (HL)
8614 DA DD D4     |           JP C,D4DDh
8617 D3 6C        |           OUT (6Ch),A
8619 6B           |           LD L,E
861A 62           |           LD H,D
861B 65           |           LD H,L
861C 01 06 0F     |           LD BC,0F06h
861F 08           |           EX AF,AF'
8620 6E           |           LD L,(HL)
8621 69           |           LD L,C
8622 60           |           LD H,B
8623 67           |           LD H,A
8624 03           |           INC BC
8625 04           |           INC B
8626 0D           |           DEC C
8627 0A           |           LD A,(BC)
8628 B5           |           OR L
8629 B2           |           OR D
862A BB           |           CP E
862B BC           |           CP H
862C D8           |           RET C
862D DF           |           RST $18
862E D6 D1        |           SUB A,D1h
8630 D9           |           EXX
8631 DE D7        |           SBC A,D7h
8633 D0           |           RET NC
8634 B4           |           OR H
8635 B3           |           OR E
8636 BA           |           CP D
8637 BD           |           CP L
8638 02           |           LD (BC),A
8639 05           |           DEC B
863A 0C           |           INC C
863B 0B           |           DEC BC
863C 6F           |           LD L,A
863D 68           |           LD L,B
863E 61           |           LD H,C
863F 66           |           LD H,(HL)
8640 DC DB D2     |           CALL C,D2DBh
8643 D5           |           PUSH DE
8644 B1           |           OR C
8645 B6           |           OR (HL)
8646 BF           |           CP A
8647 B8           |           CP B
8648 07           |           RLCA
8649 00           |           NOP
864A 09           |           ADD HL,BC
864B 0E 6A        |           LD C,6Ah
864D 6D           |           LD L,L
864E 64           |           LD H,H
864F 63           |           LD H,E
8650 6B           |           LD L,E
8651 6C           |           LD L,H
8652 65           |           LD H,L
8653 62           |           LD H,D
8654 06 01        |           LD B,01h
8656 08           |           EX AF,AF'
8657 0F           |           RRCA
8658 B0           |           OR B
8659 B7           |           OR A
865A BE           |           CP (HL)
865B B9           |           CP C
865C DD           |           *ILLEGAL*
865D DA D3 D4     |           JP C,D4D3h
8660 B2           |           OR D
8661 B5           |           OR L
8662 BC           |           CP H
8663 BB           |           CP E
8664 DF           |           RST $18
8665 D8           |           RET C
8666 D1           |           POP DE
8667 D6 69        |           SUB A,69h
8669 6E           |           LD L,(HL)
866A 67           |           LD H,A
866B 60           |           LD H,B
866C 04           |           INC B
866D 03           |           INC BC
866E 0A           |           LD A,(BC)
866F 0D           |           DEC C
8670 05           |           DEC B
8671 02           |           LD (BC),A
8672 0B           |           DEC BC
8673 0C           |           INC C
8674 68           |           LD L,B
8675 6F           |           LD L,A
8676 66           |           LD H,(HL)
8677 61           |           LD H,C
8678 DE D9        |           SBC A,D9h
867A D0           |           RET NC
867B D7           |           RST $10
867C B3           |           OR E
867D B4           |           OR H
867E BD           |           CP L
867F BA           |           CP D
8680 B8           |           CP B
8681 BF           |           CP A
8682 B6           |           OR (HL)
8683 B1           |           OR C
8684 D5           |           PUSH DE
8685 D2 DB DC     |           JP NC,DCDBh
8688 63           |           LD H,E
8689 64           |           LD H,H
868A 6D           |           LD L,L
868B 6A           |           LD L,D
868C 0E 09        |           LD C,09h
868E 00           |           NOP
868F 07           |           RLCA
8690 0F           |           RRCA
8691 08           |           EX AF,AF'
8692 01 06 62     |           LD BC,6206h
8695 65           |           LD H,L
8696 6C           |           LD L,H
8697 6B           |           LD L,E
8698 D4 D3 DA     |           CALL NC,DAD3h
869B DD           |           *ILLEGAL*
869C B9           |           CP C
869D BE           |           CP (HL)
869E B7           |           OR A
869F B0           |           OR B
86A0 D6 D1        |           SUB A,D1h
86A2 D8           |           RET C
86A3 DF           |           RST $18
86A4 BB           |           CP E
86A5 BC           |           CP H
86A6 B5           |           OR L
86A7 B2           |           OR D
86A8 0D           |           DEC C
86A9 0A           |           LD A,(BC)
86AA 03           |           INC BC
86AB 04           |           INC B
86AC 60           |           LD H,B
86AD 67           |           LD H,A
86AE 6E           |           LD L,(HL)
86AF 69           |           LD L,C
86B0 61           |           LD H,C
86B1 66           |           LD H,(HL)
86B2 6F           |           LD L,A
86B3 68           |           LD L,B
86B4 0C           |           INC C
86B5 0B           |           DEC BC
86B6 02           |           LD (BC),A
86B7 05           |           DEC B
86B8 BA           |           CP D
86B9 BD           |           CP L
86BA B4           |           OR H
86BB B3           |           OR E
86BC D7           |           RST $10
86BD D0           |           RET NC
86BE D9           |           EXX
86BF DE 64        |           SBC A,64h
86C1 63           |           LD H,E
86C2 6A           |           LD L,D
86C3 6D           |           LD L,L
86C4 09           |           ADD HL,BC
86C5 0E 07        |           LD C,07h
86C7 00           |           NOP
86C8 BF           |           CP A
86C9 B8           |           CP B
86CA B1           |           OR C
86CB B6           |           OR (HL)
86CC D2 D5 DC     |           JP NC,DCD5h
86CF DB D3        |           IN A,(D3h)
86D1 D4 DD DA     |           CALL NC,DADDh
86D4 BE           |           CP (HL)
86D5 B9           |           CP C
86D6 B0           |           OR B
86D7 B7           |           OR A
86D8 08           |           EX AF,AF'
86D9 0F           |           RRCA
86DA 06 01        |           LD B,01h
86DC 65           |           LD H,L
86DD 62           |           LD H,D
86DE 6B           |           LD L,E
86DF 6C           |           LD L,H
86E0 0A           |           LD A,(BC)
86E1 0D           |           DEC C
86E2 04           |           INC B
86E3 03           |           INC BC
86E4 67           |           LD H,A
86E5 60           |           LD H,B
86E6 69           |           LD L,C
86E7 6E           |           LD L,(HL)
86E8 D1           |           POP DE
86E9 D6 DF        |           SUB A,DFh
86EB D8           |           RET C
86EC BC           |           CP H
86ED BB           |           CP E
86EE B2           |           OR D
86EF B5           |           OR L
86F0 BD           |           CP L
86F1 BA           |           CP D
86F2 B3           |           OR E
86F3 B4           |           OR H
86F4 D0           |           RET NC
86F5 D7           |           RST $10
86F6 DE D9        |           SBC A,D9h
86F8 66           |           LD H,(HL)
86F9 61           |           LD H,C
86FA 68           |           LD L,B
86FB 6F           |           LD L,A
86FC 0B           |           DEC BC
86FD 0C           |           INC C
86FE 05           |           DEC B
86FF 02           |           LD (BC),A
8700 00           |           NOP
8701 77           |           LD (HL),A
8702 EE 99        |           XOR 99h
8704 07           |           RLCA
8705 70           |           LD (HL),B
8706 E9           |           JP (HL)
8707 9E           |           SBC A,(HL)
8708 0E 79        |           LD C,79h
870A E0           |           RET PO
870B 97           |           SUB A,A
870C 09           |           ADD HL,BC
870D 7E           |           LD A,(HL)
870E E7           |           RST $20
870F 90           |           SUB A,B
8710 1D           |           DEC E
8711 6A           |           LD L,D
8712 F3           |           DI
8713 84           |           ADD A,H
8714 1A           |           LD A,(DE)
8715 6D           |           LD L,L
8716 F4 83 13     |           CALL P,1383h
8719 64           |           LD H,H
871A FD           |           *ILLEGAL*
871B 8A           |           ADC A,D
871C 14           |           INC D
871D 63           |           LD H,E
871E FA 8D 3B     |           JP M,3B8Dh
8721 4C           |           LD C,H
8722 D5           |           PUSH DE
8723 A2           |           AND D
8724 3C           |           INC A
8725 4B           |           LD C,E
8726 D2 A5 35     |           JP NC,35A5h
8729 42           |           LD B,D
872A DB AC        |           IN A,(ACh)
872C 32 45 DC     |           LD (DC45h),A
872F AB           |           XOR E
8730 26 51        |           LD H,51h
8732 C8           |           RET Z
8733 BF           |           CP A
8734 21 56 CF     |           LD HL,CF56h
8737 B8           |           CP B
8738 28 5F        |           JR Z,8799h
873A C6 B1        |           ADD A,B1h
873C 2F           |           CPL
873D 58           |           LD E,B
873E C1           |           POP BC
873F B6           |           OR (HL)
8740 76           |           HALT
8741 01 98 EF     |           LD BC,EF98h
8744 71           |           LD (HL),C
8745 06 9F        |           LD B,9Fh
8747 E8           |           RET PE
8748 78           |           LD A,B
8749 0F           |           RRCA
874A 96           |           SUB A,(HL)
874B E1           |           POP HL
874C 7F           |           LD A,A
874D 08           |           EX AF,AF'
874E 91           |           SUB A,C
874F E6 6B        |           AND 6Bh
8751 1C           |           INC E
8752 85           |           ADD A,L
8753 F2 6C 1B     |           JP P,1B6Ch
8756 82           |           ADD A,D
8757 F5           |           PUSH AF
8758 65           |           LD H,L
8759 12           |           LD (DE),A
875A 8B           |           ADC A,E
875B FC 62 15     |           CALL M,1562h
875E 8C           |           ADC A,H
875F FB           |           EI
8760 4D           |           LD C,L
8761 3A A3 D4     |           LD A,(D4A3h)
8764 4A           |           LD C,D
8765 3D           |           DEC A
8766 A4           |           AND H
8767 D3 43        |           OUT (43h),A
8769 34           |           INC (HL)
876A AD           |           XOR L
876B DA 44 33     |           JP C,3344h
876E AA           |           XOR D
876F DD           |           *ILLEGAL*
8770 50           |           LD D,B
8771 27           |           DAA
8772 BE           |           CP (HL)
8773 C9           |           RET
8774 57           |           LD D,A
8775 20 B9        |           JR NZ,8730h
8777 CE 5E        |           ADC A,5Eh
8779 29           |           ADD HL,HL
877A B0           |           OR B
877B C7           |           RST $00
877C 59           |           LD E,C
877D 2E B7        |           LD L,B7h
877F C0           |           RET NZ
8780 ED           |           *ILLEGAL*
8781 9A           |           SBC A,D
8782 03           |           INC BC
8783 74           |           LD (HL),H
8784 EA 9D 04     |           JP PE,049Dh
8787 73           |           LD (HL),E
8788 E3           |           EX (SP),HL
8789 94           |           SUB A,H
878A 0D           |           DEC C
878B 7A           |           LD A,D
878C E4 93 0A     |           CALL PO,0A93h
878F 7D           |           LD A,L
8790 F0           |           RET P
8791 87           |           ADD A,A
8792 1E 69        |           LD E,69h
8794 F7           |           RST $30
8795 80           |           ADD A,B
8796 19           |           ADD HL,DE
8797 6E           |           LD L,(HL)
8798 FE 89        |           CP 89h
879A 10 67        |           DJNZ 8803h
879C F9           |           LD SP,HL
879D 8E           |           ADC A,(HL)
879E 17           |           RLA
879F 60           |           LD H,B
87A0 D6 A1        |           SUB A,A1h
87A2 38 4F        |           JR C,87F3h
87A4 D1           |           POP DE
87A5 A6           |           AND (HL)
87A6 3F           |           CCF
87A7 48           |           LD C,B
87A8 D8           |           RET C
87A9 AF           |           XOR A
87AA 36 41        |           LD (HL),41h
87AC DF           |           RST $18
87AD A8           |           XOR B
87AE 31 46 CB     |           LD SP,CB46h
87B1 BC           |           CP H
87B2 25           |           DEC H
87B3 52           |           LD D,D
87B4 CC BB 22     |           CALL Z,22BBh
87B7 55           |           LD D,L
87B8 C5           |           PUSH BC
87B9 B2           |           OR D
87BA 2B           |           DEC HL
87BB 5C           |           LD E,H
87BC C2 B5 2C     |           JP NZ,2CB5h
87BF 5B           |           LD E,E
87C0 9B           |           SBC A,E
87C1 EC 75 02     |           CALL P,0275h
87C4 9C           |           SBC A,H
87C5 EB           |           EX DE,HL
87C6 72           |           LD (HL),D
87C7 05           |           DEC B
87C8 95           |           SUB A,L
87C9 E2 7B 0C     |           JP PO,0C7Bh
87CC 92           |           SUB A,D
87CD E5           |           PUSH HL
87CE 7C           |           LD A,H
87CF 0B           |           DEC BC
87D0 86           |           ADD A,(HL)
87D1 F1           |           POP AF
87D2 68           |           LD L,B
87D3 1F           |           RRA
87D4 81           |           ADD A,C
87D5 F6 6F        |           OR 6Fh
87D7 18 88        |           JR 8761h
87D9 FF           |           RST $38
87DA 66           |           LD H,(HL)
87DB 11 8F F8     |           LD DE,F88Fh
87DE 61           |           LD H,C
87DF 16 A0        |           LD D,A0h
87E1 D7           |           RST $10
87E2 4E           |           LD C,(HL)
87E3 39           |           ADD HL,SP
87E4 A7           |           AND A
87E5 D0           |           RET NC
87E6 49           |           LD C,C
87E7 3E AE        |           LD A,AEh
87E9 D9           |           EXX
87EA 40           |           LD B,B
87EB 37           |           SCF
87EC A9           |           XOR C
87ED DE 47        |           SBC A,47h
87EF 30 BD        |           JR NC,87AEh
87F1 CA 53 24     |           JP Z,2453h
87F4 BA           |           CP D
87F5 CD 54 23     |           CALL 2354h
87F8 B3           |           OR E
87F9 C4 5D 2A     |           CALL NZ,2A5Dh
87FC B4           |           OR H
87FD C3 5A 2D     |           JP 2D5Ah
8800 00           |           NOP
8801 00           |           NOP
8802 00           |           NOP
8803 00           |           NOP
8804 00           |           NOP
8805 00           |           NOP
8806 00           |           NOP
8807 00           |           NOP
8808 00           |           NOP
8809 00           |           NOP
880A 00           |           NOP
880B 00           |           NOP
880C 00           |           NOP
880D 00           |           NOP
880E 00           |           NOP
880F 00           |           NOP
8810 3F           |           CCF
8811 C3 3A 83     |           JP 833Ah
8814 00           |           NOP
8815 00           |           NOP
8816 00           |           NOP
8817 00           |           NOP
8818 00           |           NOP
8819 00           |           NOP
881A 00           |           NOP
881B 00           |           NOP
881C 00           |           NOP
881D 00           |           NOP
881E 00           |           NOP
881F 00           |           NOP
8820 00           |           NOP
8821 00           |           NOP
8822 00           |           NOP
8823 00           |           NOP
8824 00           |           NOP
8825 00           |           NOP
8826 00           |           NOP
8827 00           |           NOP
8828 00           |           NOP
8829 00           |           NOP
882A 00           |           NOP
882B 00           |           NOP
882C 00           |           NOP
882D 00           |           NOP
882E 00           |           NOP
882F 00           |           NOP
8830 00           |           NOP
8831 00           |           NOP
8832 00           |           NOP
8833 00           |           NOP
8834 00           |           NOP
8835 00           |           NOP
8836 00           |           NOP
8837 00           |           NOP
8838 00           |           NOP
8839 00           |           NOP
883A 00           |           NOP
883B 00           |           NOP
883C 00           |           NOP
883D 00           |           NOP
883E 00           |           NOP
883F 00           |           NOP
8840 00           |           NOP
8841 00           |           NOP
8842 00           |           NOP
8843 00           |           NOP
8844 00           |           NOP
8845 00           |           NOP
8846 00           |           NOP
8847 00           |           NOP
8848 00           |           NOP
8849 00           |           NOP
884A 00           |           NOP
884B 00           |           NOP
884C 00           |           NOP
884D 00           |           NOP
884E 00           |           NOP
884F 00           |           NOP
8850 00           |           NOP
8851 00           |           NOP
8852 00           |           NOP
8853 00           |           NOP
8854 00           |           NOP
8855 00           |           NOP
8856 00           |           NOP
8857 00           |           NOP
8858 00           |           NOP
8859 00           |           NOP
885A 00           |           NOP
885B 00           |           NOP
885C 00           |           NOP
885D 00           |           NOP
885E 00           |           NOP
885F 00           |           NOP
8860 00           |           NOP
8861 00           |           NOP
8862 00           |           NOP
8863 00           |           NOP
8864 00           |           NOP
8865 00           |           NOP
8866 00           |           NOP
8867 00           |           NOP
8868 00           |           NOP
8869 00           |           NOP
886A 00           |           NOP
886B 00           |           NOP
886C 00           |           NOP
886D 00           |           NOP
886E 00           |           NOP
886F 00           |           NOP
8870 00           |           NOP
8871 00           |           NOP
8872 00           |           NOP
8873 00           |           NOP
8874 00           |           NOP
8875 00           |           NOP
8876 00           |           NOP
8877 00           |           NOP
8878 00           |           NOP
8879 00           |           NOP
887A 00           |           NOP
887B 00           |           NOP
887C 00           |           NOP
887D 00           |           NOP
887E 00           |           NOP
887F C1           |           POP BC
8880 89           |           ADC A,C
8881 0F           |           RRCA
8882 8A           |           ADC A,D
8883 57           |           LD D,A
8884 8A           |           ADC A,D
8885 9F           |           SBC A,A
8886 8A           |           ADC A,D
8887 EE 8A        |           XOR 8Ah
8889 3D           |           DEC A
888A 8B           |           ADC A,E
888B 8B           |           ADC A,E
888C 8B           |           ADC A,E
888D D9           |           EXX
888E 8B           |           ADC A,E
888F 25           |           DEC H
8890 8C           |           ADC A,H
8891 71           |           LD (HL),C
8892 8C           |           ADC A,H
8893 B9           |           CP C
8894 8C           |           ADC A,H
8895 01 8D 49     |           LD BC,498Dh
8898 8D           |           ADC A,L
8899 92           |           SUB A,D
889A 8D           |           ADC A,L
889B DE 8D        |           SBC A,8Dh
889D 2A 8E 76     |           LD HL,(768Eh)
88A0 8E           |           ADC A,(HL)
88A1 C2 8E 0C     |           JP NZ,0C8Eh
88A4 8F           |           ADC A,A
88A5 56           |           LD D,(HL)
88A6 8F           |           ADC A,A
88A7 9F           |           SBC A,A
88A8 8F           |           ADC A,A
88A9 E8           |           RET PE
88AA 8F           |           ADC A,A
88AB 34           |           INC (HL)
88AC 90           |           SUB A,B
88AD 84           |           ADD A,H
88AE 90           |           SUB A,B
88AF D4 90 24     |           CALL NC,2490h
88B2 91           |           SUB A,C
88B3 73           |           LD (HL),E
88B4 91           |           SUB A,C
88B5 C5           |           PUSH BC
88B6 91           |           SUB A,C
88B7 17           |           RLA
88B8 92           |           SUB A,D
88B9 66           |           LD H,(HL)
88BA 92           |           SUB A,D
88BB AF           |           XOR A
88BC 92           |           SUB A,D
88BD F8           |           RET M
88BE 92           |           SUB A,D
88BF 40           |           LD B,B
88C0 93           |           SUB A,E
88C1 88           |           ADC A,B
88C2 93           |           SUB A,E
88C3 D0           |           RET NC
88C4 93           |           SUB A,E
88C5 18 94        |           JR 885Bh
88C7 62           |           LD H,D
88C8 94           |           SUB A,H
88C9 AC           |           XOR H
88CA 94           |           SUB A,H
88CB F5           |           PUSH AF
88CC 94           |           SUB A,H
88CD 3E 95        |           LD A,95h
88CF 88           |           ADC A,B
88D0 95           |           SUB A,L
88D1 D2 95 1D     |           JP NC,1D95h
88D4 96           |           SUB A,(HL)
88D5 67           |           LD H,A
88D6 96           |           SUB A,(HL)
88D7 B8           |           CP B
88D8 96           |           SUB A,(HL)
88D9 09           |           ADD HL,BC
88DA 97           |           SUB A,A
88DB 59           |           LD E,C
88DC 97           |           SUB A,A
88DD A9           |           XOR C
88DE 97           |           SUB A,A
88DF FA 97 4B     |           JP M,4B97h
88E2 98           |           SBC A,B
88E3 9D           |           SBC A,L
88E4 98           |           SBC A,B
88E5 EE 98        |           XOR 98h
88E7 3B           |           DEC SP
88E8 99           |           SBC A,C
88E9 8A           |           ADC A,D
88EA 99           |           SBC A,C
88EB D4 99 1E     |           CALL NC,1E99h
88EE 9A           |           SBC A,D
88EF 6F           |           LD L,A
88F0 9A           |           SBC A,D
88F1 C0           |           RET NZ
88F2 9A           |           SBC A,D
88F3 0A           |           LD A,(BC)
88F4 9B           |           SBC A,E
88F5 54           |           LD D,H
88F6 9B           |           SBC A,E
88F7 A1           |           AND C
88F8 9B           |           SBC A,E
88F9 EE 9B        |           XOR 9Bh
88FB 39           |           ADD HL,SP
88FC 9C           |           SBC A,H
88FD 84           |           ADD A,H
88FE 9C           |           SBC A,H
88FF CF           |           RST $08
8900 9C           |           SBC A,H
8901 1A           |           LD A,(DE)
8902 9D           |           SBC A,L
8903 68           |           LD L,B
8904 9D           |           SBC A,L
8905 B6           |           OR (HL)
8906 9D           |           SBC A,L
8907 04           |           INC B
8908 9E           |           SBC A,(HL)
8909 52           |           LD D,D
890A 9E           |           SBC A,(HL)
890B A0           |           AND B
890C 9E           |           SBC A,(HL)
890D EC 9E 3B     |           CALL P,3B9Eh
8910 9F           |           SBC A,A
8911 8E           |           ADC A,(HL)
8912 9F           |           SBC A,A
8913 DD           |           *ILLEGAL*
8914 9F           |           SBC A,A
8915 2E A0        |           LD L,A0h
8917 7A           |           LD A,D
8918 A0           |           AND B
8919 C9           |           RET
891A A0           |           AND B
891B 1C           |           INC E
891C A1           |           AND C
891D 6B           |           LD L,E
891E A1           |           AND C
891F BC           |           CP H
8920 A1           |           AND C
8921 08           |           EX AF,AF'
8922 A2           |           AND D
8923 57           |           LD D,A
8924 A2           |           AND D
8925 AA           |           XOR D
8926 A2           |           AND D
8927 F9           |           LD SP,HL
8928 A2           |           AND D
8929 4A           |           LD C,D
892A A3           |           AND E
892B 92           |           SUB A,D
892C A3           |           AND E
892D DA A3 23     |           JP C,23A3h
8930 A4           |           AND H
8931 6C           |           LD L,H
8932 A4           |           AND H
8933 BB           |           CP E
8934 A4           |           AND H
8935 0A           |           LD A,(BC)
8936 A5           |           AND L
8937 52           |           LD D,D
8938 A5           |           AND L
8939 9A           |           SBC A,D
893A A5           |           AND L
893B E3           |           EX (SP),HL
893C A5           |           AND L
893D 2C           |           INC L
893E A6           |           AND (HL)
893F 7A           |           LD A,D
8940 A6           |           AND (HL)
8941 C8           |           RET Z
8942 A6           |           AND (HL)
8943 14           |           INC D
8944 A7           |           AND A
8945 5D           |           LD E,L
8946 A7           |           AND A
8947 A6           |           AND (HL)
8948 A7           |           AND A
8949 F0           |           RET P
894A A7           |           AND A
894B 3A A8 8A     |           LD A,(8AA8h)
894E A8           |           XOR B
894F DA A8 28     |           JP C,28A8h
8952 A9           |           XOR C
8953 76           |           HALT
8954 A9           |           XOR C
8955 C4 A9 0D     |           CALL NZ,0DA9h
8958 AA           |           XOR D
8959 56           |           LD D,(HL)
895A AA           |           XOR D
895B 9F           |           SBC A,A
895C AA           |           XOR D
895D E8           |           RET PE
895E AA           |           XOR D
895F 32 AB 7F     |           LD (7FABh),A
8962 AB           |           XOR E
8963 CB AB        |           RES 5,E
8965 17           |           RLA
8966 AC           |           XOR H
8967 60           |           LD H,B
8968 AC           |           XOR H
8969 AC           |           XOR H
896A AC           |           XOR H
896B F7           |           RST $30
896C AC           |           XOR H
896D 43           |           LD B,E
896E AD           |           XOR L
896F 92           |           SUB A,D
8970 AD           |           XOR L
8971 DA AD 25     |           JP C,25ADh
8974 AE           |           XOR (HL)
8975 6E           |           LD L,(HL)
8976 AE           |           XOR (HL)
8977 B7           |           OR A
8978 AE           |           XOR (HL)
8979 05           |           DEC B
897A AF           |           XOR A
897B 55           |           LD D,L
897C AF           |           XOR A
897D A5           |           AND L
897E AF           |           XOR A
897F F5           |           PUSH AF
8980 AF           |           XOR A
8981 42           |           LD B,D
8982 B0           |           OR B
8983 90           |           SUB A,B
8984 B0           |           OR B
8985 D8           |           RET C
8986 B0           |           OR B
8987 27           |           DAA
8988 B1           |           OR C
8989 76           |           HALT
898A B1           |           OR C
898B CF           |           RST $08
898C B1           |           OR C
898D 28 B2        |           JR Z,8941h
898F 76           |           HALT
8990 B2           |           OR D
8991 C4 B2 16     |           CALL NZ,16B2h
8994 B3           |           OR E
8995 61           |           LD H,C
8996 B3           |           OR E
8997 AF           |           XOR A
8998 B3           |           OR E
8999 02           |           LD (BC),A
899A B4           |           OR H
899B 55           |           LD D,L
899C B4           |           OR H
899D A3           |           AND E
899E B4           |           OR H
899F F1           |           POP AF
89A0 B4           |           OR H
89A1 3E B5        |           LD A,B5h
89A3 8B           |           ADC A,E
89A4 B5           |           OR L
89A5 DA B5 29     |           JP C,29B5h
89A8 B6           |           OR (HL)
89A9 78           |           LD A,B
89AA B6           |           OR (HL)
89AB C7           |           RST $00
89AC B6           |           OR (HL)
89AD 16 B7        |           LD D,B7h
89AF 65           |           LD H,L
89B0 B7           |           OR A
89B1 B2           |           OR D
89B2 B7           |           OR A
89B3 FF           |           RST $38
89B4 B7           |           OR A
89B5 4A           |           LD C,D
89B6 B8           |           CP B
89B7 95           |           SUB A,L
89B8 B8           |           CP B
89B9 E0           |           RET PO
89BA B8           |           CP B
89BB 2B           |           DEC HL
89BC B9           |           CP C
89BD 75           |           LD (HL),L
89BE B9           |           CP C
89BF 00           |           NOP
89C0 00           |           NOP
89C1 FF           |           RST $38
89C2 00           |           NOP
89C3 00           |           NOP
89C4 00           |           NOP
89C5 00           |           NOP
89C6 3F           |           CCF
89C7 FF           |           RST $38
89C8 AA           |           XOR D
89C9 CC BB EE     |           CALL Z,EEBBh
89CC DD           |           *ILLEGAL*
89CD 11 44 88     |           LD DE,8844h
89D0 DD 77 FD     |           LD (IX+FDh),A
89D3 34           |           INC (HL)
89D4 12           |           LD (DE),A
89D5 00           |           NOP
89D6 C0           |           RET NZ
89D7 00           |           NOP
89D8 00           |           NOP
89D9 00           |           NOP
89DA 00           |           NOP
89DB 00           |           NOP
89DC 20 00        |           JR NZ,89DEh
89DE 00           |           NOP
89DF 00           |           NOP
89E0 00           |           NOP
89E1 00           |           NOP
89E2 00           |           NOP
89E3 00           |           NOP
89E4 00           |           NOP
89E5 00           |           NOP
89E6 00           |           NOP
89E7 00           |           NOP
89E8 00           |           NOP
89E9 00           |           NOP
89EA 00           |           NOP
89EB 00           |           NOP
89EC 00           |           NOP
89ED 00           |           NOP
89EE 00           |           NOP
89EF 00           |           NOP
89F0 00           |           NOP
89F1 08           |           EX AF,AF'
89F2 28 00        |           JR Z,89F4h
89F4 00           |           NOP
89F5 00           |           NOP
89F6 00           |           NOP
89F7 00           |           NOP
89F8 00           |           NOP
89F9 00           |           NOP
89FA 00           |           NOP
89FB 00           |           NOP
89FC 00           |           NOP
89FD 00           |           NOP
89FE 00           |           NOP
89FF 00           |           NOP
8A00 00           |           NOP
8A01 97           |           SUB A,A
8A02 BB           |           CP E
8A03 02           |           LD (BC),A
8A04 8F           |           ADC A,A
8A05 53           |           LD D,E
8A06 45           |           LD B,L
8A07 4C           |           LD C,H
8A08 46           |           LD B,(HL)
8A09 20 54        |           JR NZ,8A5Fh
8A0B 45           |           LD B,L
8A0C 53           |           LD D,E
8A0D 54           |           LD D,H
8A0E 00           |           NOP
8A0F FF           |           RST $38
8A10 37           |           SCF
8A11 3F           |           CCF
8A12 00           |           NOP
8A13 00           |           NOP
8A14 00           |           NOP
8A15 FF           |           RST $38
8A16 AA           |           XOR D
8A17 CC BB EE     |           CALL Z,EEBBh
8A1A DD           |           *ILLEGAL*
8A1B 11 44 88     |           LD DE,8844h
8A1E DD 77 FD     |           LD (IX+FDh),A
8A21 34           |           INC (HL)
8A22 12           |           LD (DE),A
8A23 00           |           NOP
8A24 C0           |           RET NZ
8A25 00           |           NOP
8A26 00           |           NOP
8A27 00           |           NOP
8A28 00           |           NOP
8A29 00           |           NOP
8A2A FF           |           RST $38
8A2B 28 00        |           JR Z,8A2Dh
8A2D 00           |           NOP
8A2E 00           |           NOP
8A2F 00           |           NOP
8A30 00           |           NOP
8A31 00           |           NOP
8A32 00           |           NOP
8A33 00           |           NOP
8A34 00           |           NOP
8A35 00           |           NOP
8A36 00           |           NOP
8A37 00           |           NOP
8A38 00           |           NOP
8A39 00           |           NOP
8A3A 00           |           NOP
8A3B 00           |           NOP
8A3C 00           |           NOP
8A3D 00           |           NOP
8A3E 00           |           NOP
8A3F 00           |           NOP
8A40 D7           |           RST $10
8A41 00           |           NOP
8A42 00           |           NOP
8A43 00           |           NOP
8A44 00           |           NOP
8A45 00           |           NOP
8A46 00           |           NOP
8A47 00           |           NOP
8A48 00           |           NOP
8A49 00           |           NOP
8A4A 00           |           NOP
8A4B 00           |           NOP
8A4C 00           |           NOP
8A4D 00           |           NOP
8A4E 00           |           NOP
8A4F E0           |           RET PO
8A50 D3 C7        |           OUT (C7h),A
8A52 BF           |           CP A
8A53 53           |           LD D,E
8A54 43           |           LD B,E
8A55 46           |           LD B,(HL)
8A56 00           |           NOP
8A57 FF           |           RST $38
8A58 3F           |           CCF
8A59 3F           |           CCF
8A5A 00           |           NOP
8A5B 00           |           NOP
8A5C 00           |           NOP
8A5D FF           |           RST $38
8A5E AA           |           XOR D
8A5F CC BB EE     |           CALL Z,EEBBh
8A62 DD           |           *ILLEGAL*
8A63 11 44 88     |           LD DE,8844h
8A66 DD 77 FD     |           LD (IX+FDh),A
8A69 34           |           INC (HL)
8A6A 12           |           LD (DE),A
8A6B 00           |           NOP
8A6C C0           |           RET NZ
8A6D 00           |           NOP
8A6E 00           |           NOP
8A6F 00           |           NOP
8A70 00           |           NOP
8A71 00           |           NOP
8A72 FF           |           RST $38
8A73 28 00        |           JR Z,8A75h
8A75 00           |           NOP
8A76 00           |           NOP
8A77 00           |           NOP
8A78 00           |           NOP
8A79 00           |           NOP
8A7A 00           |           NOP
8A7B 00           |           NOP
8A7C 00           |           NOP
8A7D 00           |           NOP
8A7E 00           |           NOP
8A7F 00           |           NOP
8A80 00           |           NOP
8A81 00           |           NOP
8A82 00           |           NOP
8A83 00           |           NOP
8A84 00           |           NOP
8A85 00           |           NOP
8A86 00           |           NOP
8A87 00           |           NOP
8A88 D7           |           RST $10
8A89 00           |           NOP
8A8A 00           |           NOP
8A8B 00           |           NOP
8A8C 00           |           NOP
8A8D 00           |           NOP
8A8E 00           |           NOP
8A8F 00           |           NOP
8A90 00           |           NOP
8A91 00           |           NOP
8A92 00           |           NOP
8A93 00           |           NOP
8A94 00           |           NOP
8A95 00           |           NOP
8A96 00           |           NOP
8A97 85           |           ADD A,L
8A98 31 A6 25     |           LD SP,25A6h
8A9B 43           |           LD B,E
8A9C 43           |           LD B,E
8A9D 46           |           LD B,(HL)
8A9E 00           |           NOP
8A9F FF           |           RST $38
8AA0 37           |           SCF
8AA1 3F           |           CCF
8AA2 00           |           NOP
8AA3 00           |           NOP
8AA4 00           |           NOP
8AA5 FF           |           RST $38
8AA6 AA           |           XOR D
8AA7 CC BB EE     |           CALL Z,EEBBh
8AAA DD           |           *ILLEGAL*
8AAB 11 44 88     |           LD DE,8844h
8AAE DD 77 FD     |           LD (IX+FDh),A
8AB1 34           |           INC (HL)
8AB2 12           |           LD (DE),A
8AB3 00           |           NOP
8AB4 C0           |           RET NZ
8AB5 00           |           NOP
8AB6 00           |           NOP
8AB7 00           |           NOP
8AB8 00           |           NOP
8AB9 00           |           NOP
8ABA FF           |           RST $38
8ABB 28 00        |           JR Z,8ABDh
8ABD 00           |           NOP
8ABE 00           |           NOP
8ABF 00           |           NOP
8AC0 00           |           NOP
8AC1 00           |           NOP
8AC2 00           |           NOP
8AC3 00           |           NOP
8AC4 00           |           NOP
8AC5 00           |           NOP
8AC6 00           |           NOP
8AC7 00           |           NOP
8AC8 00           |           NOP
8AC9 00           |           NOP
8ACA 00           |           NOP
8ACB 00           |           NOP
8ACC 00           |           NOP
8ACD 00           |           NOP
8ACE 00           |           NOP
8ACF 00           |           NOP
8AD0 D7           |           RST $10
8AD1 00           |           NOP
8AD2 00           |           NOP
8AD3 00           |           NOP
8AD4 00           |           NOP
8AD5 00           |           NOP
8AD6 00           |           NOP
8AD7 00           |           NOP
8AD8 00           |           NOP
8AD9 00           |           NOP
8ADA 00           |           NOP
8ADB 00           |           NOP
8ADC 00           |           NOP
8ADD 00           |           NOP
8ADE 00           |           NOP
8ADF E0           |           RET PO
8AE0 D3 C7        |           OUT (C7h),A
8AE2 BF           |           CP A
8AE3 53           |           LD D,E
8AE4 43           |           LD B,E
8AE5 46           |           LD B,(HL)
8AE6 20 28        |           JR NZ,8B10h
8AE8 4E           |           LD C,(HL)
8AE9 45           |           LD B,L
8AEA 43           |           LD B,E
8AEB 29           |           ADD HL,HL
8AEC 00           |           NOP
8AED 00           |           NOP
8AEE FF           |           RST $38
8AEF 3F           |           CCF
8AF0 3F           |           CCF
8AF1 00           |           NOP
8AF2 00           |           NOP
8AF3 00           |           NOP
8AF4 FF           |           RST $38
8AF5 AA           |           XOR D
8AF6 CC BB EE     |           CALL Z,EEBBh
8AF9 DD           |           *ILLEGAL*
8AFA 11 44 88     |           LD DE,8844h
8AFD DD 77 FD     |           LD (IX+FDh),A
8B00 34           |           INC (HL)
8B01 12           |           LD (DE),A
8B02 00           |           NOP
8B03 C0           |           RET NZ
8B04 00           |           NOP
8B05 00           |           NOP
8B06 00           |           NOP
8B07 00           |           NOP
8B08 00           |           NOP
8B09 FF           |           RST $38
8B0A 28 00        |           JR Z,8B0Ch
8B0C 00           |           NOP
8B0D 00           |           NOP
8B0E 00           |           NOP
8B0F 00           |           NOP
8B10 00           |           NOP
8B11 00           |           NOP
8B12 00           |           NOP
8B13 00           |           NOP
8B14 00           |           NOP
8B15 00           |           NOP
8B16 00           |           NOP
8B17 00           |           NOP
8B18 00           |           NOP
8B19 00           |           NOP
8B1A 00           |           NOP
8B1B 00           |           NOP
8B1C 00           |           NOP
8B1D 00           |           NOP
8B1E 00           |           NOP
8B1F D7           |           RST $10
8B20 00           |           NOP
8B21 00           |           NOP
8B22 00           |           NOP
8B23 00           |           NOP
8B24 00           |           NOP
8B25 00           |           NOP
8B26 00           |           NOP
8B27 00           |           NOP
8B28 00           |           NOP
8B29 00           |           NOP
8B2A 00           |           NOP
8B2B 00           |           NOP
8B2C 00           |           NOP
8B2D 00           |           NOP
8B2E 85           |           ADD A,L
8B2F 31 A6 25     |           LD SP,25A6h
8B32 43           |           LD B,E
8B33 43           |           LD B,E
8B34 46           |           LD B,(HL)
8B35 20 28        |           JR NZ,8B5Fh
8B37 4E           |           LD C,(HL)
8B38 45           |           LD B,L
8B39 43           |           LD B,E
8B3A 29           |           ADD HL,HL
8B3B 00           |           NOP
8B3C 00           |           NOP
8B3D FF           |           RST $38
8B3E 37           |           SCF
8B3F 3F           |           CCF
8B40 00           |           NOP
8B41 00           |           NOP
8B42 00           |           NOP
8B43 FF           |           RST $38
8B44 AA           |           XOR D
8B45 CC BB EE     |           CALL Z,EEBBh
8B48 DD           |           *ILLEGAL*
8B49 11 44 88     |           LD DE,8844h
8B4C DD 77 FD     |           LD (IX+FDh),A
8B4F 34           |           INC (HL)
8B50 12           |           LD (DE),A
8B51 00           |           NOP
8B52 C0           |           RET NZ
8B53 00           |           NOP
8B54 00           |           NOP
8B55 00           |           NOP
8B56 00           |           NOP
8B57 00           |           NOP
8B58 FF           |           RST $38
8B59 28 00        |           JR Z,8B5Bh
8B5B 00           |           NOP
8B5C 00           |           NOP
8B5D 00           |           NOP
8B5E 00           |           NOP
8B5F 00           |           NOP
8B60 00           |           NOP
8B61 00           |           NOP
8B62 00           |           NOP
8B63 00           |           NOP
8B64 00           |           NOP
8B65 00           |           NOP
8B66 00           |           NOP
8B67 00           |           NOP
8B68 00           |           NOP
8B69 00           |           NOP
8B6A 00           |           NOP
8B6B 00           |           NOP
8B6C 00           |           NOP
8B6D 00           |           NOP
8B6E D7           |           RST $10
8B6F 00           |           NOP
8B70 00           |           NOP
8B71 00           |           NOP
8B72 00           |           NOP
8B73 00           |           NOP
8B74 00           |           NOP
8B75 00           |           NOP
8B76 00           |           NOP
8B77 00           |           NOP
8B78 00           |           NOP
8B79 00           |           NOP
8B7A 00           |           NOP
8B7B 00           |           NOP
8B7C 00           |           NOP
8B7D E0           |           RET PO
8B7E D3 C7        |           OUT (C7h),A
8B80 BF           |           CP A
8B81 53           |           LD D,E
8B82 43           |           LD B,E
8B83 46           |           LD B,(HL)
8B84 20 28        |           JR NZ,8BAEh
8B86 53           |           LD D,E
8B87 54           |           LD D,H
8B88 29           |           ADD HL,HL
8B89 00           |           NOP
8B8A 00           |           NOP
8B8B FF           |           RST $38
8B8C 3F           |           CCF
8B8D 3F           |           CCF
8B8E 00           |           NOP
8B8F 00           |           NOP
8B90 00           |           NOP
8B91 FF           |           RST $38
8B92 AA           |           XOR D
8B93 CC BB EE     |           CALL Z,EEBBh
8B96 DD           |           *ILLEGAL*
8B97 11 44 88     |           LD DE,8844h
8B9A DD 77 FD     |           LD (IX+FDh),A
8B9D 34           |           INC (HL)
8B9E 12           |           LD (DE),A
8B9F 00           |           NOP
8BA0 C0           |           RET NZ
8BA1 00           |           NOP
8BA2 00           |           NOP
8BA3 00           |           NOP
8BA4 00           |           NOP
8BA5 00           |           NOP
8BA6 FF           |           RST $38
8BA7 28 00        |           JR Z,8BA9h
8BA9 00           |           NOP
8BAA 00           |           NOP
8BAB 00           |           NOP
8BAC 00           |           NOP
8BAD 00           |           NOP
8BAE 00           |           NOP
8BAF 00           |           NOP
8BB0 00           |           NOP
8BB1 00           |           NOP
8BB2 00           |           NOP
8BB3 00           |           NOP
8BB4 00           |           NOP
8BB5 00           |           NOP
8BB6 00           |           NOP
8BB7 00           |           NOP
8BB8 00           |           NOP
8BB9 00           |           NOP
8BBA 00           |           NOP
8BBB 00           |           NOP
8BBC D7           |           RST $10
8BBD 00           |           NOP
8BBE 00           |           NOP
8BBF 00           |           NOP
8BC0 00           |           NOP
8BC1 00           |           NOP
8BC2 00           |           NOP
8BC3 00           |           NOP
8BC4 00           |           NOP
8BC5 00           |           NOP
8BC6 00           |           NOP
8BC7 00           |           NOP
8BC8 00           |           NOP
8BC9 00           |           NOP
8BCA 00           |           NOP
8BCB 85           |           ADD A,L
8BCC 31 A6 25     |           LD SP,25A6h
8BCF 43           |           LD B,E
8BD0 43           |           LD B,E
8BD1 46           |           LD B,(HL)
8BD2 20 28        |           JR NZ,8BFCh
8BD4 53           |           LD D,E
8BD5 54           |           LD D,H
8BD6 29           |           ADD HL,HL
8BD7 00           |           NOP
8BD8 00           |           NOP
8BD9 FF           |           RST $38
8BDA 37           |           SCF
8BDB 3F           |           CCF
8BDC 3F           |           CCF
8BDD 00           |           NOP
8BDE 00           |           NOP
8BDF FF           |           RST $38
8BE0 AA           |           XOR D
8BE1 CC BB EE     |           CALL Z,EEBBh
8BE4 DD           |           *ILLEGAL*
8BE5 11 44 88     |           LD DE,8844h
8BE8 DD 77 FD     |           LD (IX+FDh),A
8BEB 34           |           INC (HL)
8BEC 12           |           LD (DE),A
8BED 00           |           NOP
8BEE C0           |           RET NZ
8BEF 00           |           NOP
8BF0 00           |           NOP
8BF1 00           |           NOP
8BF2 00           |           NOP
8BF3 00           |           NOP
8BF4 FF           |           RST $38
8BF5 28 00        |           JR Z,8BF7h
8BF7 00           |           NOP
8BF8 00           |           NOP
8BF9 00           |           NOP
8BFA 00           |           NOP
8BFB 00           |           NOP
8BFC 00           |           NOP
8BFD 00           |           NOP
8BFE 00           |           NOP
8BFF 00           |           NOP
8C00 00           |           NOP
8C01 00           |           NOP
8C02 00           |           NOP
8C03 00           |           NOP
8C04 00           |           NOP
8C05 00           |           NOP
8C06 00           |           NOP
8C07 00           |           NOP
8C08 00           |           NOP
8C09 00           |           NOP
8C0A D7           |           RST $10
8C0B 00           |           NOP
8C0C 00           |           NOP
8C0D 00           |           NOP
8C0E 00           |           NOP
8C0F 00           |           NOP
8C10 00           |           NOP
8C11 00           |           NOP
8C12 00           |           NOP
8C13 00           |           NOP
8C14 00           |           NOP
8C15 00           |           NOP
8C16 00           |           NOP
8C17 00           |           NOP
8C18 00           |           NOP
8C19 95           |           SUB A,L
8C1A 8E           |           ADC A,(HL)
8C1B 3E 1E        |           LD A,1Eh
8C1D 53           |           LD D,E
8C1E 43           |           LD B,E
8C1F 46           |           LD B,(HL)
8C20 2B           |           DEC HL
8C21 43           |           LD B,E
8C22 43           |           LD B,E
8C23 46           |           LD B,(HL)
8C24 00           |           NOP
8C25 FF           |           RST $38
8C26 3F           |           CCF
8C27 37           |           SCF
8C28 3F           |           CCF
8C29 00           |           NOP
8C2A 00           |           NOP
8C2B FF           |           RST $38
8C2C AA           |           XOR D
8C2D CC BB EE     |           CALL Z,EEBBh
8C30 DD           |           *ILLEGAL*
8C31 11 44 88     |           LD DE,8844h
8C34 DD 77 FD     |           LD (IX+FDh),A
8C37 34           |           INC (HL)
8C38 12           |           LD (DE),A
8C39 00           |           NOP
8C3A C0           |           RET NZ
8C3B 00           |           NOP
8C3C 00           |           NOP
8C3D 00           |           NOP
8C3E 00           |           NOP
8C3F 00           |           NOP
8C40 FF           |           RST $38
8C41 28 00        |           JR Z,8C43h
8C43 00           |           NOP
8C44 00           |           NOP
8C45 00           |           NOP
8C46 00           |           NOP
8C47 00           |           NOP
8C48 00           |           NOP
8C49 00           |           NOP
8C4A 00           |           NOP
8C4B 00           |           NOP
8C4C 00           |           NOP
8C4D 00           |           NOP
8C4E 00           |           NOP
8C4F 00           |           NOP
8C50 00           |           NOP
8C51 00           |           NOP
8C52 00           |           NOP
8C53 00           |           NOP
8C54 00           |           NOP
8C55 00           |           NOP
8C56 D7           |           RST $10
8C57 00           |           NOP
8C58 00           |           NOP
8C59 00           |           NOP
8C5A 00           |           NOP
8C5B 00           |           NOP
8C5C 00           |           NOP
8C5D 00           |           NOP
8C5E 00           |           NOP
8C5F 00           |           NOP
8C60 00           |           NOP
8C61 00           |           NOP
8C62 00           |           NOP
8C63 00           |           NOP
8C64 00           |           NOP
8C65 E0           |           RET PO
8C66 D3 C7        |           OUT (C7h),A
8C68 BF           |           CP A
8C69 43           |           LD B,E
8C6A 43           |           LD B,E
8C6B 46           |           LD B,(HL)
8C6C 2B           |           DEC HL
8C6D 53           |           LD D,E
8C6E 43           |           LD B,E
8C6F 46           |           LD B,(HL)
8C70 00           |           NOP
8C71 FF           |           RST $38
8C72 27           |           DAA
8C73 3F           |           CCF
8C74 00           |           NOP
8C75 00           |           NOP
8C76 00           |           NOP
8C77 FF           |           RST $38
8C78 AA           |           XOR D
8C79 CC BB EE     |           CALL Z,EEBBh
8C7C DD           |           *ILLEGAL*
8C7D 11 44 88     |           LD DE,8844h
8C80 DD 77 FD     |           LD (IX+FDh),A
8C83 34           |           INC (HL)
8C84 12           |           LD (DE),A
8C85 00           |           NOP
8C86 C0           |           RET NZ
8C87 00           |           NOP
8C88 00           |           NOP
8C89 00           |           NOP
8C8A 00           |           NOP
8C8B 00           |           NOP
8C8C 13           |           INC DE
8C8D FF           |           RST $38
8C8E 00           |           NOP
8C8F 00           |           NOP
8C90 00           |           NOP
8C91 00           |           NOP
8C92 00           |           NOP
8C93 00           |           NOP
8C94 00           |           NOP
8C95 00           |           NOP
8C96 00           |           NOP
8C97 00           |           NOP
8C98 00           |           NOP
8C99 00           |           NOP
8C9A 00           |           NOP
8C9B 00           |           NOP
8C9C 00           |           NOP
8C9D 00           |           NOP
8C9E 00           |           NOP
8C9F 00           |           NOP
8CA0 00           |           NOP
8CA1 EC 00 00     |           CALL P,0000h
8CA4 00           |           NOP
8CA5 00           |           NOP
8CA6 00           |           NOP
8CA7 00           |           NOP
8CA8 00           |           NOP
8CA9 00           |           NOP
8CAA 00           |           NOP
8CAB 00           |           NOP
8CAC 00           |           NOP
8CAD 00           |           NOP
8CAE 00           |           NOP
8CAF 00           |           NOP
8CB0 00           |           NOP
8CB1 F6 64        |           OR 64h
8CB3 AE           |           XOR (HL)
8CB4 86           |           ADD A,(HL)
8CB5 44           |           LD B,H
8CB6 41           |           LD B,C
8CB7 41           |           LD B,C
8CB8 00           |           NOP
8CB9 FF           |           RST $38
8CBA 2F           |           CPL
8CBB 3F           |           CCF
8CBC 00           |           NOP
8CBD 00           |           NOP
8CBE 00           |           NOP
8CBF FF           |           RST $38
8CC0 AA           |           XOR D
8CC1 CC BB EE     |           CALL Z,EEBBh
8CC4 DD           |           *ILLEGAL*
8CC5 11 44 88     |           LD DE,8844h
8CC8 DD 77 FD     |           LD (IX+FDh),A
8CCB 34           |           INC (HL)
8CCC 12           |           LD (DE),A
8CCD 00           |           NOP
8CCE C0           |           RET NZ
8CCF 00           |           NOP
8CD0 00           |           NOP
8CD1 00           |           NOP
8CD2 00           |           NOP
8CD3 00           |           NOP
8CD4 00           |           NOP
8CD5 FF           |           RST $38
8CD6 00           |           NOP
8CD7 00           |           NOP
8CD8 00           |           NOP
8CD9 00           |           NOP
8CDA 00           |           NOP
8CDB 00           |           NOP
8CDC 00           |           NOP
8CDD 00           |           NOP
8CDE 00           |           NOP
8CDF 00           |           NOP
8CE0 00           |           NOP
8CE1 00           |           NOP
8CE2 00           |           NOP
8CE3 00           |           NOP
8CE4 00           |           NOP
8CE5 00           |           NOP
8CE6 00           |           NOP
8CE7 00           |           NOP
8CE8 00           |           NOP
8CE9 FF           |           RST $38
8CEA 00           |           NOP
8CEB 00           |           NOP
8CEC 00           |           NOP
8CED 00           |           NOP
8CEE 00           |           NOP
8CEF 00           |           NOP
8CF0 00           |           NOP
8CF1 00           |           NOP
8CF2 00           |           NOP
8CF3 00           |           NOP
8CF4 00           |           NOP
8CF5 00           |           NOP
8CF6 00           |           NOP
8CF7 00           |           NOP
8CF8 00           |           NOP
8CF9 16 9B        |           LD D,9Bh
8CFB 61           |           LD H,C
8CFC FE 43        |           CP 43h
8CFE 50           |           LD D,B
8CFF 4C           |           LD C,H
8D00 00           |           NOP
8D01 FF           |           RST $38
8D02 ED 44        |           NEG
8D04 3F           |           CCF
8D05 00           |           NOP
8D06 00           |           NOP
8D07 FF           |           RST $38
8D08 AA           |           XOR D
8D09 CC BB EE     |           CALL Z,EEBBh
8D0C DD           |           *ILLEGAL*
8D0D 11 44 88     |           LD DE,8844h
8D10 DD 77 FD     |           LD (IX+FDh),A
8D13 34           |           INC (HL)
8D14 12           |           LD (DE),A
8D15 00           |           NOP
8D16 C0           |           RET NZ
8D17 00           |           NOP
8D18 00           |           NOP
8D19 00           |           NOP
8D1A 00           |           NOP
8D1B 00           |           NOP
8D1C 00           |           NOP
8D1D FF           |           RST $38
8D1E 00           |           NOP
8D1F 00           |           NOP
8D20 00           |           NOP
8D21 00           |           NOP
8D22 00           |           NOP
8D23 00           |           NOP
8D24 00           |           NOP
8D25 00           |           NOP
8D26 00           |           NOP
8D27 00           |           NOP
8D28 00           |           NOP
8D29 00           |           NOP
8D2A 00           |           NOP
8D2B 00           |           NOP
8D2C 00           |           NOP
8D2D 00           |           NOP
8D2E 00           |           NOP
8D2F 00           |           NOP
8D30 00           |           NOP
8D31 FF           |           RST $38
8D32 00           |           NOP
8D33 00           |           NOP
8D34 00           |           NOP
8D35 00           |           NOP
8D36 00           |           NOP
8D37 00           |           NOP
8D38 00           |           NOP
8D39 00           |           NOP
8D3A 00           |           NOP
8D3B 00           |           NOP
8D3C 00           |           NOP
8D3D 00           |           NOP
8D3E 00           |           NOP
8D3F 00           |           NOP
8D40 00           |           NOP
8D41 B8           |           CP B
8D42 8D           |           ADC A,L
8D43 D2 D9 4E     |           JP NC,4ED9h
8D46 45           |           LD B,L
8D47 47           |           LD B,A
8D48 00           |           NOP
8D49 FF           |           RST $38
8D4A ED 44        |           NEG
8D4C 3F           |           CCF
8D4D 00           |           NOP
8D4E 00           |           NOP
8D4F FF           |           RST $38
8D50 AA           |           XOR D
8D51 CC BB EE     |           CALL Z,EEBBh
8D54 DD           |           *ILLEGAL*
8D55 11 44 88     |           LD DE,8844h
8D58 DD 77 FD     |           LD (IX+FDh),A
8D5B 34           |           INC (HL)
8D5C 12           |           LD (DE),A
8D5D 00           |           NOP
8D5E C0           |           RET NZ
8D5F 00           |           NOP
8D60 38 00        |           JR C,8D62h
8D62 00           |           NOP
8D63 00           |           NOP
8D64 00           |           NOP
8D65 00           |           NOP
8D66 00           |           NOP
8D67 00           |           NOP
8D68 00           |           NOP
8D69 00           |           NOP
8D6A 00           |           NOP
8D6B 00           |           NOP
8D6C 00           |           NOP
8D6D 00           |           NOP
8D6E 00           |           NOP
8D6F 00           |           NOP
8D70 00           |           NOP
8D71 00           |           NOP
8D72 00           |           NOP
8D73 00           |           NOP
8D74 00           |           NOP
8D75 00           |           NOP
8D76 00           |           NOP
8D77 00           |           NOP
8D78 00           |           NOP
8D79 FF           |           RST $38
8D7A FF           |           RST $38
8D7B 00           |           NOP
8D7C 00           |           NOP
8D7D 00           |           NOP
8D7E 00           |           NOP
8D7F 00           |           NOP
8D80 00           |           NOP
8D81 00           |           NOP
8D82 00           |           NOP
8D83 00           |           NOP
8D84 00           |           NOP
8D85 00           |           NOP
8D86 00           |           NOP
8D87 00           |           NOP
8D88 00           |           NOP
8D89 72           |           LD (HL),D
8D8A 82           |           ADD A,D
8D8B AC           |           XOR H
8D8C DA 4E 45     |           JP C,454Eh
8D8F 47           |           LD B,A
8D90 27           |           DAA
8D91 00           |           NOP
8D92 FF           |           RST $38
8D93 C6 00        |           ADD A,00h
8D95 3F           |           CCF
8D96 00           |           NOP
8D97 00           |           NOP
8D98 FF           |           RST $38
8D99 AA           |           XOR D
8D9A CC BB EE     |           CALL Z,EEBBh
8D9D DD           |           *ILLEGAL*
8D9E 11 44 88     |           LD DE,8844h
8DA1 DD 77 FD     |           LD (IX+FDh),A
8DA4 34           |           INC (HL)
8DA5 12           |           LD (DE),A
8DA6 00           |           NOP
8DA7 C0           |           RET NZ
8DA8 00           |           NOP
8DA9 00           |           NOP
8DAA 00           |           NOP
8DAB 00           |           NOP
8DAC 00           |           NOP
8DAD 00           |           NOP
8DAE FF           |           RST $38
8DAF 00           |           NOP
8DB0 00           |           NOP
8DB1 00           |           NOP
8DB2 00           |           NOP
8DB3 00           |           NOP
8DB4 00           |           NOP
8DB5 00           |           NOP
8DB6 00           |           NOP
8DB7 00           |           NOP
8DB8 00           |           NOP
8DB9 00           |           NOP
8DBA 00           |           NOP
8DBB 00           |           NOP
8DBC 00           |           NOP
8DBD 00           |           NOP
8DBE FF           |           RST $38
8DBF 00           |           NOP
8DC0 00           |           NOP
8DC1 00           |           NOP
8DC2 FF           |           RST $38
8DC3 00           |           NOP
8DC4 00           |           NOP
8DC5 00           |           NOP
8DC6 00           |           NOP
8DC7 00           |           NOP
8DC8 00           |           NOP
8DC9 00           |           NOP
8DCA 00           |           NOP
8DCB 00           |           NOP
8DCC 00           |           NOP
8DCD 00           |           NOP
8DCE 00           |           NOP
8DCF 00           |           NOP
8DD0 00           |           NOP
8DD1 00           |           NOP
8DD2 45           |           LD B,L
8DD3 81           |           ADD A,C
8DD4 11 C4 41     |           LD DE,41C4h
8DD7 44           |           LD B,H
8DD8 44           |           LD B,H
8DD9 20 41        |           JR NZ,8E1Ch
8DDB 2C           |           INC L
8DDC 4E           |           LD C,(HL)
8DDD 00           |           NOP
8DDE FF           |           RST $38
8DDF CE 00        |           ADC A,00h
8DE1 3F           |           CCF
8DE2 00           |           NOP
8DE3 00           |           NOP
8DE4 FF           |           RST $38
8DE5 AA           |           XOR D
8DE6 CC BB EE     |           CALL Z,EEBBh
8DE9 DD           |           *ILLEGAL*
8DEA 11 44 88     |           LD DE,8844h
8DED DD 77 FD     |           LD (IX+FDh),A
8DF0 34           |           INC (HL)
8DF1 12           |           LD (DE),A
8DF2 00           |           NOP
8DF3 C0           |           RET NZ
8DF4 00           |           NOP
8DF5 00           |           NOP
8DF6 00           |           NOP
8DF7 00           |           NOP
8DF8 00           |           NOP
8DF9 01 FF 00     |           LD BC,00FFh
8DFC 00           |           NOP
8DFD 00           |           NOP
8DFE 00           |           NOP
8DFF 00           |           NOP
8E00 00           |           NOP
8E01 00           |           NOP
8E02 00           |           NOP
8E03 00           |           NOP
8E04 00           |           NOP
8E05 00           |           NOP
8E06 00           |           NOP
8E07 00           |           NOP
8E08 00           |           NOP
8E09 00           |           NOP
8E0A FF           |           RST $38
8E0B 00           |           NOP
8E0C 00           |           NOP
8E0D 00           |           NOP
8E0E FE 00        |           CP 00h
8E10 00           |           NOP
8E11 00           |           NOP
8E12 00           |           NOP
8E13 00           |           NOP
8E14 00           |           NOP
8E15 00           |           NOP
8E16 00           |           NOP
8E17 00           |           NOP
8E18 00           |           NOP
8E19 00           |           NOP
8E1A 00           |           NOP
8E1B 00           |           NOP
8E1C 00           |           NOP
8E1D 00           |           NOP
8E1E 2B           |           DEC HL
8E1F 5B           |           LD E,E
8E20 8E           |           ADC A,(HL)
8E21 14           |           INC D
8E22 41           |           LD B,C
8E23 44           |           LD B,H
8E24 43           |           LD B,E
8E25 20 41        |           JR NZ,8E68h
8E27 2C           |           INC L
8E28 4E           |           LD C,(HL)
8E29 00           |           NOP
8E2A FF           |           RST $38
8E2B D6 00        |           SUB A,00h
8E2D 3F           |           CCF
8E2E 00           |           NOP
8E2F 00           |           NOP
8E30 FF           |           RST $38
8E31 AA           |           XOR D
8E32 CC BB EE     |           CALL Z,EEBBh
8E35 DD           |           *ILLEGAL*
8E36 11 44 88     |           LD DE,8844h
8E39 DD 77 FD     |           LD (IX+FDh),A
8E3C 34           |           INC (HL)
8E3D 12           |           LD (DE),A
8E3E 00           |           NOP
8E3F C0           |           RET NZ
8E40 00           |           NOP
8E41 00           |           NOP
8E42 00           |           NOP
8E43 00           |           NOP
8E44 00           |           NOP
8E45 00           |           NOP
8E46 FF           |           RST $38
8E47 00           |           NOP
8E48 00           |           NOP
8E49 00           |           NOP
8E4A 00           |           NOP
8E4B 00           |           NOP
8E4C 00           |           NOP
8E4D 00           |           NOP
8E4E 00           |           NOP
8E4F 00           |           NOP
8E50 00           |           NOP
8E51 00           |           NOP
8E52 00           |           NOP
8E53 00           |           NOP
8E54 00           |           NOP
8E55 00           |           NOP
8E56 FF           |           RST $38
8E57 00           |           NOP
8E58 00           |           NOP
8E59 00           |           NOP
8E5A FF           |           RST $38
8E5B 00           |           NOP
8E5C 00           |           NOP
8E5D 00           |           NOP
8E5E 00           |           NOP
8E5F 00           |           NOP
8E60 00           |           NOP
8E61 00           |           NOP
8E62 00           |           NOP
8E63 00           |           NOP
8E64 00           |           NOP
8E65 00           |           NOP
8E66 00           |           NOP
8E67 00           |           NOP
8E68 00           |           NOP
8E69 00           |           NOP
8E6A 68           |           LD L,B
8E6B D3 29        |           OUT (29h),A
8E6D 73           |           LD (HL),E
8E6E 53           |           LD D,E
8E6F 55           |           LD D,L
8E70 42           |           LD B,D
8E71 20 41        |           JR NZ,8EB4h
8E73 2C           |           INC L
8E74 4E           |           LD C,(HL)
8E75 00           |           NOP
8E76 FF           |           RST $38
8E77 DE 00        |           SBC A,00h
8E79 3F           |           CCF
8E7A 00           |           NOP
8E7B 00           |           NOP
8E7C FF           |           RST $38
8E7D AA           |           XOR D
8E7E CC BB EE     |           CALL Z,EEBBh
8E81 DD           |           *ILLEGAL*
8E82 11 44 88     |           LD DE,8844h
8E85 DD 77 FD     |           LD (IX+FDh),A
8E88 34           |           INC (HL)
8E89 12           |           LD (DE),A
8E8A 00           |           NOP
8E8B C0           |           RET NZ
8E8C 00           |           NOP
8E8D 00           |           NOP
8E8E 00           |           NOP
8E8F 00           |           NOP
8E90 00           |           NOP
8E91 01 FF 00     |           LD BC,00FFh
8E94 00           |           NOP
8E95 00           |           NOP
8E96 00           |           NOP
8E97 00           |           NOP
8E98 00           |           NOP
8E99 00           |           NOP
8E9A 00           |           NOP
8E9B 00           |           NOP
8E9C 00           |           NOP
8E9D 00           |           NOP
8E9E 00           |           NOP
8E9F 00           |           NOP
8EA0 00           |           NOP
8EA1 00           |           NOP
8EA2 FF           |           RST $38
8EA3 00           |           NOP
8EA4 00           |           NOP
8EA5 00           |           NOP
8EA6 FE 00        |           CP 00h
8EA8 00           |           NOP
8EA9 00           |           NOP
8EAA 00           |           NOP
8EAB 00           |           NOP
8EAC 00           |           NOP
8EAD 00           |           NOP
8EAE 00           |           NOP
8EAF 00           |           NOP
8EB0 00           |           NOP
8EB1 00           |           NOP
8EB2 00           |           NOP
8EB3 00           |           NOP
8EB4 00           |           NOP
8EB5 00           |           NOP
8EB6 F7           |           RST $30
8EB7 4A           |           LD C,D
8EB8 E0           |           RET PO
8EB9 63           |           LD H,E
8EBA 53           |           LD D,E
8EBB 42           |           LD B,D
8EBC 43           |           LD B,E
8EBD 20 41        |           JR NZ,8F00h
8EBF 2C           |           INC L
8EC0 4E           |           LD C,(HL)
8EC1 00           |           NOP
8EC2 FF           |           RST $38
8EC3 E6 00        |           AND 00h
8EC5 3F           |           CCF
8EC6 00           |           NOP
8EC7 00           |           NOP
8EC8 FF           |           RST $38
8EC9 AA           |           XOR D
8ECA CC BB EE     |           CALL Z,EEBBh
8ECD DD           |           *ILLEGAL*
8ECE 11 44 88     |           LD DE,8844h
8ED1 DD 77 FD     |           LD (IX+FDh),A
8ED4 34           |           INC (HL)
8ED5 12           |           LD (DE),A
8ED6 00           |           NOP
8ED7 C0           |           RET NZ
8ED8 00           |           NOP
8ED9 00           |           NOP
8EDA 00           |           NOP
8EDB 00           |           NOP
8EDC 00           |           NOP
8EDD 00           |           NOP
8EDE FF           |           RST $38
8EDF 00           |           NOP
8EE0 00           |           NOP
8EE1 00           |           NOP
8EE2 00           |           NOP
8EE3 00           |           NOP
8EE4 00           |           NOP
8EE5 00           |           NOP
8EE6 00           |           NOP
8EE7 00           |           NOP
8EE8 00           |           NOP
8EE9 00           |           NOP
8EEA 00           |           NOP
8EEB 00           |           NOP
8EEC 00           |           NOP
8EED 00           |           NOP
8EEE FF           |           RST $38
8EEF 00           |           NOP
8EF0 00           |           NOP
8EF1 00           |           NOP
8EF2 FF           |           RST $38
8EF3 00           |           NOP
8EF4 00           |           NOP
8EF5 00           |           NOP
8EF6 00           |           NOP
8EF7 00           |           NOP
8EF8 00           |           NOP
8EF9 00           |           NOP
8EFA 00           |           NOP
8EFB 00           |           NOP
8EFC 00           |           NOP
8EFD 00           |           NOP
8EFE 00           |           NOP
8EFF 00           |           NOP
8F00 00           |           NOP
8F01 00           |           NOP
8F02 4D           |           LD C,L
8F03 1C           |           INC E
8F04 8C           |           ADC A,H
8F05 24           |           INC H
8F06 41           |           LD B,C
8F07 4E           |           LD C,(HL)
8F08 44           |           LD B,H
8F09 20 4E        |           JR NZ,8F59h
8F0B 00           |           NOP
8F0C FF           |           RST $38
8F0D EE 00        |           XOR 00h
8F0F 3F           |           CCF
8F10 00           |           NOP
8F11 00           |           NOP
8F12 FF           |           RST $38
8F13 AA           |           XOR D
8F14 CC BB EE     |           CALL Z,EEBBh
8F17 DD           |           *ILLEGAL*
8F18 11 44 88     |           LD DE,8844h
8F1B DD 77 FD     |           LD (IX+FDh),A
8F1E 34           |           INC (HL)
8F1F 12           |           LD (DE),A
8F20 00           |           NOP
8F21 C0           |           RET NZ
8F22 00           |           NOP
8F23 00           |           NOP
8F24 00           |           NOP
8F25 00           |           NOP
8F26 00           |           NOP
8F27 00           |           NOP
8F28 FF           |           RST $38
8F29 00           |           NOP
8F2A 00           |           NOP
8F2B 00           |           NOP
8F2C 00           |           NOP
8F2D 00           |           NOP
8F2E 00           |           NOP
8F2F 00           |           NOP
8F30 00           |           NOP
8F31 00           |           NOP
8F32 00           |           NOP
8F33 00           |           NOP
8F34 00           |           NOP
8F35 00           |           NOP
8F36 00           |           NOP
8F37 00           |           NOP
8F38 FF           |           RST $38
8F39 00           |           NOP
8F3A 00           |           NOP
8F3B 00           |           NOP
8F3C FF           |           RST $38
8F3D 00           |           NOP
8F3E 00           |           NOP
8F3F 00           |           NOP
8F40 00           |           NOP
8F41 00           |           NOP
8F42 00           |           NOP
8F43 00           |           NOP
8F44 00           |           NOP
8F45 00           |           NOP
8F46 00           |           NOP
8F47 00           |           NOP
8F48 00           |           NOP
8F49 00           |           NOP
8F4A 00           |           NOP
8F4B 00           |           NOP
8F4C F3           |           DI
8F4D 7B           |           LD A,E
8F4E 32 2F 58     |           LD (582Fh),A
8F51 4F           |           LD C,A
8F52 52           |           LD D,D
8F53 20 4E        |           JR NZ,8FA3h
8F55 00           |           NOP
8F56 FF           |           RST $38
8F57 F6 00        |           OR 00h
8F59 3F           |           CCF
8F5A 00           |           NOP
8F5B 00           |           NOP
8F5C FF           |           RST $38
8F5D AA           |           XOR D
8F5E CC BB EE     |           CALL Z,EEBBh
8F61 DD           |           *ILLEGAL*
8F62 11 44 88     |           LD DE,8844h
8F65 DD 77 FD     |           LD (IX+FDh),A
8F68 34           |           INC (HL)
8F69 12           |           LD (DE),A
8F6A 00           |           NOP
8F6B C0           |           RET NZ
8F6C 00           |           NOP
8F6D 00           |           NOP
8F6E 00           |           NOP
8F6F 00           |           NOP
8F70 00           |           NOP
8F71 00           |           NOP
8F72 FF           |           RST $38
8F73 00           |           NOP
8F74 00           |           NOP
8F75 00           |           NOP
8F76 00           |           NOP
8F77 00           |           NOP
8F78 00           |           NOP
8F79 00           |           NOP
8F7A 00           |           NOP
8F7B 00           |           NOP
8F7C 00           |           NOP
8F7D 00           |           NOP
8F7E 00           |           NOP
8F7F 00           |           NOP
8F80 00           |           NOP
8F81 00           |           NOP
8F82 FF           |           RST $38
8F83 00           |           NOP
8F84 00           |           NOP
8F85 00           |           NOP
8F86 FF           |           RST $38
8F87 00           |           NOP
8F88 00           |           NOP
8F89 00           |           NOP
8F8A 00           |           NOP
8F8B 00           |           NOP
8F8C 00           |           NOP
8F8D 00           |           NOP
8F8E 00           |           NOP
8F8F 00           |           NOP
8F90 00           |           NOP
8F91 00           |           NOP
8F92 00           |           NOP
8F93 00           |           NOP
8F94 00           |           NOP
8F95 00           |           NOP
8F96 C2 95 4C     |           JP NZ,4C95h
8F99 03           |           INC BC
8F9A 4F           |           LD C,A
8F9B 52           |           LD D,D
8F9C 20 4E        |           JR NZ,8FECh
8F9E 00           |           NOP
8F9F FF           |           RST $38
8FA0 FE 00        |           CP 00h
8FA2 3F           |           CCF
8FA3 00           |           NOP
8FA4 00           |           NOP
8FA5 FF           |           RST $38
8FA6 AA           |           XOR D
8FA7 CC BB EE     |           CALL Z,EEBBh
8FAA DD           |           *ILLEGAL*
8FAB 11 44 88     |           LD DE,8844h
8FAE DD 77 FD     |           LD (IX+FDh),A
8FB1 34           |           INC (HL)
8FB2 12           |           LD (DE),A
8FB3 00           |           NOP
8FB4 C0           |           RET NZ
8FB5 00           |           NOP
8FB6 00           |           NOP
8FB7 00           |           NOP
8FB8 00           |           NOP
8FB9 00           |           NOP
8FBA 00           |           NOP
8FBB FF           |           RST $38
8FBC 00           |           NOP
8FBD 00           |           NOP
8FBE 00           |           NOP
8FBF 00           |           NOP
8FC0 00           |           NOP
8FC1 00           |           NOP
8FC2 00           |           NOP
8FC3 00           |           NOP
8FC4 00           |           NOP
8FC5 00           |           NOP
8FC6 00           |           NOP
8FC7 00           |           NOP
8FC8 00           |           NOP
8FC9 00           |           NOP
8FCA 00           |           NOP
8FCB FF           |           RST $38
8FCC 00           |           NOP
8FCD 00           |           NOP
8FCE 00           |           NOP
8FCF FF           |           RST $38
8FD0 00           |           NOP
8FD1 00           |           NOP
8FD2 00           |           NOP
8FD3 00           |           NOP
8FD4 00           |           NOP
8FD5 00           |           NOP
8FD6 00           |           NOP
8FD7 00           |           NOP
8FD8 00           |           NOP
8FD9 00           |           NOP
8FDA 00           |           NOP
8FDB 00           |           NOP
8FDC 00           |           NOP
8FDD 00           |           NOP
8FDE 00           |           NOP
8FDF 11 5D F8     |           LD DE,F85Dh
8FE2 6A           |           LD L,D
8FE3 43           |           LD B,E
8FE4 50           |           LD D,B
8FE5 20 4E        |           JR NZ,9035h
8FE7 00           |           NOP
8FE8 FF           |           RST $38
8FE9 87           |           ADD A,A
8FEA 3F           |           CCF
8FEB 00           |           NOP
8FEC 00           |           NOP
8FED 00           |           NOP
8FEE FF           |           RST $38
8FEF 00           |           NOP
8FF0 CC BB EE     |           CALL Z,EEBBh
8FF3 DD           |           *ILLEGAL*
8FF4 11 44 88     |           LD DE,8844h
8FF7 DD 77 FD     |           LD (IX+FDh),A
8FFA 34           |           INC (HL)
8FFB 12           |           LD (DE),A
8FFC 00           |           NOP
8FFD C0           |           RET NZ
8FFE 38 00        |           JR C,9000h
9000 00           |           NOP
9001 00           |           NOP
9002 00           |           NOP
9003 00           |           NOP
9004 FF           |           RST $38
9005 00           |           NOP
9006 00           |           NOP
9007 00           |           NOP
9008 00           |           NOP
9009 00           |           NOP
900A 00           |           NOP
900B 00           |           NOP
900C 00           |           NOP
900D 00           |           NOP
900E 00           |           NOP
900F 00           |           NOP
9010 00           |           NOP
9011 00           |           NOP
9012 00           |           NOP
9013 00           |           NOP
9014 00           |           NOP
9015 00           |           NOP
9016 00           |           NOP
9017 00           |           NOP
9018 FF           |           RST $38
9019 00           |           NOP
901A 00           |           NOP
901B 00           |           NOP
901C 00           |           NOP
901D 00           |           NOP
901E 00           |           NOP
901F 00           |           NOP
9020 00           |           NOP
9021 00           |           NOP
9022 00           |           NOP
9023 00           |           NOP
9024 00           |           NOP
9025 00           |           NOP
9026 00           |           NOP
9027 00           |           NOP
9028 5B           |           LD E,E
9029 A4           |           AND H
902A 54           |           LD D,H
902B 9A           |           SBC A,D
902C 41           |           LD B,C
902D 4C           |           LD C,H
902E 4F           |           LD C,A
902F 20 41        |           JR NZ,9072h
9031 2C           |           INC L
9032 41           |           LD B,C
9033 00           |           NOP
9034 FF           |           RST $38
9035 80           |           ADD A,B
9036 3F           |           CCF
9037 00           |           NOP
9038 00           |           NOP
9039 00           |           NOP
903A FF           |           RST $38
903B 00           |           NOP
903C 00           |           NOP
903D 00           |           NOP
903E EE DD        |           XOR DDh
9040 11 44 88     |           LD DE,8844h
9043 DD 77 FD     |           LD (IX+FDh),A
9046 34           |           INC (HL)
9047 12           |           LD (DE),A
9048 00           |           NOP
9049 C0           |           RET NZ
904A 39           |           ADD HL,SP
904B 00           |           NOP
904C 00           |           NOP
904D 00           |           NOP
904E 00           |           NOP
904F 00           |           NOP
9050 C8           |           RET Z
9051 00           |           NOP
9052 00           |           NOP
9053 00           |           NOP
9054 00           |           NOP
9055 00           |           NOP
9056 00           |           NOP
9057 00           |           NOP
9058 00           |           NOP
9059 00           |           NOP
905A 00           |           NOP
905B 00           |           NOP
905C 00           |           NOP
905D 00           |           NOP
905E 00           |           NOP
905F 00           |           NOP
9060 00           |           NOP
9061 00           |           NOP
9062 00           |           NOP
9063 00           |           NOP
9064 FF           |           RST $38
9065 37           |           SCF
9066 FF           |           RST $38
9067 FF           |           RST $38
9068 00           |           NOP
9069 00           |           NOP
906A 00           |           NOP
906B 00           |           NOP
906C 00           |           NOP
906D 00           |           NOP
906E 00           |           NOP
906F 00           |           NOP
9070 00           |           NOP
9071 00           |           NOP
9072 00           |           NOP
9073 00           |           NOP
9074 94           |           SUB A,H
9075 99           |           SBC A,C
9076 28 3B        |           JR Z,90B3h
9078 41           |           LD B,C
9079 4C           |           LD C,H
907A 4F           |           LD C,A
907B 20 41        |           JR NZ,90BEh
907D 2C           |           INC L
907E 5B           |           LD E,E
907F 42           |           LD B,D
9080 2C           |           INC L
9081 43           |           LD B,E
9082 5D           |           LD E,L
9083 00           |           NOP
9084 FF           |           RST $38
9085 82           |           ADD A,D
9086 3F           |           CCF
9087 00           |           NOP
9088 00           |           NOP
9089 00           |           NOP
908A FF           |           RST $38
908B 00           |           NOP
908C CC BB 00     |           CALL Z,00BBh
908F 00           |           NOP
9090 11 44 88     |           LD DE,8844h
9093 DD 77 FD     |           LD (IX+FDh),A
9096 34           |           INC (HL)
9097 12           |           LD (DE),A
9098 00           |           NOP
9099 C0           |           RET NZ
909A 39           |           ADD HL,SP
909B 00           |           NOP
909C 00           |           NOP
909D 00           |           NOP
909E 00           |           NOP
909F 00           |           NOP
90A0 C8           |           RET Z
90A1 00           |           NOP
90A2 00           |           NOP
90A3 00           |           NOP
90A4 00           |           NOP
90A5 00           |           NOP
90A6 00           |           NOP
90A7 00           |           NOP
90A8 00           |           NOP
90A9 00           |           NOP
90AA 00           |           NOP
90AB 00           |           NOP
90AC 00           |           NOP
90AD 00           |           NOP
90AE 00           |           NOP
90AF 00           |           NOP
90B0 00           |           NOP
90B1 00           |           NOP
90B2 00           |           NOP
90B3 00           |           NOP
90B4 FF           |           RST $38
90B5 37           |           SCF
90B6 00           |           NOP
90B7 00           |           NOP
90B8 FF           |           RST $38
90B9 FF           |           RST $38
90BA 00           |           NOP
90BB 00           |           NOP
90BC 00           |           NOP
90BD 00           |           NOP
90BE 00           |           NOP
90BF 00           |           NOP
90C0 00           |           NOP
90C1 00           |           NOP
90C2 00           |           NOP
90C3 00           |           NOP
90C4 94           |           SUB A,H
90C5 99           |           SBC A,C
90C6 28 3B        |           JR Z,9103h
90C8 41           |           LD B,C
90C9 4C           |           LD C,H
90CA 4F           |           LD C,A
90CB 20 41        |           JR NZ,910Eh
90CD 2C           |           INC L
90CE 5B           |           LD E,E
90CF 44           |           LD B,H
90D0 2C           |           INC L
90D1 45           |           LD B,L
90D2 5D           |           LD E,L
90D3 00           |           NOP
90D4 FF           |           RST $38
90D5 84           |           ADD A,H
90D6 3F           |           CCF
90D7 00           |           NOP
90D8 00           |           NOP
90D9 00           |           NOP
90DA FF           |           RST $38
90DB 00           |           NOP
90DC CC BB EE     |           CALL Z,EEBBh
90DF DD           |           *ILLEGAL*
90E0 00           |           NOP
90E1 00           |           NOP
90E2 88           |           ADC A,B
90E3 DD 77 FD     |           LD (IX+FDh),A
90E6 34           |           INC (HL)
90E7 12           |           LD (DE),A
90E8 00           |           NOP
90E9 C0           |           RET NZ
90EA 39           |           ADD HL,SP
90EB 00           |           NOP
90EC 00           |           NOP
90ED 00           |           NOP
90EE 00           |           NOP
90EF 00           |           NOP
90F0 C8           |           RET Z
90F1 00           |           NOP
90F2 00           |           NOP
90F3 00           |           NOP
90F4 00           |           NOP
90F5 00           |           NOP
90F6 00           |           NOP
90F7 00           |           NOP
90F8 00           |           NOP
90F9 00           |           NOP
90FA 00           |           NOP
90FB 00           |           NOP
90FC 00           |           NOP
90FD 00           |           NOP
90FE 00           |           NOP
90FF 00           |           NOP
9100 00           |           NOP
9101 00           |           NOP
9102 00           |           NOP
9103 00           |           NOP
9104 FF           |           RST $38
9105 37           |           SCF
9106 00           |           NOP
9107 00           |           NOP
9108 00           |           NOP
9109 00           |           NOP
910A FF           |           RST $38
910B FF           |           RST $38
910C 00           |           NOP
910D 00           |           NOP
910E 00           |           NOP
910F 00           |           NOP
9110 00           |           NOP
9111 00           |           NOP
9112 00           |           NOP
9113 00           |           NOP
9114 94           |           SUB A,H
9115 99           |           SBC A,C
9116 28 3B        |           JR Z,9153h
9118 41           |           LD B,C
9119 4C           |           LD C,H
911A 4F           |           LD C,A
911B 20 41        |           JR NZ,915Eh
911D 2C           |           INC L
911E 5B           |           LD E,E
911F 48           |           LD C,B
9120 2C           |           INC L
9121 4C           |           LD C,H
9122 5D           |           LD E,L
9123 00           |           NOP
9124 FF           |           RST $38
9125 86           |           ADD A,(HL)
9126 3F           |           CCF
9127 00           |           NOP
9128 00           |           NOP
9129 00           |           NOP
912A FF           |           RST $38
912B 00           |           NOP
912C CC BB EE     |           CALL Z,EEBBh
912F DD           |           *ILLEGAL*
9130 0C           |           INC C
9131 88           |           ADC A,B
9132 88           |           ADC A,B
9133 DD 77 FD     |           LD (IX+FDh),A
9136 00           |           NOP
9137 12           |           LD (DE),A
9138 00           |           NOP
9139 C0           |           RET NZ
913A 38 00        |           JR C,913Ch
913C 00           |           NOP
913D 00           |           NOP
913E 00           |           NOP
913F 00           |           NOP
9140 C8           |           RET Z
9141 00           |           NOP
9142 00           |           NOP
9143 00           |           NOP
9144 00           |           NOP
9145 00           |           NOP
9146 00           |           NOP
9147 00           |           NOP
9148 00           |           NOP
9149 00           |           NOP
914A 00           |           NOP
914B 00           |           NOP
914C 00           |           NOP
914D 00           |           NOP
914E 00           |           NOP
914F 00           |           NOP
9150 00           |           NOP
9151 00           |           NOP
9152 00           |           NOP
9153 00           |           NOP
9154 FF           |           RST $38
9155 37           |           SCF
9156 00           |           NOP
9157 00           |           NOP
9158 00           |           NOP
9159 00           |           NOP
915A 01 00 00     |           LD BC,0000h
915D 00           |           NOP
915E 00           |           NOP
915F 00           |           NOP
9160 FF           |           RST $38
9161 00           |           NOP
9162 00           |           NOP
9163 00           |           NOP
9164 C9           |           RET
9165 F8           |           RET M
9166 7D           |           LD A,L
9167 81           |           ADD A,C
9168 41           |           LD B,C
9169 4C           |           LD C,H
916A 4F           |           LD C,A
916B 20 41        |           JR NZ,91AEh
916D 2C           |           INC L
916E 28 48        |           JR Z,91B8h
9170 4C           |           LD C,H
9171 29           |           ADD HL,HL
9172 00           |           NOP
9173 FF           |           RST $38
9174 DD 84        |           ADD A,IXH
9176 3F           |           CCF
9177 00           |           NOP
9178 00           |           NOP
9179 FF           |           RST $38
917A 00           |           NOP
917B CC BB EE     |           CALL Z,EEBBh
917E DD           |           *ILLEGAL*
917F 11 44 00     |           LD DE,0044h
9182 00           |           NOP
9183 77           |           LD (HL),A
9184 FD 34 12     |           INC (IY+12h)
9187 00           |           NOP
9188 C0           |           RET NZ
9189 00           |           NOP
918A 39           |           ADD HL,SP
918B 00           |           NOP
918C 00           |           NOP
918D 00           |           NOP
918E 00           |           NOP
918F C8           |           RET Z
9190 00           |           NOP
9191 00           |           NOP
9192 00           |           NOP
9193 00           |           NOP
9194 00           |           NOP
9195 00           |           NOP
9196 00           |           NOP
9197 00           |           NOP
9198 00           |           NOP
9199 00           |           NOP
919A 00           |           NOP
919B 00           |           NOP
919C 00           |           NOP
919D 00           |           NOP
919E 00           |           NOP
919F 00           |           NOP
91A0 00           |           NOP
91A1 00           |           NOP
91A2 00           |           NOP
91A3 FF           |           RST $38
91A4 37           |           SCF
91A5 00           |           NOP
91A6 00           |           NOP
91A7 00           |           NOP
91A8 00           |           NOP
91A9 00           |           NOP
91AA 00           |           NOP
91AB FF           |           RST $38
91AC FF           |           RST $38
91AD 00           |           NOP
91AE 00           |           NOP
91AF 00           |           NOP
91B0 00           |           NOP
91B1 00           |           NOP
91B2 00           |           NOP
91B3 94           |           SUB A,H
91B4 99           |           SBC A,C
91B5 28 3B        |           JR Z,91F2h
91B7 41           |           LD B,C
91B8 4C           |           LD C,H
91B9 4F           |           LD C,A
91BA 20 41        |           JR NZ,91FDh
91BC 2C           |           INC L
91BD 5B           |           LD E,E
91BE 48           |           LD C,B
91BF 58           |           LD E,B
91C0 2C           |           INC L
91C1 4C           |           LD C,H
91C2 58           |           LD E,B
91C3 5D           |           LD E,L
91C4 00           |           NOP
91C5 FF           |           RST $38
91C6 FD 84        |           ADD A,IYH
91C8 3F           |           CCF
91C9 00           |           NOP
91CA 00           |           NOP
91CB FF           |           RST $38
91CC 00           |           NOP
91CD CC BB EE     |           CALL Z,EEBBh
91D0 DD           |           *ILLEGAL*
91D1 11 44 88     |           LD DE,8844h
91D4 DD           |           *ILLEGAL*
91D5 00           |           NOP
91D6 00           |           NOP
91D7 34           |           INC (HL)
91D8 12           |           LD (DE),A
91D9 00           |           NOP
91DA C0           |           RET NZ
91DB 00           |           NOP
91DC 39           |           ADD HL,SP
91DD 00           |           NOP
91DE 00           |           NOP
91DF 00           |           NOP
91E0 00           |           NOP
91E1 C8           |           RET Z
91E2 00           |           NOP
91E3 00           |           NOP
91E4 00           |           NOP
91E5 00           |           NOP
91E6 00           |           NOP
91E7 00           |           NOP
91E8 00           |           NOP
91E9 00           |           NOP
91EA 00           |           NOP
91EB 00           |           NOP
91EC 00           |           NOP
91ED 00           |           NOP
91EE 00           |           NOP
91EF 00           |           NOP
91F0 00           |           NOP
91F1 00           |           NOP
91F2 00           |           NOP
91F3 00           |           NOP
91F4 00           |           NOP
91F5 FF           |           RST $38
91F6 37           |           SCF
91F7 00           |           NOP
91F8 00           |           NOP
91F9 00           |           NOP
91FA 00           |           NOP
91FB 00           |           NOP
91FC 00           |           NOP
91FD 00           |           NOP
91FE 00           |           NOP
91FF FF           |           RST $38
9200 FF           |           RST $38
9201 00           |           NOP
9202 00           |           NOP
9203 00           |           NOP
9204 00           |           NOP
9205 94           |           SUB A,H
9206 99           |           SBC A,C
9207 28 3B        |           JR Z,9244h
9209 41           |           LD B,C
920A 4C           |           LD C,H
920B 4F           |           LD C,A
920C 20 41        |           JR NZ,924Fh
920E 2C           |           INC L
920F 5B           |           LD E,E
9210 48           |           LD C,B
9211 59           |           LD E,C
9212 2C           |           INC L
9213 4C           |           LD C,H
9214 59           |           LD E,C
9215 5D           |           LD E,L
9216 00           |           NOP
9217 FF           |           RST $38
9218 DD 86 00     |           ADD A,(IX+00h)
921B 3F           |           CCF
921C 00           |           NOP
921D FF           |           RST $38
921E 00           |           NOP
921F CC BB EE     |           CALL Z,EEBBh
9222 DD           |           *ILLEGAL*
9223 11 44 0C     |           LD DE,0C44h
9226 88           |           ADC A,B
9227 0C           |           INC C
9228 88           |           ADC A,B
9229 00           |           NOP
922A 12           |           LD (DE),A
922B 00           |           NOP
922C C0           |           RET NZ
922D 20 38        |           JR NZ,9267h
922F 00           |           NOP
9230 00           |           NOP
9231 00           |           NOP
9232 00           |           NOP
9233 C8           |           RET Z
9234 00           |           NOP
9235 00           |           NOP
9236 00           |           NOP
9237 00           |           NOP
9238 00           |           NOP
9239 00           |           NOP
923A 00           |           NOP
923B 00           |           NOP
923C 00           |           NOP
923D 00           |           NOP
923E 00           |           NOP
923F 00           |           NOP
9240 00           |           NOP
9241 00           |           NOP
9242 00           |           NOP
9243 00           |           NOP
9244 01 00 00     |           LD BC,0000h
9247 FF           |           RST $38
9248 37           |           SCF
9249 00           |           NOP
924A 00           |           NOP
924B 00           |           NOP
924C 00           |           NOP
924D 00           |           NOP
924E 00           |           NOP
924F 01 00 01     |           LD BC,0100h
9252 00           |           NOP
9253 FF           |           RST $38
9254 00           |           NOP
9255 00           |           NOP
9256 00           |           NOP
9257 12           |           LD (DE),A
9258 A5           |           AND L
9259 F6 2D        |           OR 2Dh
925B 41           |           LD B,C
925C 4C           |           LD C,H
925D 4F           |           LD C,A
925E 20 41        |           JR NZ,92A1h
9260 2C           |           INC L
9261 28 58        |           JR Z,92BBh
9263 59           |           LD E,C
9264 29           |           ADD HL,HL
9265 00           |           NOP
9266 FF           |           RST $38
9267 07           |           RLCA
9268 3F           |           CCF
9269 00           |           NOP
926A 00           |           NOP
926B 00           |           NOP
926C FF           |           RST $38
926D AA           |           XOR D
926E CC BB EE     |           CALL Z,EEBBh
9271 DD           |           *ILLEGAL*
9272 11 44 88     |           LD DE,8844h
9275 DD 77 FD     |           LD (IX+FDh),A
9278 34           |           INC (HL)
9279 12           |           LD (DE),A
927A 00           |           NOP
927B C0           |           RET NZ
927C 00           |           NOP
927D 00           |           NOP
927E 00           |           NOP
927F 00           |           NOP
9280 00           |           NOP
9281 01 FF 00     |           LD BC,00FFh
9284 00           |           NOP
9285 00           |           NOP
9286 00           |           NOP
9287 00           |           NOP
9288 00           |           NOP
9289 00           |           NOP
928A 00           |           NOP
928B 00           |           NOP
928C 00           |           NOP
928D 00           |           NOP
928E 00           |           NOP
928F 00           |           NOP
9290 00           |           NOP
9291 00           |           NOP
9292 00           |           NOP
9293 00           |           NOP
9294 00           |           NOP
9295 00           |           NOP
9296 FE 00        |           CP 00h
9298 00           |           NOP
9299 00           |           NOP
929A 00           |           NOP
929B 00           |           NOP
929C 00           |           NOP
929D 00           |           NOP
929E 00           |           NOP
929F 00           |           NOP
92A0 00           |           NOP
92A1 00           |           NOP
92A2 00           |           NOP
92A3 00           |           NOP
92A4 00           |           NOP
92A5 00           |           NOP
92A6 D5           |           PUSH DE
92A7 A7           |           AND A
92A8 0C           |           INC C
92A9 6A           |           LD L,D
92AA 52           |           LD D,D
92AB 4C           |           LD C,H
92AC 43           |           LD B,E
92AD 41           |           LD B,C
92AE 00           |           NOP
92AF FF           |           RST $38
92B0 0F           |           RRCA
92B1 3F           |           CCF
92B2 00           |           NOP
92B3 00           |           NOP
92B4 00           |           NOP
92B5 FF           |           RST $38
92B6 AA           |           XOR D
92B7 CC BB EE     |           CALL Z,EEBBh
92BA DD           |           *ILLEGAL*
92BB 11 44 88     |           LD DE,8844h
92BE DD 77 FD     |           LD (IX+FDh),A
92C1 34           |           INC (HL)
92C2 12           |           LD (DE),A
92C3 00           |           NOP
92C4 C0           |           RET NZ
92C5 00           |           NOP
92C6 00           |           NOP
92C7 00           |           NOP
92C8 00           |           NOP
92C9 00           |           NOP
92CA 01 FF 00     |           LD BC,00FFh
92CD 00           |           NOP
92CE 00           |           NOP
92CF 00           |           NOP
92D0 00           |           NOP
92D1 00           |           NOP
92D2 00           |           NOP
92D3 00           |           NOP
92D4 00           |           NOP
92D5 00           |           NOP
92D6 00           |           NOP
92D7 00           |           NOP
92D8 00           |           NOP
92D9 00           |           NOP
92DA 00           |           NOP
92DB 00           |           NOP
92DC 00           |           NOP
92DD 00           |           NOP
92DE 00           |           NOP
92DF FE 00        |           CP 00h
92E1 00           |           NOP
92E2 00           |           NOP
92E3 00           |           NOP
92E4 00           |           NOP
92E5 00           |           NOP
92E6 00           |           NOP
92E7 00           |           NOP
92E8 00           |           NOP
92E9 00           |           NOP
92EA 00           |           NOP
92EB 00           |           NOP
92EC 00           |           NOP
92ED 00           |           NOP
92EE 00           |           NOP
92EF B6           |           OR (HL)
92F0 B7           |           OR A
92F1 48           |           LD C,B
92F2 12           |           LD (DE),A
92F3 52           |           LD D,D
92F4 52           |           LD D,D
92F5 43           |           LD B,E
92F6 41           |           LD B,C
92F7 00           |           NOP
92F8 FF           |           RST $38
92F9 17           |           RLA
92FA 3F           |           CCF
92FB 00           |           NOP
92FC 00           |           NOP
92FD 00           |           NOP
92FE FF           |           RST $38
92FF AA           |           XOR D
9300 CC BB EE     |           CALL Z,EEBBh
9303 DD           |           *ILLEGAL*
9304 11 44 88     |           LD DE,8844h
9307 DD 77 FD     |           LD (IX+FDh),A
930A 34           |           INC (HL)
930B 12           |           LD (DE),A
930C 00           |           NOP
930D C0           |           RET NZ
930E 00           |           NOP
930F 00           |           NOP
9310 00           |           NOP
9311 00           |           NOP
9312 00           |           NOP
9313 01 FF 00     |           LD BC,00FFh
9316 00           |           NOP
9317 00           |           NOP
9318 00           |           NOP
9319 00           |           NOP
931A 00           |           NOP
931B 00           |           NOP
931C 00           |           NOP
931D 00           |           NOP
931E 00           |           NOP
931F 00           |           NOP
9320 00           |           NOP
9321 00           |           NOP
9322 00           |           NOP
9323 00           |           NOP
9324 00           |           NOP
9325 00           |           NOP
9326 00           |           NOP
9327 00           |           NOP
9328 FE 00        |           CP 00h
932A 00           |           NOP
932B 00           |           NOP
932C 00           |           NOP
932D 00           |           NOP
932E 00           |           NOP
932F 00           |           NOP
9330 00           |           NOP
9331 00           |           NOP
9332 00           |           NOP
9333 00           |           NOP
9334 00           |           NOP
9335 00           |           NOP
9336 00           |           NOP
9337 00           |           NOP
9338 D5           |           PUSH DE
9339 A7           |           AND A
933A 0C           |           INC C
933B 6A           |           LD L,D
933C 52           |           LD D,D
933D 4C           |           LD C,H
933E 41           |           LD B,C
933F 00           |           NOP
9340 FF           |           RST $38
9341 1F           |           RRA
9342 3F           |           CCF
9343 00           |           NOP
9344 00           |           NOP
9345 00           |           NOP
9346 FF           |           RST $38
9347 AA           |           XOR D
9348 CC BB EE     |           CALL Z,EEBBh
934B DD           |           *ILLEGAL*
934C 11 44 88     |           LD DE,8844h
934F DD 77 FD     |           LD (IX+FDh),A
9352 34           |           INC (HL)
9353 12           |           LD (DE),A
9354 00           |           NOP
9355 C0           |           RET NZ
9356 00           |           NOP
9357 00           |           NOP
9358 00           |           NOP
9359 00           |           NOP
935A 00           |           NOP
935B 01 FF 00     |           LD BC,00FFh
935E 00           |           NOP
935F 00           |           NOP
9360 00           |           NOP
9361 00           |           NOP
9362 00           |           NOP
9363 00           |           NOP
9364 00           |           NOP
9365 00           |           NOP
9366 00           |           NOP
9367 00           |           NOP
9368 00           |           NOP
9369 00           |           NOP
936A 00           |           NOP
936B 00           |           NOP
936C 00           |           NOP
936D 00           |           NOP
936E 00           |           NOP
936F 00           |           NOP
9370 FE 00        |           CP 00h
9372 00           |           NOP
9373 00           |           NOP
9374 00           |           NOP
9375 00           |           NOP
9376 00           |           NOP
9377 00           |           NOP
9378 00           |           NOP
9379 00           |           NOP
937A 00           |           NOP
937B 00           |           NOP
937C 00           |           NOP
937D 00           |           NOP
937E 00           |           NOP
937F 00           |           NOP
9380 B6           |           OR (HL)
9381 B7           |           OR A
9382 48           |           LD C,B
9383 12           |           LD (DE),A
9384 52           |           LD D,D
9385 52           |           LD D,D
9386 41           |           LD B,C
9387 00           |           NOP
9388 FF           |           RST $38
9389 ED 6F        |           RLD
938B 3F           |           CCF
938C 00           |           NOP
938D 00           |           NOP
938E FF           |           RST $38
938F 00           |           NOP
9390 CC BB EE     |           CALL Z,EEBBh
9393 DD           |           *ILLEGAL*
9394 0C           |           INC C
9395 88           |           ADC A,B
9396 88           |           ADC A,B
9397 DD 77 FD     |           LD (IX+FDh),A
939A 00           |           NOP
939B 12           |           LD (DE),A
939C 00           |           NOP
939D C0           |           RET NZ
939E 00           |           NOP
939F 00           |           NOP
93A0 00           |           NOP
93A1 00           |           NOP
93A2 00           |           NOP
93A3 00           |           NOP
93A4 88           |           ADC A,B
93A5 00           |           NOP
93A6 00           |           NOP
93A7 00           |           NOP
93A8 00           |           NOP
93A9 00           |           NOP
93AA 00           |           NOP
93AB 00           |           NOP
93AC 00           |           NOP
93AD 00           |           NOP
93AE 00           |           NOP
93AF 88           |           ADC A,B
93B0 00           |           NOP
93B1 00           |           NOP
93B2 00           |           NOP
93B3 00           |           NOP
93B4 00           |           NOP
93B5 00           |           NOP
93B6 00           |           NOP
93B7 00           |           NOP
93B8 FF           |           RST $38
93B9 77           |           LD (HL),A
93BA 00           |           NOP
93BB 00           |           NOP
93BC 00           |           NOP
93BD 00           |           NOP
93BE 00           |           NOP
93BF 00           |           NOP
93C0 00           |           NOP
93C1 00           |           NOP
93C2 00           |           NOP
93C3 00           |           NOP
93C4 77           |           LD (HL),A
93C5 00           |           NOP
93C6 00           |           NOP
93C7 00           |           NOP
93C8 FF           |           RST $38
93C9 A1           |           AND C
93CA B2           |           OR D
93CB A6           |           AND (HL)
93CC 52           |           LD D,D
93CD 4C           |           LD C,H
93CE 44           |           LD B,H
93CF 00           |           NOP
93D0 FF           |           RST $38
93D1 ED 67        |           RRD
93D3 3F           |           CCF
93D4 00           |           NOP
93D5 00           |           NOP
93D6 FF           |           RST $38
93D7 00           |           NOP
93D8 CC BB EE     |           CALL Z,EEBBh
93DB DD           |           *ILLEGAL*
93DC 0C           |           INC C
93DD 88           |           ADC A,B
93DE 88           |           ADC A,B
93DF DD 77 FD     |           LD (IX+FDh),A
93E2 00           |           NOP
93E3 12           |           LD (DE),A
93E4 00           |           NOP
93E5 C0           |           RET NZ
93E6 00           |           NOP
93E7 00           |           NOP
93E8 00           |           NOP
93E9 00           |           NOP
93EA 00           |           NOP
93EB 00           |           NOP
93EC 88           |           ADC A,B
93ED 00           |           NOP
93EE 00           |           NOP
93EF 00           |           NOP
93F0 00           |           NOP
93F1 00           |           NOP
93F2 00           |           NOP
93F3 00           |           NOP
93F4 00           |           NOP
93F5 00           |           NOP
93F6 00           |           NOP
93F7 88           |           ADC A,B
93F8 00           |           NOP
93F9 00           |           NOP
93FA 00           |           NOP
93FB 00           |           NOP
93FC 00           |           NOP
93FD 00           |           NOP
93FE 00           |           NOP
93FF 00           |           NOP
9400 FF           |           RST $38
9401 77           |           LD (HL),A
9402 00           |           NOP
9403 00           |           NOP
9404 00           |           NOP
9405 00           |           NOP
9406 00           |           NOP
9407 00           |           NOP
9408 00           |           NOP
9409 00           |           NOP
940A 00           |           NOP
940B 00           |           NOP
940C 77           |           LD (HL),A
940D 00           |           NOP
940E 00           |           NOP
940F 00           |           NOP
9410 DA EE 39     |           JP C,39EEh
9413 99           |           SBC A,C
9414 52           |           LD D,D
9415 52           |           LD D,D
9416 44           |           LD B,H
9417 00           |           NOP
9418 FF           |           RST $38
9419 CB 07        |           RLC A
941B 3F           |           CCF
941C 00           |           NOP
941D 00           |           NOP
941E FF           |           RST $38
941F AA           |           XOR D
9420 CC BB EE     |           CALL Z,EEBBh
9423 DD           |           *ILLEGAL*
9424 11 44 88     |           LD DE,8844h
9427 DD 77 FD     |           LD (IX+FDh),A
942A 34           |           INC (HL)
942B 12           |           LD (DE),A
942C 00           |           NOP
942D C0           |           RET NZ
942E 00           |           NOP
942F 00           |           NOP
9430 00           |           NOP
9431 00           |           NOP
9432 00           |           NOP
9433 01 FF 00     |           LD BC,00FFh
9436 00           |           NOP
9437 00           |           NOP
9438 00           |           NOP
9439 00           |           NOP
943A 00           |           NOP
943B 00           |           NOP
943C 00           |           NOP
943D 00           |           NOP
943E 00           |           NOP
943F 00           |           NOP
9440 00           |           NOP
9441 00           |           NOP
9442 00           |           NOP
9443 00           |           NOP
9444 00           |           NOP
9445 00           |           NOP
9446 00           |           NOP
9447 00           |           NOP
9448 FE 00        |           CP 00h
944A 00           |           NOP
944B 00           |           NOP
944C 00           |           NOP
944D 00           |           NOP
944E 00           |           NOP
944F 00           |           NOP
9450 00           |           NOP
9451 00           |           NOP
9452 00           |           NOP
9453 00           |           NOP
9454 00           |           NOP
9455 00           |           NOP
9456 00           |           NOP
9457 00           |           NOP
9458 DD           |           *ILLEGAL*
9459 9B           |           SBC A,E
945A BB           |           CP E
945B 3F           |           CCF
945C 52           |           LD D,D
945D 4C           |           LD C,H
945E 43           |           LD B,E
945F 20 41        |           JR NZ,94A2h
9461 00           |           NOP
9462 FF           |           RST $38
9463 CB 0F        |           RRC A
9465 3F           |           CCF
9466 00           |           NOP
9467 00           |           NOP
9468 FF           |           RST $38
9469 AA           |           XOR D
946A CC BB EE     |           CALL Z,EEBBh
946D DD           |           *ILLEGAL*
946E 11 44 88     |           LD DE,8844h
9471 DD 77 FD     |           LD (IX+FDh),A
9474 34           |           INC (HL)
9475 12           |           LD (DE),A
9476 00           |           NOP
9477 C0           |           RET NZ
9478 00           |           NOP
9479 00           |           NOP
947A 00           |           NOP
947B 00           |           NOP
947C 00           |           NOP
947D 01 FF 00     |           LD BC,00FFh
9480 00           |           NOP
9481 00           |           NOP
9482 00           |           NOP
9483 00           |           NOP
9484 00           |           NOP
9485 00           |           NOP
9486 00           |           NOP
9487 00           |           NOP
9488 00           |           NOP
9489 00           |           NOP
948A 00           |           NOP
948B 00           |           NOP
948C 00           |           NOP
948D 00           |           NOP
948E 00           |           NOP
948F 00           |           NOP
9490 00           |           NOP
9491 00           |           NOP
9492 FE 00        |           CP 00h
9494 00           |           NOP
9495 00           |           NOP
9496 00           |           NOP
9497 00           |           NOP
9498 00           |           NOP
9499 00           |           NOP
949A 00           |           NOP
949B 00           |           NOP
949C 00           |           NOP
949D 00           |           NOP
949E 00           |           NOP
949F 00           |           NOP
94A0 00           |           NOP
94A1 00           |           NOP
94A2 60           |           LD H,B
94A3 CD 57 C2     |           CALL C257h
94A6 52           |           LD D,D
94A7 52           |           LD D,D
94A8 43           |           LD B,E
94A9 20 41        |           JR NZ,94ECh
94AB 00           |           NOP
94AC FF           |           RST $38
94AD CB 17        |           RL A
94AF 3F           |           CCF
94B0 00           |           NOP
94B1 00           |           NOP
94B2 FF           |           RST $38
94B3 AA           |           XOR D
94B4 CC BB EE     |           CALL Z,EEBBh
94B7 DD           |           *ILLEGAL*
94B8 11 44 88     |           LD DE,8844h
94BB DD 77 FD     |           LD (IX+FDh),A
94BE 34           |           INC (HL)
94BF 12           |           LD (DE),A
94C0 00           |           NOP
94C1 C0           |           RET NZ
94C2 00           |           NOP
94C3 00           |           NOP
94C4 00           |           NOP
94C5 00           |           NOP
94C6 00           |           NOP
94C7 01 FF 00     |           LD BC,00FFh
94CA 00           |           NOP
94CB 00           |           NOP
94CC 00           |           NOP
94CD 00           |           NOP
94CE 00           |           NOP
94CF 00           |           NOP
94D0 00           |           NOP
94D1 00           |           NOP
94D2 00           |           NOP
94D3 00           |           NOP
94D4 00           |           NOP
94D5 00           |           NOP
94D6 00           |           NOP
94D7 00           |           NOP
94D8 00           |           NOP
94D9 00           |           NOP
94DA 00           |           NOP
94DB 00           |           NOP
94DC FE 00        |           CP 00h
94DE 00           |           NOP
94DF 00           |           NOP
94E0 00           |           NOP
94E1 00           |           NOP
94E2 00           |           NOP
94E3 00           |           NOP
94E4 00           |           NOP
94E5 00           |           NOP
94E6 00           |           NOP
94E7 00           |           NOP
94E8 00           |           NOP
94E9 00           |           NOP
94EA 00           |           NOP
94EB 00           |           NOP
94EC BF           |           CP A
94ED 18 C6        |           JR 94B5h
94EF 26 52        |           LD H,52h
94F1 4C           |           LD C,H
94F2 20 41        |           JR NZ,9535h
94F4 00           |           NOP
94F5 FF           |           RST $38
94F6 CB 1F        |           RR A
94F8 3F           |           CCF
94F9 00           |           NOP
94FA 00           |           NOP
94FB FF           |           RST $38
94FC AA           |           XOR D
94FD CC BB EE     |           CALL Z,EEBBh
9500 DD           |           *ILLEGAL*
9501 11 44 88     |           LD DE,8844h
9504 DD 77 FD     |           LD (IX+FDh),A
9507 34           |           INC (HL)
9508 12           |           LD (DE),A
9509 00           |           NOP
950A C0           |           RET NZ
950B 00           |           NOP
950C 00           |           NOP
950D 00           |           NOP
950E 00           |           NOP
950F 00           |           NOP
9510 01 FF 00     |           LD BC,00FFh
9513 00           |           NOP
9514 00           |           NOP
9515 00           |           NOP
9516 00           |           NOP
9517 00           |           NOP
9518 00           |           NOP
9519 00           |           NOP
951A 00           |           NOP
951B 00           |           NOP
951C 00           |           NOP
951D 00           |           NOP
951E 00           |           NOP
951F 00           |           NOP
9520 00           |           NOP
9521 00           |           NOP
9522 00           |           NOP
9523 00           |           NOP
9524 00           |           NOP
9525 FE 00        |           CP 00h
9527 00           |           NOP
9528 00           |           NOP
9529 00           |           NOP
952A 00           |           NOP
952B 00           |           NOP
952C 00           |           NOP
952D 00           |           NOP
952E 00           |           NOP
952F 00           |           NOP
9530 00           |           NOP
9531 00           |           NOP
9532 00           |           NOP
9533 00           |           NOP
9534 00           |           NOP
9535 98           |           SBC A,B
9536 E6 FE        |           AND FEh
9538 D5           |           PUSH DE
9539 52           |           LD D,D
953A 52           |           LD D,D
953B 20 41        |           JR NZ,957Eh
953D 00           |           NOP
953E FF           |           RST $38
953F CB 27        |           SLA A
9541 3F           |           CCF
9542 00           |           NOP
9543 00           |           NOP
9544 FF           |           RST $38
9545 AA           |           XOR D
9546 CC BB EE     |           CALL Z,EEBBh
9549 DD           |           *ILLEGAL*
954A 11 44 88     |           LD DE,8844h
954D DD 77 FD     |           LD (IX+FDh),A
9550 34           |           INC (HL)
9551 12           |           LD (DE),A
9552 00           |           NOP
9553 C0           |           RET NZ
9554 00           |           NOP
9555 00           |           NOP
9556 00           |           NOP
9557 00           |           NOP
9558 00           |           NOP
9559 01 FF 00     |           LD BC,00FFh
955C 00           |           NOP
955D 00           |           NOP
955E 00           |           NOP
955F 00           |           NOP
9560 00           |           NOP
9561 00           |           NOP
9562 00           |           NOP
9563 00           |           NOP
9564 00           |           NOP
9565 00           |           NOP
9566 00           |           NOP
9567 00           |           NOP
9568 00           |           NOP
9569 00           |           NOP
956A 00           |           NOP
956B 00           |           NOP
956C 00           |           NOP
956D 00           |           NOP
956E FE 00        |           CP 00h
9570 00           |           NOP
9571 00           |           NOP
9572 00           |           NOP
9573 00           |           NOP
9574 00           |           NOP
9575 00           |           NOP
9576 00           |           NOP
9577 00           |           NOP
9578 00           |           NOP
9579 00           |           NOP
957A 00           |           NOP
957B 00           |           NOP
957C 00           |           NOP
957D 00           |           NOP
957E 34           |           INC (HL)
957F 3D           |           DEC A
9580 DA 87 53     |           JP C,5387h
9583 4C           |           LD C,H
9584 41           |           LD B,C
9585 20 41        |           JR NZ,95C8h
9587 00           |           NOP
9588 FF           |           RST $38
9589 CB 2F        |           SRA A
958B 3F           |           CCF
958C 00           |           NOP
958D 00           |           NOP
958E FF           |           RST $38
958F AA           |           XOR D
9590 CC BB EE     |           CALL Z,EEBBh
9593 DD           |           *ILLEGAL*
9594 11 44 88     |           LD DE,8844h
9597 DD 77 FD     |           LD (IX+FDh),A
959A 34           |           INC (HL)
959B 12           |           LD (DE),A
959C 00           |           NOP
959D C0           |           RET NZ
959E 00           |           NOP
959F 00           |           NOP
95A0 00           |           NOP
95A1 00           |           NOP
95A2 00           |           NOP
95A3 01 FF 00     |           LD BC,00FFh
95A6 00           |           NOP
95A7 00           |           NOP
95A8 00           |           NOP
95A9 00           |           NOP
95AA 00           |           NOP
95AB 00           |           NOP
95AC 00           |           NOP
95AD 00           |           NOP
95AE 00           |           NOP
95AF 00           |           NOP
95B0 00           |           NOP
95B1 00           |           NOP
95B2 00           |           NOP
95B3 00           |           NOP
95B4 00           |           NOP
95B5 00           |           NOP
95B6 00           |           NOP
95B7 00           |           NOP
95B8 FE 00        |           CP 00h
95BA 00           |           NOP
95BB 00           |           NOP
95BC 00           |           NOP
95BD 00           |           NOP
95BE 00           |           NOP
95BF 00           |           NOP
95C0 00           |           NOP
95C1 00           |           NOP
95C2 00           |           NOP
95C3 00           |           NOP
95C4 00           |           NOP
95C5 00           |           NOP
95C6 00           |           NOP
95C7 00           |           NOP
95C8 99           |           SBC A,C
95C9 FA E9 D5     |           JP M,D5E9h
95CC 53           |           LD D,E
95CD 52           |           LD D,D
95CE 41           |           LD B,C
95CF 20 41        |           JR NZ,9612h
95D1 00           |           NOP
95D2 FF           |           RST $38
95D3 CB 37        |           SLS A
95D5 3F           |           CCF
95D6 00           |           NOP
95D7 00           |           NOP
95D8 FF           |           RST $38
95D9 AA           |           XOR D
95DA CC BB EE     |           CALL Z,EEBBh
95DD DD           |           *ILLEGAL*
95DE 11 44 88     |           LD DE,8844h
95E1 DD 77 FD     |           LD (IX+FDh),A
95E4 34           |           INC (HL)
95E5 12           |           LD (DE),A
95E6 00           |           NOP
95E7 C0           |           RET NZ
95E8 00           |           NOP
95E9 00           |           NOP
95EA 00           |           NOP
95EB 00           |           NOP
95EC 00           |           NOP
95ED 01 FF 00     |           LD BC,00FFh
95F0 00           |           NOP
95F1 00           |           NOP
95F2 00           |           NOP
95F3 00           |           NOP
95F4 00           |           NOP
95F5 00           |           NOP
95F6 00           |           NOP
95F7 00           |           NOP
95F8 00           |           NOP
95F9 00           |           NOP
95FA 00           |           NOP
95FB 00           |           NOP
95FC 00           |           NOP
95FD 00           |           NOP
95FE 00           |           NOP
95FF 00           |           NOP
9600 00           |           NOP
9601 00           |           NOP
9602 FE 00        |           CP 00h
9604 00           |           NOP
9605 00           |           NOP
9606 00           |           NOP
9607 00           |           NOP
9608 00           |           NOP
9609 00           |           NOP
960A 00           |           NOP
960B 00           |           NOP
960C 00           |           NOP
960D 00           |           NOP
960E 00           |           NOP
960F 00           |           NOP
9610 00           |           NOP
9611 00           |           NOP
9612 1E 42        |           LD E,42h
9614 70           |           LD (HL),B
9615 44           |           LD B,H
9616 53           |           LD D,E
9617 4C           |           LD C,H
9618 49           |           LD C,C
9619 41           |           LD B,C
961A 20 41        |           JR NZ,965Dh
961C 00           |           NOP
961D FF           |           RST $38
961E CB 3F        |           SRL A
9620 3F           |           CCF
9621 00           |           NOP
9622 00           |           NOP
9623 FF           |           RST $38
9624 AA           |           XOR D
9625 CC BB EE     |           CALL Z,EEBBh
9628 DD           |           *ILLEGAL*
9629 11 44 88     |           LD DE,8844h
962C DD 77 FD     |           LD (IX+FDh),A
962F 34           |           INC (HL)
9630 12           |           LD (DE),A
9631 00           |           NOP
9632 C0           |           RET NZ
9633 00           |           NOP
9634 00           |           NOP
9635 00           |           NOP
9636 00           |           NOP
9637 00           |           NOP
9638 01 FF 00     |           LD BC,00FFh
963B 00           |           NOP
963C 00           |           NOP
963D 00           |           NOP
963E 00           |           NOP
963F 00           |           NOP
9640 00           |           NOP
9641 00           |           NOP
9642 00           |           NOP
9643 00           |           NOP
9644 00           |           NOP
9645 00           |           NOP
9646 00           |           NOP
9647 00           |           NOP
9648 00           |           NOP
9649 00           |           NOP
964A 00           |           NOP
964B 00           |           NOP
964C 00           |           NOP
964D FE 00        |           CP 00h
964F 00           |           NOP
9650 00           |           NOP
9651 00           |           NOP
9652 00           |           NOP
9653 00           |           NOP
9654 00           |           NOP
9655 00           |           NOP
9656 00           |           NOP
9657 00           |           NOP
9658 00           |           NOP
9659 00           |           NOP
965A 00           |           NOP
965B 00           |           NOP
965C 00           |           NOP
965D 6B           |           LD L,E
965E EF           |           RST $28
965F 3B           |           DEC SP
9660 86           |           ADD A,(HL)
9661 53           |           LD D,E
9662 52           |           LD D,D
9663 4C           |           LD C,H
9664 20 41        |           JR NZ,96A7h
9666 00           |           NOP
9667 FF           |           RST $38
9668 CB 00        |           RLC B
966A 3F           |           CCF
966B 00           |           NOP
966C 00           |           NOP
966D FF           |           RST $38
966E 00           |           NOP
966F 00           |           NOP
9670 00           |           NOP
9671 00           |           NOP
9672 00           |           NOP
9673 0C           |           INC C
9674 88           |           ADC A,B
9675 88           |           ADC A,B
9676 DD 77 FD     |           LD (IX+FDh),A
9679 34           |           INC (HL)
967A 12           |           LD (DE),A
967B 00           |           NOP
967C C0           |           RET NZ
967D 00           |           NOP
967E 07           |           RLCA
967F 00           |           NOP
9680 00           |           NOP
9681 00           |           NOP
9682 01 00 00     |           LD BC,0000h
9685 00           |           NOP
9686 00           |           NOP
9687 00           |           NOP
9688 00           |           NOP
9689 00           |           NOP
968A 00           |           NOP
968B 00           |           NOP
968C 00           |           NOP
968D 00           |           NOP
968E 00           |           NOP
968F 00           |           NOP
9690 00           |           NOP
9691 00           |           NOP
9692 00           |           NOP
9693 00           |           NOP
9694 00           |           NOP
9695 00           |           NOP
9696 00           |           NOP
9697 FE FF        |           CP FFh
9699 FF           |           RST $38
969A FF           |           RST $38
969B FF           |           RST $38
969C FF           |           RST $38
969D 01 00 00     |           LD BC,0000h
96A0 00           |           NOP
96A1 00           |           NOP
96A2 00           |           NOP
96A3 FF           |           RST $38
96A4 00           |           NOP
96A5 00           |           NOP
96A6 00           |           NOP
96A7 0D           |           DEC C
96A8 E3           |           EX (SP),HL
96A9 B8           |           CP B
96AA D0           |           RET NC
96AB 52           |           LD D,D
96AC 4C           |           LD C,H
96AD 43           |           LD B,E
96AE 20 5B        |           JR NZ,970Bh
96B0 52           |           LD D,D
96B1 2C           |           INC L
96B2 28 48        |           JR Z,96FCh
96B4 4C           |           LD C,H
96B5 29           |           ADD HL,HL
96B6 5D           |           LD E,L
96B7 00           |           NOP
96B8 FF           |           RST $38
96B9 CB 08        |           RRC B
96BB 3F           |           CCF
96BC 00           |           NOP
96BD 00           |           NOP
96BE FF           |           RST $38
96BF 00           |           NOP
96C0 00           |           NOP
96C1 00           |           NOP
96C2 00           |           NOP
96C3 00           |           NOP
96C4 0C           |           INC C
96C5 88           |           ADC A,B
96C6 88           |           ADC A,B
96C7 DD 77 FD     |           LD (IX+FDh),A
96CA 34           |           INC (HL)
96CB 12           |           LD (DE),A
96CC 00           |           NOP
96CD C0           |           RET NZ
96CE 00           |           NOP
96CF 07           |           RLCA
96D0 00           |           NOP
96D1 00           |           NOP
96D2 00           |           NOP
96D3 01 00 00     |           LD BC,0000h
96D6 00           |           NOP
96D7 00           |           NOP
96D8 00           |           NOP
96D9 00           |           NOP
96DA 00           |           NOP
96DB 00           |           NOP
96DC 00           |           NOP
96DD 00           |           NOP
96DE 00           |           NOP
96DF 00           |           NOP
96E0 00           |           NOP
96E1 00           |           NOP
96E2 00           |           NOP
96E3 00           |           NOP
96E4 00           |           NOP
96E5 00           |           NOP
96E6 00           |           NOP
96E7 00           |           NOP
96E8 FE FF        |           CP FFh
96EA FF           |           RST $38
96EB FF           |           RST $38
96EC FF           |           RST $38
96ED FF           |           RST $38
96EE 01 00 00     |           LD BC,0000h
96F1 00           |           NOP
96F2 00           |           NOP
96F3 00           |           NOP
96F4 FF           |           RST $38
96F5 00           |           NOP
96F6 00           |           NOP
96F7 00           |           NOP
96F8 B3           |           OR E
96F9 20 57        |           JR NZ,9752h
96FB 43           |           LD B,E
96FC 52           |           LD D,D
96FD 52           |           LD D,D
96FE 43           |           LD B,E
96FF 20 5B        |           JR NZ,975Ch
9701 52           |           LD D,D
9702 2C           |           INC L
9703 28 48        |           JR Z,974Dh
9705 4C           |           LD C,H
9706 29           |           ADD HL,HL
9707 5D           |           LD E,L
9708 00           |           NOP
9709 FF           |           RST $38
970A CB 10        |           RL B
970C 3F           |           CCF
970D 00           |           NOP
970E 00           |           NOP
970F FF           |           RST $38
9710 00           |           NOP
9711 00           |           NOP
9712 00           |           NOP
9713 00           |           NOP
9714 00           |           NOP
9715 0C           |           INC C
9716 88           |           ADC A,B
9717 88           |           ADC A,B
9718 DD 77 FD     |           LD (IX+FDh),A
971B 34           |           INC (HL)
971C 12           |           LD (DE),A
971D 00           |           NOP
971E C0           |           RET NZ
971F 00           |           NOP
9720 07           |           RLCA
9721 00           |           NOP
9722 00           |           NOP
9723 00           |           NOP
9724 01 00 00     |           LD BC,0000h
9727 00           |           NOP
9728 00           |           NOP
9729 00           |           NOP
972A 00           |           NOP
972B 00           |           NOP
972C 00           |           NOP
972D 00           |           NOP
972E 00           |           NOP
972F 00           |           NOP
9730 00           |           NOP
9731 00           |           NOP
9732 00           |           NOP
9733 00           |           NOP
9734 00           |           NOP
9735 00           |           NOP
9736 00           |           NOP
9737 00           |           NOP
9738 00           |           NOP
9739 FE FF        |           CP FFh
973B FF           |           RST $38
973C FF           |           RST $38
973D FF           |           RST $38
973E FF           |           RST $38
973F 01 00 00     |           LD BC,0000h
9742 00           |           NOP
9743 00           |           NOP
9744 00           |           NOP
9745 FF           |           RST $38
9746 00           |           NOP
9747 00           |           NOP
9748 00           |           NOP
9749 9D           |           SBC A,L
974A 4D           |           LD C,L
974B 62           |           LD H,D
974C 34           |           INC (HL)
974D 52           |           LD D,D
974E 4C           |           LD C,H
974F 20 5B        |           JR NZ,97ACh
9751 52           |           LD D,D
9752 2C           |           INC L
9753 28 48        |           JR Z,979Dh
9755 4C           |           LD C,H
9756 29           |           ADD HL,HL
9757 5D           |           LD E,L
9758 00           |           NOP
9759 FF           |           RST $38
975A CB 18        |           RR B
975C 3F           |           CCF
975D 00           |           NOP
975E 00           |           NOP
975F FF           |           RST $38
9760 00           |           NOP
9761 00           |           NOP
9762 00           |           NOP
9763 00           |           NOP
9764 00           |           NOP
9765 0C           |           INC C
9766 88           |           ADC A,B
9767 88           |           ADC A,B
9768 DD 77 FD     |           LD (IX+FDh),A
976B 34           |           INC (HL)
976C 12           |           LD (DE),A
976D 00           |           NOP
976E C0           |           RET NZ
976F 00           |           NOP
9770 07           |           RLCA
9771 00           |           NOP
9772 00           |           NOP
9773 00           |           NOP
9774 01 00 00     |           LD BC,0000h
9777 00           |           NOP
9778 00           |           NOP
9779 00           |           NOP
977A 00           |           NOP
977B 00           |           NOP
977C 00           |           NOP
977D 00           |           NOP
977E 00           |           NOP
977F 00           |           NOP
9780 00           |           NOP
9781 00           |           NOP
9782 00           |           NOP
9783 00           |           NOP
9784 00           |           NOP
9785 00           |           NOP
9786 00           |           NOP
9787 00           |           NOP
9788 00           |           NOP
9789 FE FF        |           CP FFh
978B FF           |           RST $38
978C FF           |           RST $38
978D FF           |           RST $38
978E FF           |           RST $38
978F 01 00 00     |           LD BC,0000h
9792 00           |           NOP
9793 00           |           NOP
9794 00           |           NOP
9795 FF           |           RST $38
9796 00           |           NOP
9797 00           |           NOP
9798 00           |           NOP
9799 67           |           LD H,A
979A 4E           |           LD C,(HL)
979B 60           |           LD H,B
979C 50           |           LD D,B
979D 52           |           LD D,D
979E 52           |           LD D,D
979F 20 5B        |           JR NZ,97FCh
97A1 52           |           LD D,D
97A2 2C           |           INC L
97A3 28 48        |           JR Z,97EDh
97A5 4C           |           LD C,H
97A6 29           |           ADD HL,HL
97A7 5D           |           LD E,L
97A8 00           |           NOP
97A9 FF           |           RST $38
97AA CB 20        |           SLA B
97AC 3F           |           CCF
97AD 00           |           NOP
97AE 00           |           NOP
97AF FF           |           RST $38
97B0 00           |           NOP
97B1 00           |           NOP
97B2 00           |           NOP
97B3 00           |           NOP
97B4 00           |           NOP
97B5 0C           |           INC C
97B6 88           |           ADC A,B
97B7 88           |           ADC A,B
97B8 DD 77 FD     |           LD (IX+FDh),A
97BB 34           |           INC (HL)
97BC 12           |           LD (DE),A
97BD 00           |           NOP
97BE C0           |           RET NZ
97BF 00           |           NOP
97C0 07           |           RLCA
97C1 00           |           NOP
97C2 00           |           NOP
97C3 00           |           NOP
97C4 01 00 00     |           LD BC,0000h
97C7 00           |           NOP
97C8 00           |           NOP
97C9 00           |           NOP
97CA 00           |           NOP
97CB 00           |           NOP
97CC 00           |           NOP
97CD 00           |           NOP
97CE 00           |           NOP
97CF 00           |           NOP
97D0 00           |           NOP
97D1 00           |           NOP
97D2 00           |           NOP
97D3 00           |           NOP
97D4 00           |           NOP
97D5 00           |           NOP
97D6 00           |           NOP
97D7 00           |           NOP
97D8 00           |           NOP
97D9 FE FF        |           CP FFh
97DB FF           |           RST $38
97DC FF           |           RST $38
97DD FF           |           RST $38
97DE FF           |           RST $38
97DF 01 00 00     |           LD BC,0000h
97E2 00           |           NOP
97E3 00           |           NOP
97E4 00           |           NOP
97E5 FF           |           RST $38
97E6 00           |           NOP
97E7 00           |           NOP
97E8 00           |           NOP
97E9 50           |           LD D,B
97EA 26 D1        |           LD H,D1h
97EC 5E           |           LD E,(HL)
97ED 53           |           LD D,E
97EE 4C           |           LD C,H
97EF 41           |           LD B,C
97F0 20 5B        |           JR NZ,984Dh
97F2 52           |           LD D,D
97F3 2C           |           INC L
97F4 28 48        |           JR Z,983Eh
97F6 4C           |           LD C,H
97F7 29           |           ADD HL,HL
97F8 5D           |           LD E,L
97F9 00           |           NOP
97FA FF           |           RST $38
97FB CB 28        |           SRA B
97FD 3F           |           CCF
97FE 00           |           NOP
97FF 00           |           NOP
9800 FF           |           RST $38
9801 00           |           NOP
9802 00           |           NOP
9803 00           |           NOP
9804 00           |           NOP
9805 00           |           NOP
9806 0C           |           INC C
9807 88           |           ADC A,B
9808 88           |           ADC A,B
9809 DD 77 FD     |           LD (IX+FDh),A
980C 34           |           INC (HL)
980D 12           |           LD (DE),A
980E 00           |           NOP
980F C0           |           RET NZ
9810 00           |           NOP
9811 07           |           RLCA
9812 00           |           NOP
9813 00           |           NOP
9814 00           |           NOP
9815 01 00 00     |           LD BC,0000h
9818 00           |           NOP
9819 00           |           NOP
981A 00           |           NOP
981B 00           |           NOP
981C 00           |           NOP
981D 00           |           NOP
981E 00           |           NOP
981F 00           |           NOP
9820 00           |           NOP
9821 00           |           NOP
9822 00           |           NOP
9823 00           |           NOP
9824 00           |           NOP
9825 00           |           NOP
9826 00           |           NOP
9827 00           |           NOP
9828 00           |           NOP
9829 00           |           NOP
982A FE FF        |           CP FFh
982C FF           |           RST $38
982D FF           |           RST $38
982E FF           |           RST $38
982F FF           |           RST $38
9830 01 00 00     |           LD BC,0000h
9833 00           |           NOP
9834 00           |           NOP
9835 00           |           NOP
9836 FF           |           RST $38
9837 00           |           NOP
9838 00           |           NOP
9839 00           |           NOP
983A 7A           |           LD A,D
983B F3           |           DI
983C A2           |           AND D
983D 94           |           SUB A,H
983E 53           |           LD D,E
983F 52           |           LD D,D
9840 41           |           LD B,C
9841 20 5B        |           JR NZ,989Eh
9843 52           |           LD D,D
9844 2C           |           INC L
9845 28 48        |           JR Z,988Fh
9847 4C           |           LD C,H
9848 29           |           ADD HL,HL
9849 5D           |           LD E,L
984A 00           |           NOP
984B FF           |           RST $38
984C CB 30        |           SLS B
984E 3F           |           CCF
984F 00           |           NOP
9850 00           |           NOP
9851 FF           |           RST $38
9852 00           |           NOP
9853 00           |           NOP
9854 00           |           NOP
9855 00           |           NOP
9856 00           |           NOP
9857 0C           |           INC C
9858 88           |           ADC A,B
9859 88           |           ADC A,B
985A DD 77 FD     |           LD (IX+FDh),A
985D 34           |           INC (HL)
985E 12           |           LD (DE),A
985F 00           |           NOP
9860 C0           |           RET NZ
9861 00           |           NOP
9862 07           |           RLCA
9863 00           |           NOP
9864 00           |           NOP
9865 00           |           NOP
9866 01 00 00     |           LD BC,0000h
9869 00           |           NOP
986A 00           |           NOP
986B 00           |           NOP
986C 00           |           NOP
986D 00           |           NOP
986E 00           |           NOP
986F 00           |           NOP
9870 00           |           NOP
9871 00           |           NOP
9872 00           |           NOP
9873 00           |           NOP
9874 00           |           NOP
9875 00           |           NOP
9876 00           |           NOP
9877 00           |           NOP
9878 00           |           NOP
9879 00           |           NOP
987A 00           |           NOP
987B FE FF        |           CP FFh
987D FF           |           RST $38
987E FF           |           RST $38
987F FF           |           RST $38
9880 FF           |           RST $38
9881 01 00 00     |           LD BC,0000h
9884 00           |           NOP
9885 00           |           NOP
9886 00           |           NOP
9887 FF           |           RST $38
9888 00           |           NOP
9889 00           |           NOP
988A 00           |           NOP
988B BE           |           CP (HL)
988C 4D           |           LD C,L
988D 58           |           LD E,B
988E 89           |           ADC A,C
988F 53           |           LD D,E
9890 4C           |           LD C,H
9891 49           |           LD C,C
9892 41           |           LD B,C
9893 20 5B        |           JR NZ,98F0h
9895 52           |           LD D,D
9896 2C           |           INC L
9897 28 48        |           JR Z,98E1h
9899 4C           |           LD C,H
989A 29           |           ADD HL,HL
989B 5D           |           LD E,L
989C 00           |           NOP
989D FF           |           RST $38
989E CB 38        |           SRL B
98A0 3F           |           CCF
98A1 00           |           NOP
98A2 00           |           NOP
98A3 FF           |           RST $38
98A4 00           |           NOP
98A5 00           |           NOP
98A6 00           |           NOP
98A7 00           |           NOP
98A8 00           |           NOP
98A9 0C           |           INC C
98AA 88           |           ADC A,B
98AB 88           |           ADC A,B
98AC DD 77 FD     |           LD (IX+FDh),A
98AF 34           |           INC (HL)
98B0 12           |           LD (DE),A
98B1 00           |           NOP
98B2 C0           |           RET NZ
98B3 00           |           NOP
98B4 07           |           RLCA
98B5 00           |           NOP
98B6 00           |           NOP
98B7 00           |           NOP
98B8 01 00 00     |           LD BC,0000h
98BB 00           |           NOP
98BC 00           |           NOP
98BD 00           |           NOP
98BE 00           |           NOP
98BF 00           |           NOP
98C0 00           |           NOP
98C1 00           |           NOP
98C2 00           |           NOP
98C3 00           |           NOP
98C4 00           |           NOP
98C5 00           |           NOP
98C6 00           |           NOP
98C7 00           |           NOP
98C8 00           |           NOP
98C9 00           |           NOP
98CA 00           |           NOP
98CB 00           |           NOP
98CC 00           |           NOP
98CD FE FF        |           CP FFh
98CF FF           |           RST $38
98D0 FF           |           RST $38
98D1 FF           |           RST $38
98D2 FF           |           RST $38
98D3 01 00 00     |           LD BC,0000h
98D6 00           |           NOP
98D7 00           |           NOP
98D8 00           |           NOP
98D9 FF           |           RST $38
98DA 00           |           NOP
98DB 00           |           NOP
98DC 00           |           NOP
98DD 16 54        |           LD D,54h
98DF 0F           |           RRCA
98E0 37           |           SCF
98E1 53           |           LD D,E
98E2 52           |           LD D,D
98E3 4C           |           LD C,H
98E4 20 5B        |           JR NZ,9941h
98E6 52           |           LD D,D
98E7 2C           |           INC L
98E8 28 48        |           JR Z,9932h
98EA 4C           |           LD C,H
98EB 29           |           ADD HL,HL
98EC 5D           |           LD E,L
98ED 00           |           NOP
98EE FF           |           RST $38
98EF DD CB 00 06  |           RLC (IX+{byte:02X}h)
98F3 3F           |           CCF
98F4 FF           |           RST $38
98F5 A0           |           AND B
98F6 CC BB EE     |           CALL Z,EEBBh
98F9 DD           |           *ILLEGAL*
98FA 11 44 0C     |           LD DE,0C44h
98FD 88           |           ADC A,B
98FE 0C           |           INC C
98FF 88           |           ADC A,B
9900 00           |           NOP
9901 12           |           LD (DE),A
9902 00           |           NOP
9903 C0           |           RET NZ
9904 20 00        |           JR NZ,9906h
9906 00           |           NOP
9907 38 00        |           JR C,9909h
9909 01 00 00     |           LD BC,0000h
990C 00           |           NOP
990D 00           |           NOP
990E 00           |           NOP
990F 00           |           NOP
9910 00           |           NOP
9911 00           |           NOP
9912 00           |           NOP
9913 00           |           NOP
9914 00           |           NOP
9915 00           |           NOP
9916 00           |           NOP
9917 00           |           NOP
9918 00           |           NOP
9919 00           |           NOP
991A 00           |           NOP
991B 01 00 00     |           LD BC,0000h
991E FE 28        |           CP 28h
9920 00           |           NOP
9921 00           |           NOP
9922 00           |           NOP
9923 00           |           NOP
9924 00           |           NOP
9925 00           |           NOP
9926 01 00 01     |           LD BC,0100h
9929 00           |           NOP
992A FF           |           RST $38
992B 00           |           NOP
992C 00           |           NOP
992D 00           |           NOP
992E 63           |           LD H,E
992F 4C           |           LD C,H
9930 FD           |           *ILLEGAL*
9931 9B           |           SBC A,E
9932 53           |           LD D,E
9933 52           |           LD D,D
9934 4F           |           LD C,A
9935 20 28        |           JR NZ,995Fh
9937 58           |           LD E,B
9938 59           |           LD E,C
9939 29           |           ADD HL,HL
993A 00           |           NOP
993B FF           |           RST $38
993C DD CB 00 00  |           RLC (IX+{byte:02X}h),B
9940 3F           |           CCF
9941 FF           |           RST $38
9942 A0           |           AND B
9943 CC BB EE     |           CALL Z,EEBBh
9946 DD           |           *ILLEGAL*
9947 11 44 0C     |           LD DE,0C44h
994A 88           |           ADC A,B
994B 0C           |           INC C
994C 88           |           ADC A,B
994D 00           |           NOP
994E 12           |           LD (DE),A
994F 00           |           NOP
9950 C0           |           RET NZ
9951 20 00        |           JR NZ,9953h
9953 00           |           NOP
9954 3F           |           CCF
9955 00           |           NOP
9956 01 00 00     |           LD BC,0000h
9959 00           |           NOP
995A 00           |           NOP
995B 00           |           NOP
995C 00           |           NOP
995D 00           |           NOP
995E 00           |           NOP
995F 00           |           NOP
9960 00           |           NOP
9961 00           |           NOP
9962 00           |           NOP
9963 00           |           NOP
9964 00           |           NOP
9965 00           |           NOP
9966 00           |           NOP
9967 00           |           NOP
9968 01 00 00     |           LD BC,0000h
996B FE 28        |           CP 28h
996D 00           |           NOP
996E 00           |           NOP
996F 00           |           NOP
9970 00           |           NOP
9971 00           |           NOP
9972 00           |           NOP
9973 01 00 01     |           LD BC,0100h
9976 00           |           NOP
9977 FF           |           RST $38
9978 00           |           NOP
9979 00           |           NOP
997A 00           |           NOP
997B A7           |           AND A
997C AE           |           XOR (HL)
997D 20 64        |           JR NZ,99E3h
997F 53           |           LD D,E
9980 52           |           LD D,D
9981 4F           |           LD C,A
9982 20 28        |           JR NZ,99ACh
9984 58           |           LD E,B
9985 59           |           LD E,C
9986 29           |           ADD HL,HL
9987 2C           |           INC L
9988 52           |           LD D,D
9989 00           |           NOP
998A FF           |           RST $38
998B 3C           |           INC A
998C 3F           |           CCF
998D 00           |           NOP
998E 00           |           NOP
998F 00           |           NOP
9990 FF           |           RST $38
9991 AA           |           XOR D
9992 CC BB EE     |           CALL Z,EEBBh
9995 DD           |           *ILLEGAL*
9996 11 44 88     |           LD DE,8844h
9999 DD 77 FD     |           LD (IX+FDh),A
999C 34           |           INC (HL)
999D 12           |           LD (DE),A
999E 00           |           NOP
999F C0           |           RET NZ
99A0 00           |           NOP
99A1 00           |           NOP
99A2 00           |           NOP
99A3 00           |           NOP
99A4 00           |           NOP
99A5 41           |           LD B,C
99A6 FF           |           RST $38
99A7 00           |           NOP
99A8 00           |           NOP
99A9 00           |           NOP
99AA 00           |           NOP
99AB 00           |           NOP
99AC 00           |           NOP
99AD 00           |           NOP
99AE 00           |           NOP
99AF 00           |           NOP
99B0 00           |           NOP
99B1 00           |           NOP
99B2 00           |           NOP
99B3 00           |           NOP
99B4 00           |           NOP
99B5 00           |           NOP
99B6 00           |           NOP
99B7 00           |           NOP
99B8 00           |           NOP
99B9 00           |           NOP
99BA BE           |           CP (HL)
99BB 00           |           NOP
99BC 00           |           NOP
99BD 00           |           NOP
99BE 00           |           NOP
99BF 00           |           NOP
99C0 00           |           NOP
99C1 00           |           NOP
99C2 00           |           NOP
99C3 00           |           NOP
99C4 00           |           NOP
99C5 00           |           NOP
99C6 00           |           NOP
99C7 00           |           NOP
99C8 00           |           NOP
99C9 00           |           NOP
99CA 79           |           LD A,C
99CB BA           |           CP D
99CC F4 40 49     |           CALL P,4940h
99CF 4E           |           LD C,(HL)
99D0 43           |           LD B,E
99D1 20 41        |           JR NZ,9A14h
99D3 00           |           NOP
99D4 FF           |           RST $38
99D5 3D           |           DEC A
99D6 3F           |           CCF
99D7 00           |           NOP
99D8 00           |           NOP
99D9 00           |           NOP
99DA FF           |           RST $38
99DB AA           |           XOR D
99DC CC BB EE     |           CALL Z,EEBBh
99DF DD           |           *ILLEGAL*
99E0 11 44 88     |           LD DE,8844h
99E3 DD 77 FD     |           LD (IX+FDh),A
99E6 34           |           INC (HL)
99E7 12           |           LD (DE),A
99E8 00           |           NOP
99E9 C0           |           RET NZ
99EA 00           |           NOP
99EB 00           |           NOP
99EC 00           |           NOP
99ED 00           |           NOP
99EE 00           |           NOP
99EF 41           |           LD B,C
99F0 FF           |           RST $38
99F1 00           |           NOP
99F2 00           |           NOP
99F3 00           |           NOP
99F4 00           |           NOP
99F5 00           |           NOP
99F6 00           |           NOP
99F7 00           |           NOP
99F8 00           |           NOP
99F9 00           |           NOP
99FA 00           |           NOP
99FB 00           |           NOP
99FC 00           |           NOP
99FD 00           |           NOP
99FE 00           |           NOP
99FF 00           |           NOP
9A00 00           |           NOP
9A01 00           |           NOP
9A02 00           |           NOP
9A03 00           |           NOP
9A04 BE           |           CP (HL)
9A05 00           |           NOP
9A06 00           |           NOP
9A07 00           |           NOP
9A08 00           |           NOP
9A09 00           |           NOP
9A0A 00           |           NOP
9A0B 00           |           NOP
9A0C 00           |           NOP
9A0D 00           |           NOP
9A0E 00           |           NOP
9A0F 00           |           NOP
9A10 00           |           NOP
9A11 00           |           NOP
9A12 00           |           NOP
9A13 00           |           NOP
9A14 83           |           ADD A,E
9A15 51           |           LD D,C
9A16 97           |           SUB A,A
9A17 41           |           LD B,C
9A18 44           |           LD B,H
9A19 45           |           LD B,L
9A1A 43           |           LD B,E
9A1B 20 41        |           JR NZ,9A5Eh
9A1D 00           |           NOP
9A1E FF           |           RST $38
9A1F 04           |           INC B
9A20 3F           |           CCF
9A21 00           |           NOP
9A22 00           |           NOP
9A23 00           |           NOP
9A24 FF           |           RST $38
9A25 FF           |           RST $38
9A26 FF           |           RST $38
9A27 FF           |           RST $38
9A28 FF           |           RST $38
9A29 FF           |           RST $38
9A2A 0C           |           INC C
9A2B 88           |           ADC A,B
9A2C 88           |           ADC A,B
9A2D DD 77 FD     |           LD (IX+FDh),A
9A30 00           |           NOP
9A31 00           |           NOP
9A32 00           |           NOP
9A33 C0           |           RET NZ
9A34 38 00        |           JR C,9A36h
9A36 00           |           NOP
9A37 00           |           NOP
9A38 00           |           NOP
9A39 41           |           LD B,C
9A3A 00           |           NOP
9A3B 00           |           NOP
9A3C 00           |           NOP
9A3D 00           |           NOP
9A3E 00           |           NOP
9A3F 00           |           NOP
9A40 00           |           NOP
9A41 00           |           NOP
9A42 00           |           NOP
9A43 00           |           NOP
9A44 00           |           NOP
9A45 00           |           NOP
9A46 00           |           NOP
9A47 00           |           NOP
9A48 00           |           NOP
9A49 00           |           NOP
9A4A 00           |           NOP
9A4B 00           |           NOP
9A4C 00           |           NOP
9A4D 00           |           NOP
9A4E BE           |           CP (HL)
9A4F FF           |           RST $38
9A50 FF           |           RST $38
9A51 FF           |           RST $38
9A52 FF           |           RST $38
9A53 FF           |           RST $38
9A54 01 00 00     |           LD BC,0000h
9A57 00           |           NOP
9A58 00           |           NOP
9A59 00           |           NOP
9A5A FF           |           RST $38
9A5B 00           |           NOP
9A5C 00           |           NOP
9A5D 00           |           NOP
9A5E A3           |           AND E
9A5F E0           |           RET PO
9A60 4A           |           LD C,D
9A61 EE 49        |           XOR 49h
9A63 4E           |           LD C,(HL)
9A64 43           |           LD B,E
9A65 20 5B        |           JR NZ,9AC2h
9A67 52           |           LD D,D
9A68 2C           |           INC L
9A69 28 48        |           JR Z,9AB3h
9A6B 4C           |           LD C,H
9A6C 29           |           ADD HL,HL
9A6D 5D           |           LD E,L
9A6E 00           |           NOP
9A6F FF           |           RST $38
9A70 05           |           DEC B
9A71 3F           |           CCF
9A72 00           |           NOP
9A73 00           |           NOP
9A74 00           |           NOP
9A75 FF           |           RST $38
9A76 00           |           NOP
9A77 00           |           NOP
9A78 00           |           NOP
9A79 00           |           NOP
9A7A 00           |           NOP
9A7B 0C           |           INC C
9A7C 88           |           ADC A,B
9A7D 88           |           ADC A,B
9A7E DD 77 FD     |           LD (IX+FDh),A
9A81 FF           |           RST $38
9A82 FF           |           RST $38
9A83 00           |           NOP
9A84 C0           |           RET NZ
9A85 38 00        |           JR C,9A87h
9A87 00           |           NOP
9A88 00           |           NOP
9A89 00           |           NOP
9A8A 41           |           LD B,C
9A8B 00           |           NOP
9A8C 00           |           NOP
9A8D 00           |           NOP
9A8E 00           |           NOP
9A8F 00           |           NOP
9A90 00           |           NOP
9A91 00           |           NOP
9A92 00           |           NOP
9A93 00           |           NOP
9A94 00           |           NOP
9A95 00           |           NOP
9A96 00           |           NOP
9A97 00           |           NOP
9A98 00           |           NOP
9A99 00           |           NOP
9A9A 00           |           NOP
9A9B 00           |           NOP
9A9C 00           |           NOP
9A9D 00           |           NOP
9A9E 00           |           NOP
9A9F BE           |           CP (HL)
9AA0 FF           |           RST $38
9AA1 FF           |           RST $38
9AA2 FF           |           RST $38
9AA3 FF           |           RST $38
9AA4 FF           |           RST $38
9AA5 01 00 00     |           LD BC,0000h
9AA8 00           |           NOP
9AA9 00           |           NOP
9AAA 00           |           NOP
9AAB FF           |           RST $38
9AAC 00           |           NOP
9AAD 00           |           NOP
9AAE 00           |           NOP
9AAF 51           |           LD D,C
9AB0 6D           |           LD L,L
9AB1 CE E2        |           ADC A,E2h
9AB3 44           |           LD B,H
9AB4 45           |           LD B,L
9AB5 43           |           LD B,E
9AB6 20 5B        |           JR NZ,9B13h
9AB8 52           |           LD D,D
9AB9 2C           |           INC L
9ABA 28 48        |           JR Z,9B04h
9ABC 4C           |           LD C,H
9ABD 29           |           ADD HL,HL
9ABE 5D           |           LD E,L
9ABF 00           |           NOP
9AC0 FF           |           RST $38
9AC1 DD 24        |           INC IXH
9AC3 3F           |           CCF
9AC4 00           |           NOP
9AC5 00           |           NOP
9AC6 FF           |           RST $38
9AC7 A0           |           AND B
9AC8 CC BB EE     |           CALL Z,EEBBh
9ACB DD           |           *ILLEGAL*
9ACC 11 44 FF     |           LD DE,FF44h
9ACF FF           |           RST $38
9AD0 FF           |           RST $38
9AD1 FF           |           RST $38
9AD2 34           |           INC (HL)
9AD3 12           |           LD (DE),A
9AD4 00           |           NOP
9AD5 C0           |           RET NZ
9AD6 20 08        |           JR NZ,9AE0h
9AD8 00           |           NOP
9AD9 00           |           NOP
9ADA 00           |           NOP
9ADB 41           |           LD B,C
9ADC 00           |           NOP
9ADD 00           |           NOP
9ADE 00           |           NOP
9ADF 00           |           NOP
9AE0 00           |           NOP
9AE1 00           |           NOP
9AE2 00           |           NOP
9AE3 00           |           NOP
9AE4 00           |           NOP
9AE5 00           |           NOP
9AE6 00           |           NOP
9AE7 00           |           NOP
9AE8 00           |           NOP
9AE9 00           |           NOP
9AEA 00           |           NOP
9AEB 00           |           NOP
9AEC 00           |           NOP
9AED 00           |           NOP
9AEE 00           |           NOP
9AEF 00           |           NOP
9AF0 BE           |           CP (HL)
9AF1 28 00        |           JR Z,9AF3h
9AF3 00           |           NOP
9AF4 00           |           NOP
9AF5 00           |           NOP
9AF6 00           |           NOP
9AF7 00           |           NOP
9AF8 FF           |           RST $38
9AF9 FF           |           RST $38
9AFA FF           |           RST $38
9AFB FF           |           RST $38
9AFC 00           |           NOP
9AFD 00           |           NOP
9AFE 00           |           NOP
9AFF 00           |           NOP
9B00 B5           |           OR L
9B01 75           |           LD (HL),L
9B02 FD           |           *ILLEGAL*
9B03 ED 49        |           OUT (C),C
9B05 4E           |           LD C,(HL)
9B06 43           |           LD B,E
9B07 20 58        |           JR NZ,9B61h
9B09 00           |           NOP
9B0A FF           |           RST $38
9B0B DD 25        |           DEC IXH
9B0D 3F           |           CCF
9B0E 00           |           NOP
9B0F 00           |           NOP
9B10 FF           |           RST $38
9B11 A0           |           AND B
9B12 CC BB EE     |           CALL Z,EEBBh
9B15 DD           |           *ILLEGAL*
9B16 11 44 00     |           LD DE,0044h
9B19 00           |           NOP
9B1A 00           |           NOP
9B1B 00           |           NOP
9B1C 34           |           INC (HL)
9B1D 12           |           LD (DE),A
9B1E 00           |           NOP
9B1F C0           |           RET NZ
9B20 20 08        |           JR NZ,9B2Ah
9B22 00           |           NOP
9B23 00           |           NOP
9B24 00           |           NOP
9B25 41           |           LD B,C
9B26 00           |           NOP
9B27 00           |           NOP
9B28 00           |           NOP
9B29 00           |           NOP
9B2A 00           |           NOP
9B2B 00           |           NOP
9B2C 00           |           NOP
9B2D 00           |           NOP
9B2E 00           |           NOP
9B2F 00           |           NOP
9B30 00           |           NOP
9B31 00           |           NOP
9B32 00           |           NOP
9B33 00           |           NOP
9B34 00           |           NOP
9B35 00           |           NOP
9B36 00           |           NOP
9B37 00           |           NOP
9B38 00           |           NOP
9B39 00           |           NOP
9B3A BE           |           CP (HL)
9B3B 28 00        |           JR Z,9B3Dh
9B3D 00           |           NOP
9B3E 00           |           NOP
9B3F 00           |           NOP
9B40 00           |           NOP
9B41 00           |           NOP
9B42 FF           |           RST $38
9B43 FF           |           RST $38
9B44 FF           |           RST $38
9B45 FF           |           RST $38
9B46 00           |           NOP
9B47 00           |           NOP
9B48 00           |           NOP
9B49 00           |           NOP
9B4A C2 72 DC     |           JP NZ,DC72h
9B4D 96           |           SUB A,(HL)
9B4E 44           |           LD B,H
9B4F 45           |           LD B,L
9B50 43           |           LD B,E
9B51 20 58        |           JR NZ,9BABh
9B53 00           |           NOP
9B54 FF           |           RST $38
9B55 DD 34 00     |           INC (IX+00h)
9B58 3F           |           CCF
9B59 00           |           NOP
9B5A FF           |           RST $38
9B5B AA           |           XOR D
9B5C CC BB EE     |           CALL Z,EEBBh
9B5F DD           |           *ILLEGAL*
9B60 11 44 0C     |           LD DE,0C44h
9B63 88           |           ADC A,B
9B64 0C           |           INC C
9B65 88           |           ADC A,B
9B66 FF           |           RST $38
9B67 FF           |           RST $38
9B68 00           |           NOP
9B69 C0           |           RET NZ
9B6A 20 00        |           JR NZ,9B6Ch
9B6C 00           |           NOP
9B6D 00           |           NOP
9B6E 00           |           NOP
9B6F 41           |           LD B,C
9B70 00           |           NOP
9B71 00           |           NOP
9B72 00           |           NOP
9B73 00           |           NOP
9B74 00           |           NOP
9B75 00           |           NOP
9B76 00           |           NOP
9B77 00           |           NOP
9B78 00           |           NOP
9B79 00           |           NOP
9B7A 00           |           NOP
9B7B 01 00 00     |           LD BC,0000h
9B7E 00           |           NOP
9B7F 00           |           NOP
9B80 00           |           NOP
9B81 01 00 00     |           LD BC,0000h
9B84 BE           |           CP (HL)
9B85 28 00        |           JR Z,9B87h
9B87 00           |           NOP
9B88 00           |           NOP
9B89 00           |           NOP
9B8A 00           |           NOP
9B8B 00           |           NOP
9B8C 01 00 01     |           LD BC,0100h
9B8F 00           |           NOP
9B90 FE 00        |           CP 00h
9B92 00           |           NOP
9B93 00           |           NOP
9B94 AF           |           XOR A
9B95 1B           |           DEC DE
9B96 42           |           LD B,D
9B97 4A           |           LD C,D
9B98 49           |           LD C,C
9B99 4E           |           LD C,(HL)
9B9A 43           |           LD B,E
9B9B 20 28        |           JR NZ,9BC5h
9B9D 58           |           LD E,B
9B9E 59           |           LD E,C
9B9F 29           |           ADD HL,HL
9BA0 00           |           NOP
9BA1 FF           |           RST $38
9BA2 DD 35 00     |           DEC (IX+00h)
9BA5 3F           |           CCF
9BA6 00           |           NOP
9BA7 FF           |           RST $38
9BA8 AA           |           XOR D
9BA9 CC BB EE     |           CALL Z,EEBBh
9BAC DD           |           *ILLEGAL*
9BAD 11 44 0C     |           LD DE,0C44h
9BB0 88           |           ADC A,B
9BB1 0C           |           INC C
9BB2 88           |           ADC A,B
9BB3 00           |           NOP
9BB4 00           |           NOP
9BB5 00           |           NOP
9BB6 C0           |           RET NZ
9BB7 20 00        |           JR NZ,9BB9h
9BB9 00           |           NOP
9BBA 00           |           NOP
9BBB 00           |           NOP
9BBC 41           |           LD B,C
9BBD 00           |           NOP
9BBE 00           |           NOP
9BBF 00           |           NOP
9BC0 00           |           NOP
9BC1 00           |           NOP
9BC2 00           |           NOP
9BC3 00           |           NOP
9BC4 00           |           NOP
9BC5 00           |           NOP
9BC6 00           |           NOP
9BC7 00           |           NOP
9BC8 01 00 00     |           LD BC,0000h
9BCB 00           |           NOP
9BCC 00           |           NOP
9BCD 00           |           NOP
9BCE 01 00 00     |           LD BC,0000h
9BD1 BE           |           CP (HL)
9BD2 28 00        |           JR Z,9BD4h
9BD4 00           |           NOP
9BD5 00           |           NOP
9BD6 00           |           NOP
9BD7 00           |           NOP
9BD8 00           |           NOP
9BD9 01 00 01     |           LD BC,0100h
9BDC 00           |           NOP
9BDD FE 00        |           CP 00h
9BDF 00           |           NOP
9BE0 00           |           NOP
9BE1 AF           |           XOR A
9BE2 FD           |           *ILLEGAL*
9BE3 BB           |           CP E
9BE4 9C           |           SBC A,H
9BE5 44           |           LD B,H
9BE6 45           |           LD B,L
9BE7 43           |           LD B,E
9BE8 20 28        |           JR NZ,9C12h
9BEA 58           |           LD E,B
9BEB 59           |           LD E,C
9BEC 29           |           ADD HL,HL
9BED 00           |           NOP
9BEE FF           |           RST $38
9BEF 03           |           INC BC
9BF0 3F           |           CCF
9BF1 00           |           NOP
9BF2 00           |           NOP
9BF3 00           |           NOP
9BF4 FF           |           RST $38
9BF5 AA           |           XOR D
9BF6 FF           |           RST $38
9BF7 FF           |           RST $38
9BF8 FF           |           RST $38
9BF9 FF           |           RST $38
9BFA FF           |           RST $38
9BFB FF           |           RST $38
9BFC 88           |           ADC A,B
9BFD DD 77 FD     |           LD (IX+FDh),A
9C00 34           |           INC (HL)
9C01 12           |           LD (DE),A
9C02 FF           |           RST $38
9C03 FF           |           RST $38
9C04 30 00        |           JR NC,9C06h
9C06 00           |           NOP
9C07 00           |           NOP
9C08 00           |           NOP
9C09 00           |           NOP
9C0A 00           |           NOP
9C0B 01 00 01     |           LD BC,0100h
9C0E 00           |           NOP
9C0F 01 00 00     |           LD BC,0000h
9C12 00           |           NOP
9C13 00           |           NOP
9C14 00           |           NOP
9C15 00           |           NOP
9C16 00           |           NOP
9C17 01 00 00     |           LD BC,0000h
9C1A 00           |           NOP
9C1B 00           |           NOP
9C1C 00           |           NOP
9C1D 00           |           NOP
9C1E FF           |           RST $38
9C1F 28 FE        |           JR Z,9C1Fh
9C21 FF           |           RST $38
9C22 FE FF        |           CP FFh
9C24 FE FF        |           CP FFh
9C26 00           |           NOP
9C27 00           |           NOP
9C28 00           |           NOP
9C29 00           |           NOP
9C2A 00           |           NOP
9C2B 00           |           NOP
9C2C FE FF        |           CP FFh
9C2E 0C           |           INC C
9C2F ED           |           *ILLEGAL*
9C30 C9           |           RET
9C31 1D           |           DEC E
9C32 49           |           LD C,C
9C33 4E           |           LD C,(HL)
9C34 43           |           LD B,E
9C35 20 52        |           JR NZ,9C89h
9C37 52           |           LD D,D
9C38 00           |           NOP
9C39 FF           |           RST $38
9C3A 0B           |           DEC BC
9C3B 3F           |           CCF
9C3C 00           |           NOP
9C3D 00           |           NOP
9C3E 00           |           NOP
9C3F FF           |           RST $38
9C40 AA           |           XOR D
9C41 00           |           NOP
9C42 00           |           NOP
9C43 00           |           NOP
9C44 00           |           NOP
9C45 00           |           NOP
9C46 00           |           NOP
9C47 88           |           ADC A,B
9C48 DD 77 FD     |           LD (IX+FDh),A
9C4B 34           |           INC (HL)
9C4C 12           |           LD (DE),A
9C4D 00           |           NOP
9C4E 00           |           NOP
9C4F 30 00        |           JR NC,9C51h
9C51 00           |           NOP
9C52 00           |           NOP
9C53 00           |           NOP
9C54 00           |           NOP
9C55 00           |           NOP
9C56 01 00 01     |           LD BC,0100h
9C59 00           |           NOP
9C5A 01 00 00     |           LD BC,0000h
9C5D 00           |           NOP
9C5E 00           |           NOP
9C5F 00           |           NOP
9C60 00           |           NOP
9C61 00           |           NOP
9C62 01 00 00     |           LD BC,0000h
9C65 00           |           NOP
9C66 00           |           NOP
9C67 00           |           NOP
9C68 00           |           NOP
9C69 FF           |           RST $38
9C6A 28 FE        |           JR Z,9C6Ah
9C6C FF           |           RST $38
9C6D FE FF        |           CP FFh
9C6F FE FF        |           CP FFh
9C71 00           |           NOP
9C72 00           |           NOP
9C73 00           |           NOP
9C74 00           |           NOP
9C75 00           |           NOP
9C76 00           |           NOP
9C77 FE FF        |           CP FFh
9C79 0C           |           INC C
9C7A ED           |           *ILLEGAL*
9C7B C9           |           RET
9C7C 1D           |           DEC E
9C7D 44           |           LD B,H
9C7E 45           |           LD B,L
9C7F 43           |           LD B,E
9C80 20 52        |           JR NZ,9CD4h
9C82 52           |           LD D,D
9C83 00           |           NOP
9C84 FF           |           RST $38
9C85 DD 23        |           INC IX
9C87 3F           |           CCF
9C88 00           |           NOP
9C89 00           |           NOP
9C8A FF           |           RST $38
9C8B AA           |           XOR D
9C8C CC BB EE     |           CALL Z,EEBBh
9C8F DD           |           *ILLEGAL*
9C90 11 44 FF     |           LD DE,FF44h
9C93 FF           |           RST $38
9C94 FF           |           RST $38
9C95 FF           |           RST $38
9C96 34           |           INC (HL)
9C97 12           |           LD (DE),A
9C98 00           |           NOP
9C99 C0           |           RET NZ
9C9A 20 00        |           JR NZ,9C9Ch
9C9C 00           |           NOP
9C9D 00           |           NOP
9C9E 00           |           NOP
9C9F 00           |           NOP
9CA0 00           |           NOP
9CA1 00           |           NOP
9CA2 00           |           NOP
9CA3 00           |           NOP
9CA4 00           |           NOP
9CA5 00           |           NOP
9CA6 00           |           NOP
9CA7 01 00 01     |           LD BC,0100h
9CAA 00           |           NOP
9CAB 00           |           NOP
9CAC 00           |           NOP
9CAD 00           |           NOP
9CAE 00           |           NOP
9CAF 00           |           NOP
9CB0 00           |           NOP
9CB1 00           |           NOP
9CB2 00           |           NOP
9CB3 00           |           NOP
9CB4 FF           |           RST $38
9CB5 28 00        |           JR Z,9CB7h
9CB7 00           |           NOP
9CB8 00           |           NOP
9CB9 00           |           NOP
9CBA 00           |           NOP
9CBB 00           |           NOP
9CBC FE FF        |           CP FFh
9CBE FE FF        |           CP FFh
9CC0 00           |           NOP
9CC1 00           |           NOP
9CC2 00           |           NOP
9CC3 00           |           NOP
9CC4 C6 E8        |           ADD A,E8h
9CC6 49           |           LD C,C
9CC7 4F           |           LD C,A
9CC8 49           |           LD C,C
9CC9 4E           |           LD C,(HL)
9CCA 43           |           LD B,E
9CCB 20 58        |           JR NZ,9D25h
9CCD 59           |           LD E,C
9CCE 00           |           NOP
9CCF FF           |           RST $38
9CD0 DD 2B        |           DEC IX
9CD2 3F           |           CCF
9CD3 00           |           NOP
9CD4 00           |           NOP
9CD5 FF           |           RST $38
9CD6 AA           |           XOR D
9CD7 CC BB EE     |           CALL Z,EEBBh
9CDA DD           |           *ILLEGAL*
9CDB 11 44 00     |           LD DE,0044h
9CDE 00           |           NOP
9CDF 00           |           NOP
9CE0 00           |           NOP
9CE1 34           |           INC (HL)
9CE2 12           |           LD (DE),A
9CE3 00           |           NOP
9CE4 C0           |           RET NZ
9CE5 20 00        |           JR NZ,9CE7h
9CE7 00           |           NOP
9CE8 00           |           NOP
9CE9 00           |           NOP
9CEA 00           |           NOP
9CEB 00           |           NOP
9CEC 00           |           NOP
9CED 00           |           NOP
9CEE 00           |           NOP
9CEF 00           |           NOP
9CF0 00           |           NOP
9CF1 00           |           NOP
9CF2 01 00 01     |           LD BC,0100h
9CF5 00           |           NOP
9CF6 00           |           NOP
9CF7 00           |           NOP
9CF8 00           |           NOP
9CF9 00           |           NOP
9CFA 00           |           NOP
9CFB 00           |           NOP
9CFC 00           |           NOP
9CFD 00           |           NOP
9CFE 00           |           NOP
9CFF FF           |           RST $38
9D00 28 00        |           JR Z,9D02h
9D02 00           |           NOP
9D03 00           |           NOP
9D04 00           |           NOP
9D05 00           |           NOP
9D06 00           |           NOP
9D07 FE FF        |           CP FFh
9D09 FE FF        |           CP FFh
9D0B 00           |           NOP
9D0C 00           |           NOP
9D0D 00           |           NOP
9D0E 00           |           NOP
9D0F C6 E8        |           ADD A,E8h
9D11 49           |           LD C,C
9D12 4F           |           LD C,A
9D13 44           |           LD B,H
9D14 45           |           LD B,L
9D15 43           |           LD B,E
9D16 20 58        |           JR NZ,9D70h
9D18 59           |           LD E,C
9D19 00           |           NOP
9D1A FF           |           RST $38
9D1B 09           |           ADD HL,BC
9D1C 3F           |           CCF
9D1D 00           |           NOP
9D1E 00           |           NOP
9D1F 00           |           NOP
9D20 FF           |           RST $38
9D21 AA           |           XOR D
9D22 00           |           NOP
9D23 00           |           NOP
9D24 00           |           NOP
9D25 00           |           NOP
9D26 00           |           NOP
9D27 00           |           NOP
9D28 88           |           ADC A,B
9D29 DD 77 FD     |           LD (IX+FDh),A
9D2C 34           |           INC (HL)
9D2D 12           |           LD (DE),A
9D2E 00           |           NOP
9D2F 00           |           NOP
9D30 30 00        |           JR NC,9D32h
9D32 00           |           NOP
9D33 00           |           NOP
9D34 00           |           NOP
9D35 00           |           NOP
9D36 00           |           NOP
9D37 00           |           NOP
9D38 00           |           NOP
9D39 00           |           NOP
9D3A 00           |           NOP
9D3B 00           |           NOP
9D3C C8           |           RET Z
9D3D 00           |           NOP
9D3E 00           |           NOP
9D3F 00           |           NOP
9D40 00           |           NOP
9D41 00           |           NOP
9D42 00           |           NOP
9D43 00           |           NOP
9D44 00           |           NOP
9D45 00           |           NOP
9D46 00           |           NOP
9D47 00           |           NOP
9D48 00           |           NOP
9D49 00           |           NOP
9D4A FF           |           RST $38
9D4B 28 FF        |           JR Z,9D4Ch
9D4D FF           |           RST $38
9D4E FF           |           RST $38
9D4F FF           |           RST $38
9D50 FF           |           RST $38
9D51 37           |           SCF
9D52 00           |           NOP
9D53 00           |           NOP
9D54 00           |           NOP
9D55 00           |           NOP
9D56 00           |           NOP
9D57 00           |           NOP
9D58 FF           |           RST $38
9D59 FF           |           RST $38
9D5A 83           |           ADD A,E
9D5B 4A           |           LD C,D
9D5C 2B           |           DEC HL
9D5D EB           |           EX DE,HL
9D5E 41           |           LD B,C
9D5F 44           |           LD B,H
9D60 44           |           LD B,H
9D61 20 48        |           JR NZ,9DABh
9D63 4C           |           LD C,H
9D64 2C           |           INC L
9D65 52           |           LD D,D
9D66 52           |           LD D,D
9D67 00           |           NOP
9D68 FF           |           RST $38
9D69 DD 09        |           ADD IX,BC
9D6B 3F           |           CCF
9D6C 00           |           NOP
9D6D 00           |           NOP
9D6E FF           |           RST $38
9D6F AA           |           XOR D
9D70 00           |           NOP
9D71 00           |           NOP
9D72 00           |           NOP
9D73 00           |           NOP
9D74 11 44 00     |           LD DE,0044h
9D77 00           |           NOP
9D78 77           |           LD (HL),A
9D79 FD 34 12     |           INC (IY+12h)
9D7C 00           |           NOP
9D7D 00           |           NOP
9D7E 00           |           NOP
9D7F 30 00        |           JR NC,9D81h
9D81 00           |           NOP
9D82 00           |           NOP
9D83 00           |           NOP
9D84 00           |           NOP
9D85 00           |           NOP
9D86 00           |           NOP
9D87 00           |           NOP
9D88 00           |           NOP
9D89 00           |           NOP
9D8A 00           |           NOP
9D8B 00           |           NOP
9D8C C8           |           RET Z
9D8D 00           |           NOP
9D8E 00           |           NOP
9D8F 00           |           NOP
9D90 00           |           NOP
9D91 00           |           NOP
9D92 00           |           NOP
9D93 00           |           NOP
9D94 00           |           NOP
9D95 00           |           NOP
9D96 00           |           NOP
9D97 00           |           NOP
9D98 FF           |           RST $38
9D99 28 FF        |           JR Z,9D9Ah
9D9B FF           |           RST $38
9D9C FF           |           RST $38
9D9D FF           |           RST $38
9D9E 00           |           NOP
9D9F 00           |           NOP
9DA0 FF           |           RST $38
9DA1 37           |           SCF
9DA2 00           |           NOP
9DA3 00           |           NOP
9DA4 00           |           NOP
9DA5 00           |           NOP
9DA6 FF           |           RST $38
9DA7 FF           |           RST $38
9DA8 83           |           ADD A,E
9DA9 4A           |           LD C,D
9DAA 2B           |           DEC HL
9DAB EB           |           EX DE,HL
9DAC 41           |           LD B,C
9DAD 44           |           LD B,H
9DAE 44           |           LD B,H
9DAF 20 49        |           JR NZ,9DFAh
9DB1 58           |           LD E,B
9DB2 2C           |           INC L
9DB3 52           |           LD D,D
9DB4 52           |           LD D,D
9DB5 00           |           NOP
9DB6 FF           |           RST $38
9DB7 FD 09        |           ADD IY,BC
9DB9 3F           |           CCF
9DBA 00           |           NOP
9DBB 00           |           NOP
9DBC FF           |           RST $38
9DBD AA           |           XOR D
9DBE 00           |           NOP
9DBF 00           |           NOP
9DC0 00           |           NOP
9DC1 00           |           NOP
9DC2 11 44 88     |           LD DE,8844h
9DC5 DD           |           *ILLEGAL*
9DC6 00           |           NOP
9DC7 00           |           NOP
9DC8 34           |           INC (HL)
9DC9 12           |           LD (DE),A
9DCA 00           |           NOP
9DCB 00           |           NOP
9DCC 00           |           NOP
9DCD 30 00        |           JR NC,9DCFh
9DCF 00           |           NOP
9DD0 00           |           NOP
9DD1 00           |           NOP
9DD2 00           |           NOP
9DD3 00           |           NOP
9DD4 00           |           NOP
9DD5 00           |           NOP
9DD6 00           |           NOP
9DD7 00           |           NOP
9DD8 00           |           NOP
9DD9 00           |           NOP
9DDA 00           |           NOP
9DDB 00           |           NOP
9DDC C8           |           RET Z
9DDD 00           |           NOP
9DDE 00           |           NOP
9DDF 00           |           NOP
9DE0 00           |           NOP
9DE1 00           |           NOP
9DE2 00           |           NOP
9DE3 00           |           NOP
9DE4 00           |           NOP
9DE5 00           |           NOP
9DE6 FF           |           RST $38
9DE7 28 FF        |           JR Z,9DE8h
9DE9 FF           |           RST $38
9DEA FF           |           RST $38
9DEB FF           |           RST $38
9DEC 00           |           NOP
9DED 00           |           NOP
9DEE 00           |           NOP
9DEF 00           |           NOP
9DF0 FF           |           RST $38
9DF1 37           |           SCF
9DF2 00           |           NOP
9DF3 00           |           NOP
9DF4 FF           |           RST $38
9DF5 FF           |           RST $38
9DF6 83           |           ADD A,E
9DF7 4A           |           LD C,D
9DF8 2B           |           DEC HL
9DF9 EB           |           EX DE,HL
9DFA 41           |           LD B,C
9DFB 44           |           LD B,H
9DFC 44           |           LD B,H
9DFD 20 49        |           JR NZ,9E48h
9DFF 59           |           LD E,C
9E00 2C           |           INC L
9E01 52           |           LD D,D
9E02 52           |           LD D,D
9E03 00           |           NOP
9E04 FF           |           RST $38
9E05 ED 4A        |           ADC HL,BC
9E07 3F           |           CCF
9E08 00           |           NOP
9E09 00           |           NOP
9E0A FF           |           RST $38
9E0B AA           |           XOR D
9E0C 00           |           NOP
9E0D 00           |           NOP
9E0E 00           |           NOP
9E0F 00           |           NOP
9E10 00           |           NOP
9E11 00           |           NOP
9E12 88           |           ADC A,B
9E13 DD 77 FD     |           LD (IX+FDh),A
9E16 34           |           INC (HL)
9E17 12           |           LD (DE),A
9E18 00           |           NOP
9E19 00           |           NOP
9E1A 00           |           NOP
9E1B 30 00        |           JR NC,9E1Dh
9E1D 00           |           NOP
9E1E 00           |           NOP
9E1F 01 00 00     |           LD BC,0000h
9E22 00           |           NOP
9E23 00           |           NOP
9E24 00           |           NOP
9E25 00           |           NOP
9E26 C8           |           RET Z
9E27 00           |           NOP
9E28 00           |           NOP
9E29 00           |           NOP
9E2A 00           |           NOP
9E2B 00           |           NOP
9E2C 00           |           NOP
9E2D 00           |           NOP
9E2E 00           |           NOP
9E2F 00           |           NOP
9E30 00           |           NOP
9E31 00           |           NOP
9E32 00           |           NOP
9E33 00           |           NOP
9E34 FE 28        |           CP 28h
9E36 FF           |           RST $38
9E37 FF           |           RST $38
9E38 FF           |           RST $38
9E39 FF           |           RST $38
9E3A FF           |           RST $38
9E3B 37           |           SCF
9E3C 00           |           NOP
9E3D 00           |           NOP
9E3E 00           |           NOP
9E3F 00           |           NOP
9E40 00           |           NOP
9E41 00           |           NOP
9E42 FF           |           RST $38
9E43 FF           |           RST $38
9E44 49           |           LD C,C
9E45 0E C3        |           LD C,C3h
9E47 D7           |           RST $10
9E48 41           |           LD B,C
9E49 44           |           LD B,H
9E4A 43           |           LD B,E
9E4B 20 48        |           JR NZ,9E95h
9E4D 4C           |           LD C,H
9E4E 2C           |           INC L
9E4F 52           |           LD D,D
9E50 52           |           LD D,D
9E51 00           |           NOP
9E52 FF           |           RST $38
9E53 ED 42        |           SBC HL,BC
9E55 3F           |           CCF
9E56 00           |           NOP
9E57 00           |           NOP
9E58 FF           |           RST $38
9E59 AA           |           XOR D
9E5A 00           |           NOP
9E5B 00           |           NOP
9E5C 00           |           NOP
9E5D 00           |           NOP
9E5E 00           |           NOP
9E5F 00           |           NOP
9E60 88           |           ADC A,B
9E61 DD 77 FD     |           LD (IX+FDh),A
9E64 34           |           INC (HL)
9E65 12           |           LD (DE),A
9E66 00           |           NOP
9E67 00           |           NOP
9E68 00           |           NOP
9E69 30 00        |           JR NC,9E6Bh
9E6B 00           |           NOP
9E6C 00           |           NOP
9E6D 01 00 00     |           LD BC,0000h
9E70 00           |           NOP
9E71 00           |           NOP
9E72 00           |           NOP
9E73 00           |           NOP
9E74 C8           |           RET Z
9E75 00           |           NOP
9E76 00           |           NOP
9E77 00           |           NOP
9E78 00           |           NOP
9E79 00           |           NOP
9E7A 00           |           NOP
9E7B 00           |           NOP
9E7C 00           |           NOP
9E7D 00           |           NOP
9E7E 00           |           NOP
9E7F 00           |           NOP
9E80 00           |           NOP
9E81 00           |           NOP
9E82 FE 28        |           CP 28h
9E84 FF           |           RST $38
9E85 FF           |           RST $38
9E86 FF           |           RST $38
9E87 FF           |           RST $38
9E88 FF           |           RST $38
9E89 37           |           SCF
9E8A 00           |           NOP
9E8B 00           |           NOP
9E8C 00           |           NOP
9E8D 00           |           NOP
9E8E 00           |           NOP
9E8F 00           |           NOP
9E90 FF           |           RST $38
9E91 FF           |           RST $38
9E92 6A           |           LD L,D
9E93 B9           |           CP C
9E94 7A           |           LD A,D
9E95 85           |           ADD A,L
9E96 53           |           LD D,E
9E97 42           |           LD B,D
9E98 43           |           LD B,E
9E99 20 48        |           JR NZ,9EE3h
9E9B 4C           |           LD C,H
9E9C 2C           |           INC L
9E9D 52           |           LD D,D
9E9E 52           |           LD D,D
9E9F 00           |           NOP
9EA0 FF           |           RST $38
9EA1 CB 47        |           BIT 0,A
9EA3 3F           |           CCF
9EA4 00           |           NOP
9EA5 00           |           NOP
9EA6 FF           |           RST $38
9EA7 AA           |           XOR D
9EA8 CC BB EE     |           CALL Z,EEBBh
9EAB DD           |           *ILLEGAL*
9EAC 11 44 88     |           LD DE,8844h
9EAF DD 77 FD     |           LD (IX+FDh),A
9EB2 34           |           INC (HL)
9EB3 12           |           LD (DE),A
9EB4 00           |           NOP
9EB5 C0           |           RET NZ
9EB6 00           |           NOP
9EB7 38 00        |           JR C,9EB9h
9EB9 00           |           NOP
9EBA 00           |           NOP
9EBB 28 28        |           JR Z,9EE5h
9EBD 00           |           NOP
9EBE 00           |           NOP
9EBF 00           |           NOP
9EC0 00           |           NOP
9EC1 00           |           NOP
9EC2 00           |           NOP
9EC3 00           |           NOP
9EC4 00           |           NOP
9EC5 00           |           NOP
9EC6 00           |           NOP
9EC7 00           |           NOP
9EC8 00           |           NOP
9EC9 00           |           NOP
9ECA 00           |           NOP
9ECB 00           |           NOP
9ECC 00           |           NOP
9ECD 00           |           NOP
9ECE 00           |           NOP
9ECF 00           |           NOP
9ED0 D7           |           RST $10
9ED1 D7           |           RST $10
9ED2 00           |           NOP
9ED3 00           |           NOP
9ED4 00           |           NOP
9ED5 00           |           NOP
9ED6 00           |           NOP
9ED7 00           |           NOP
9ED8 00           |           NOP
9ED9 00           |           NOP
9EDA 00           |           NOP
9EDB 00           |           NOP
9EDC 00           |           NOP
9EDD 00           |           NOP
9EDE 00           |           NOP
9EDF 00           |           NOP
9EE0 20 23        |           JR NZ,9F05h
9EE2 D1           |           POP DE
9EE3 A2           |           AND D
9EE4 42           |           LD B,D
9EE5 49           |           LD C,C
9EE6 54           |           LD D,H
9EE7 20 4E        |           JR NZ,9F37h
9EE9 2C           |           INC L
9EEA 41           |           LD B,C
9EEB 00           |           NOP
9EEC FF           |           RST $38
9EED CB 46        |           BIT 0,(HL)
9EEF 3F           |           CCF
9EF0 00           |           NOP
9EF1 00           |           NOP
9EF2 FF           |           RST $38
9EF3 AA           |           XOR D
9EF4 CC BB EE     |           CALL Z,EEBBh
9EF7 DD           |           *ILLEGAL*
9EF8 0C           |           INC C
9EF9 88           |           ADC A,B
9EFA 88           |           ADC A,B
9EFB DD 77 FD     |           LD (IX+FDh),A
9EFE 34           |           INC (HL)
9EFF 12           |           LD (DE),A
9F00 00           |           NOP
9F01 C0           |           RET NZ
9F02 00           |           NOP
9F03 38 00        |           JR C,9F05h
9F05 00           |           NOP
9F06 00           |           NOP
9F07 28 00        |           JR Z,9F09h
9F09 00           |           NOP
9F0A 00           |           NOP
9F0B 00           |           NOP
9F0C 00           |           NOP
9F0D 00           |           NOP
9F0E 00           |           NOP
9F0F 00           |           NOP
9F10 00           |           NOP
9F11 00           |           NOP
9F12 00           |           NOP
9F13 28 00        |           JR Z,9F15h
9F15 00           |           NOP
9F16 00           |           NOP
9F17 00           |           NOP
9F18 00           |           NOP
9F19 00           |           NOP
9F1A 00           |           NOP
9F1B 00           |           NOP
9F1C D7           |           RST $10
9F1D 28 00        |           JR Z,9F1Fh
9F1F 00           |           NOP
9F20 00           |           NOP
9F21 00           |           NOP
9F22 01 00 00     |           LD BC,0000h
9F25 00           |           NOP
9F26 00           |           NOP
9F27 00           |           NOP
9F28 D7           |           RST $10
9F29 00           |           NOP
9F2A 00           |           NOP
9F2B 00           |           NOP
9F2C 77           |           LD (HL),A
9F2D B2           |           OR D
9F2E 26 58        |           LD H,58h
9F30 42           |           LD B,D
9F31 49           |           LD C,C
9F32 54           |           LD D,H
9F33 20 4E        |           JR NZ,9F83h
9F35 2C           |           INC L
9F36 28 48        |           JR Z,9F80h
9F38 4C           |           LD C,H
9F39 29           |           ADD HL,HL
9F3A 00           |           NOP
9F3B FF           |           RST $38
9F3C CB 40        |           BIT 0,B
9F3E 3F           |           CCF
9F3F 00           |           NOP
9F40 00           |           NOP
9F41 FF           |           RST $38
9F42 AA           |           XOR D
9F43 CC BB EE     |           CALL Z,EEBBh
9F46 DD           |           *ILLEGAL*
9F47 0C           |           INC C
9F48 88           |           ADC A,B
9F49 88           |           ADC A,B
9F4A DD 77 FD     |           LD (IX+FDh),A
9F4D 34           |           INC (HL)
9F4E 12           |           LD (DE),A
9F4F 00           |           NOP
9F50 C0           |           RET NZ
9F51 00           |           NOP
9F52 3F           |           CCF
9F53 00           |           NOP
9F54 00           |           NOP
9F55 00           |           NOP
9F56 28 00        |           JR Z,9F58h
9F58 00           |           NOP
9F59 00           |           NOP
9F5A 00           |           NOP
9F5B 00           |           NOP
9F5C 00           |           NOP
9F5D 00           |           NOP
9F5E 00           |           NOP
9F5F 00           |           NOP
9F60 00           |           NOP
9F61 00           |           NOP
9F62 00           |           NOP
9F63 00           |           NOP
9F64 00           |           NOP
9F65 00           |           NOP
9F66 00           |           NOP
9F67 00           |           NOP
9F68 00           |           NOP
9F69 00           |           NOP
9F6A 00           |           NOP
9F6B D7           |           RST $10
9F6C 28 FF        |           JR Z,9F6Dh
9F6E FF           |           RST $38
9F6F FF           |           RST $38
9F70 FF           |           RST $38
9F71 00           |           NOP
9F72 00           |           NOP
9F73 00           |           NOP
9F74 00           |           NOP
9F75 00           |           NOP
9F76 00           |           NOP
9F77 00           |           NOP
9F78 00           |           NOP
9F79 00           |           NOP
9F7A 00           |           NOP
9F7B 73           |           LD (HL),E
9F7C 6A           |           LD L,D
9F7D 3C           |           INC A
9F7E BA           |           CP D
9F7F 42           |           LD B,D
9F80 49           |           LD C,C
9F81 54           |           LD D,H
9F82 20 4E        |           JR NZ,9FD2h
9F84 2C           |           INC L
9F85 5B           |           LD E,E
9F86 52           |           LD D,D
9F87 2C           |           INC L
9F88 28 48        |           JR Z,9FD2h
9F8A 4C           |           LD C,H
9F8B 29           |           ADD HL,HL
9F8C 5D           |           LD E,L
9F8D 00           |           NOP
9F8E FF           |           RST $38
9F8F DD CB 00 46  |           BIT 0,(IX+{byte:02X}h)
9F93 3F           |           CCF
9F94 FF           |           RST $38
9F95 AA           |           XOR D
9F96 CC BB EE     |           CALL Z,EEBBh
9F99 DD           |           *ILLEGAL*
9F9A 11 44 0C     |           LD DE,0C44h
9F9D 88           |           ADC A,B
9F9E 0C           |           INC C
9F9F 88           |           ADC A,B
9FA0 34           |           INC (HL)
9FA1 12           |           LD (DE),A
9FA2 00           |           NOP
9FA3 C0           |           RET NZ
9FA4 20 00        |           JR NZ,9FA6h
9FA6 00           |           NOP
9FA7 38 00        |           JR C,9FA9h
9FA9 28 00        |           JR Z,9FABh
9FAB 00           |           NOP
9FAC 00           |           NOP
9FAD 00           |           NOP
9FAE 00           |           NOP
9FAF 00           |           NOP
9FB0 00           |           NOP
9FB1 00           |           NOP
9FB2 00           |           NOP
9FB3 00           |           NOP
9FB4 00           |           NOP
9FB5 00           |           NOP
9FB6 00           |           NOP
9FB7 00           |           NOP
9FB8 00           |           NOP
9FB9 00           |           NOP
9FBA 00           |           NOP
9FBB 01 00 00     |           LD BC,0000h
9FBE D7           |           RST $10
9FBF 28 00        |           JR Z,9FC1h
9FC1 00           |           NOP
9FC2 00           |           NOP
9FC3 00           |           NOP
9FC4 00           |           NOP
9FC5 00           |           NOP
9FC6 01 00 01     |           LD BC,0100h
9FC9 00           |           NOP
9FCA FF           |           RST $38
9FCB 00           |           NOP
9FCC 00           |           NOP
9FCD 00           |           NOP
9FCE A1           |           AND C
9FCF 6F           |           LD L,A
9FD0 24           |           INC H
9FD1 55           |           LD D,L
9FD2 42           |           LD B,D
9FD3 49           |           LD C,C
9FD4 54           |           LD D,H
9FD5 20 4E        |           JR NZ,A025h
9FD7 2C           |           INC L
9FD8 28 58        |           JR Z,A032h
9FDA 59           |           LD E,C
9FDB 29           |           ADD HL,HL
9FDC 00           |           NOP
9FDD FF           |           RST $38
9FDE DD CB 00 40  |           BIT 0,(IX+{byte:02X}h)
9FE2 3F           |           CCF
9FE3 FF           |           RST $38
9FE4 AA           |           XOR D
9FE5 CC BB EE     |           CALL Z,EEBBh
9FE8 DD           |           *ILLEGAL*
9FE9 11 44 0C     |           LD DE,0C44h
9FEC 88           |           ADC A,B
9FED 0C           |           INC C
9FEE 88           |           ADC A,B
9FEF 34           |           INC (HL)
9FF0 12           |           LD (DE),A
9FF1 00           |           NOP
9FF2 C0           |           RET NZ
9FF3 20 00        |           JR NZ,9FF5h
9FF5 00           |           NOP
9FF6 3F           |           CCF
9FF7 00           |           NOP
9FF8 28 00        |           JR Z,9FFAh
9FFA 00           |           NOP
9FFB 00           |           NOP
9FFC 00           |           NOP
9FFD 00           |           NOP
9FFE 00           |           NOP
9FFF 00           |           NOP
A000 00           |           NOP
A001 00           |           NOP
A002 00           |           NOP
A003 00           |           NOP
A004 00           |           NOP
A005 00           |           NOP
A006 00           |           NOP
A007 00           |           NOP
A008 00           |           NOP
A009 00           |           NOP
A00A 01 00 00     |           LD BC,0000h
A00D D7           |           RST $10
A00E 28 00        |           JR Z,A010h
A010 00           |           NOP
A011 00           |           NOP
A012 00           |           NOP
A013 00           |           NOP
A014 00           |           NOP
A015 01 00 01     |           LD BC,0100h
A018 00           |           NOP
A019 FF           |           RST $38
A01A 00           |           NOP
A01B 00           |           NOP
A01C 00           |           NOP
A01D 32 67 5F     |           LD (5F67h),A
A020 D1           |           POP DE
A021 42           |           LD B,D
A022 49           |           LD C,C
A023 54           |           LD D,H
A024 20 4E        |           JR NZ,A074h
A026 2C           |           INC L
A027 28 58        |           JR Z,A081h
A029 59           |           LD E,C
A02A 29           |           ADD HL,HL
A02B 2C           |           INC L
A02C 2D           |           DEC L
A02D 00           |           NOP
A02E FF           |           RST $38
A02F CB C7        |           SET 0,A
A031 3F           |           CCF
A032 00           |           NOP
A033 00           |           NOP
A034 FF           |           RST $38
A035 AA           |           XOR D
A036 CC BB EE     |           CALL Z,EEBBh
A039 DD           |           *ILLEGAL*
A03A 11 44 88     |           LD DE,8844h
A03D DD 77 FD     |           LD (IX+FDh),A
A040 34           |           INC (HL)
A041 12           |           LD (DE),A
A042 00           |           NOP
A043 C0           |           RET NZ
A044 00           |           NOP
A045 38 00        |           JR C,A047h
A047 00           |           NOP
A048 00           |           NOP
A049 00           |           NOP
A04A 00           |           NOP
A04B 00           |           NOP
A04C 00           |           NOP
A04D 00           |           NOP
A04E 00           |           NOP
A04F 00           |           NOP
A050 00           |           NOP
A051 00           |           NOP
A052 00           |           NOP
A053 00           |           NOP
A054 00           |           NOP
A055 00           |           NOP
A056 00           |           NOP
A057 00           |           NOP
A058 00           |           NOP
A059 00           |           NOP
A05A 00           |           NOP
A05B 00           |           NOP
A05C 00           |           NOP
A05D 00           |           NOP
A05E FF           |           RST $38
A05F FF           |           RST $38
A060 00           |           NOP
A061 00           |           NOP
A062 00           |           NOP
A063 00           |           NOP
A064 00           |           NOP
A065 00           |           NOP
A066 00           |           NOP
A067 00           |           NOP
A068 00           |           NOP
A069 00           |           NOP
A06A 00           |           NOP
A06B 00           |           NOP
A06C 00           |           NOP
A06D 00           |           NOP
A06E 56           |           LD D,(HL)
A06F 77           |           LD (HL),A
A070 9C           |           SBC A,H
A071 FD           |           *ILLEGAL*
A072 53           |           LD D,E
A073 45           |           LD B,L
A074 54           |           LD D,H
A075 20 4E        |           JR NZ,A0C5h
A077 2C           |           INC L
A078 41           |           LD B,C
A079 00           |           NOP
A07A FF           |           RST $38
A07B CB C6        |           SET 0,(HL)
A07D 3F           |           CCF
A07E 00           |           NOP
A07F 00           |           NOP
A080 FF           |           RST $38
A081 AA           |           XOR D
A082 CC BB EE     |           CALL Z,EEBBh
A085 DD           |           *ILLEGAL*
A086 0C           |           INC C
A087 88           |           ADC A,B
A088 88           |           ADC A,B
A089 DD 77 FD     |           LD (IX+FDh),A
A08C 34           |           INC (HL)
A08D 12           |           LD (DE),A
A08E 00           |           NOP
A08F C0           |           RET NZ
A090 00           |           NOP
A091 38 00        |           JR C,A093h
A093 00           |           NOP
A094 00           |           NOP
A095 00           |           NOP
A096 00           |           NOP
A097 00           |           NOP
A098 00           |           NOP
A099 00           |           NOP
A09A 00           |           NOP
A09B 00           |           NOP
A09C 00           |           NOP
A09D 00           |           NOP
A09E 00           |           NOP
A09F 00           |           NOP
A0A0 00           |           NOP
A0A1 00           |           NOP
A0A2 00           |           NOP
A0A3 00           |           NOP
A0A4 00           |           NOP
A0A5 00           |           NOP
A0A6 00           |           NOP
A0A7 00           |           NOP
A0A8 00           |           NOP
A0A9 00           |           NOP
A0AA FF           |           RST $38
A0AB 28 00        |           JR Z,A0ADh
A0AD 00           |           NOP
A0AE 00           |           NOP
A0AF 00           |           NOP
A0B0 01 00 00     |           LD BC,0000h
A0B3 00           |           NOP
A0B4 00           |           NOP
A0B5 00           |           NOP
A0B6 FF           |           RST $38
A0B7 00           |           NOP
A0B8 00           |           NOP
A0B9 00           |           NOP
A0BA A2           |           AND D
A0BB 0C           |           INC C
A0BC 0C           |           INC C
A0BD AF           |           XOR A
A0BE 53           |           LD D,E
A0BF 45           |           LD B,L
A0C0 54           |           LD D,H
A0C1 20 4E        |           JR NZ,A111h
A0C3 2C           |           INC L
A0C4 28 48        |           JR Z,A10Eh
A0C6 4C           |           LD C,H
A0C7 29           |           ADD HL,HL
A0C8 00           |           NOP
A0C9 FF           |           RST $38
A0CA CB C0        |           SET 0,B
A0CC 3F           |           CCF
A0CD 00           |           NOP
A0CE 00           |           NOP
A0CF FF           |           RST $38
A0D0 AA           |           XOR D
A0D1 CC BB EE     |           CALL Z,EEBBh
A0D4 DD           |           *ILLEGAL*
A0D5 0C           |           INC C
A0D6 88           |           ADC A,B
A0D7 88           |           ADC A,B
A0D8 DD 77 FD     |           LD (IX+FDh),A
A0DB 34           |           INC (HL)
A0DC 12           |           LD (DE),A
A0DD 00           |           NOP
A0DE C0           |           RET NZ
A0DF 00           |           NOP
A0E0 3F           |           CCF
A0E1 00           |           NOP
A0E2 00           |           NOP
A0E3 00           |           NOP
A0E4 00           |           NOP
A0E5 00           |           NOP
A0E6 00           |           NOP
A0E7 00           |           NOP
A0E8 00           |           NOP
A0E9 00           |           NOP
A0EA 00           |           NOP
A0EB 00           |           NOP
A0EC 00           |           NOP
A0ED 00           |           NOP
A0EE 00           |           NOP
A0EF 00           |           NOP
A0F0 00           |           NOP
A0F1 00           |           NOP
A0F2 00           |           NOP
A0F3 00           |           NOP
A0F4 00           |           NOP
A0F5 00           |           NOP
A0F6 00           |           NOP
A0F7 00           |           NOP
A0F8 00           |           NOP
A0F9 FF           |           RST $38
A0FA 28 FF        |           JR Z,A0FBh
A0FC FF           |           RST $38
A0FD FF           |           RST $38
A0FE FF           |           RST $38
A0FF 00           |           NOP
A100 00           |           NOP
A101 00           |           NOP
A102 00           |           NOP
A103 00           |           NOP
A104 00           |           NOP
A105 00           |           NOP
A106 00           |           NOP
A107 00           |           NOP
A108 00           |           NOP
A109 11 25 77     |           LD DE,7725h
A10C DD           |           *ILLEGAL*
A10D 53           |           LD D,E
A10E 45           |           LD B,L
A10F 54           |           LD D,H
A110 20 4E        |           JR NZ,A160h
A112 2C           |           INC L
A113 5B           |           LD E,E
A114 52           |           LD D,D
A115 2C           |           INC L
A116 28 48        |           JR Z,A160h
A118 4C           |           LD C,H
A119 29           |           ADD HL,HL
A11A 5D           |           LD E,L
A11B 00           |           NOP
A11C FF           |           RST $38
A11D DD CB 00 C6  |           SET 0,(IX+{byte:02X}h)
A121 3F           |           CCF
A122 FF           |           RST $38
A123 AA           |           XOR D
A124 CC BB EE     |           CALL Z,EEBBh
A127 DD           |           *ILLEGAL*
A128 11 44 0C     |           LD DE,0C44h
A12B 88           |           ADC A,B
A12C 0C           |           INC C
A12D 88           |           ADC A,B
A12E 34           |           INC (HL)
A12F 12           |           LD (DE),A
A130 00           |           NOP
A131 C0           |           RET NZ
A132 20 00        |           JR NZ,A134h
A134 00           |           NOP
A135 38 00        |           JR C,A137h
A137 00           |           NOP
A138 00           |           NOP
A139 00           |           NOP
A13A 00           |           NOP
A13B 00           |           NOP
A13C 00           |           NOP
A13D 00           |           NOP
A13E 00           |           NOP
A13F 00           |           NOP
A140 00           |           NOP
A141 00           |           NOP
A142 00           |           NOP
A143 00           |           NOP
A144 00           |           NOP
A145 00           |           NOP
A146 00           |           NOP
A147 00           |           NOP
A148 00           |           NOP
A149 01 00 00     |           LD BC,0000h
A14C FF           |           RST $38
A14D 28 00        |           JR Z,A14Fh
A14F 00           |           NOP
A150 00           |           NOP
A151 00           |           NOP
A152 00           |           NOP
A153 00           |           NOP
A154 01 00 01     |           LD BC,0100h
A157 00           |           NOP
A158 FF           |           RST $38
A159 00           |           NOP
A15A 00           |           NOP
A15B 00           |           NOP
A15C C9           |           RET
A15D 0F           |           RRCA
A15E AD           |           XOR L
A15F AD           |           XOR L
A160 53           |           LD D,E
A161 45           |           LD B,L
A162 54           |           LD D,H
A163 20 4E        |           JR NZ,A1B3h
A165 2C           |           INC L
A166 28 58        |           JR Z,A1C0h
A168 59           |           LD E,C
A169 29           |           ADD HL,HL
A16A 00           |           NOP
A16B FF           |           RST $38
A16C DD CB 00 C0  |           SET 0,(IX+{byte:02X}h)
A170 3F           |           CCF
A171 FF           |           RST $38
A172 AA           |           XOR D
A173 CC BB EE     |           CALL Z,EEBBh
A176 DD           |           *ILLEGAL*
A177 11 44 0C     |           LD DE,0C44h
A17A 88           |           ADC A,B
A17B 0C           |           INC C
A17C 88           |           ADC A,B
A17D 34           |           INC (HL)
A17E 12           |           LD (DE),A
A17F 00           |           NOP
A180 C0           |           RET NZ
A181 20 00        |           JR NZ,A183h
A183 00           |           NOP
A184 3F           |           CCF
A185 00           |           NOP
A186 00           |           NOP
A187 00           |           NOP
A188 00           |           NOP
A189 00           |           NOP
A18A 00           |           NOP
A18B 00           |           NOP
A18C 00           |           NOP
A18D 00           |           NOP
A18E 00           |           NOP
A18F 00           |           NOP
A190 00           |           NOP
A191 00           |           NOP
A192 00           |           NOP
A193 00           |           NOP
A194 00           |           NOP
A195 00           |           NOP
A196 00           |           NOP
A197 00           |           NOP
A198 01 00 00     |           LD BC,0000h
A19B FF           |           RST $38
A19C 28 00        |           JR Z,A19Eh
A19E 00           |           NOP
A19F 00           |           NOP
A1A0 00           |           NOP
A1A1 00           |           NOP
A1A2 00           |           NOP
A1A3 01 00 01     |           LD BC,0100h
A1A6 00           |           NOP
A1A7 FF           |           RST $38
A1A8 00           |           NOP
A1A9 00           |           NOP
A1AA 00           |           NOP
A1AB 24           |           INC H
A1AC 6F           |           LD L,A
A1AD B3           |           OR E
A1AE 80           |           ADD A,B
A1AF 53           |           LD D,E
A1B0 45           |           LD B,L
A1B1 54           |           LD D,H
A1B2 20 4E        |           JR NZ,A202h
A1B4 2C           |           INC L
A1B5 28 58        |           JR Z,A20Fh
A1B7 59           |           LD E,C
A1B8 29           |           ADD HL,HL
A1B9 2C           |           INC L
A1BA 52           |           LD D,D
A1BB 00           |           NOP
A1BC FF           |           RST $38
A1BD CB 87        |           RES 0,A
A1BF 3F           |           CCF
A1C0 00           |           NOP
A1C1 00           |           NOP
A1C2 FF           |           RST $38
A1C3 AA           |           XOR D
A1C4 CC BB EE     |           CALL Z,EEBBh
A1C7 DD           |           *ILLEGAL*
A1C8 11 44 88     |           LD DE,8844h
A1CB DD 77 FD     |           LD (IX+FDh),A
A1CE 34           |           INC (HL)
A1CF 12           |           LD (DE),A
A1D0 00           |           NOP
A1D1 C0           |           RET NZ
A1D2 00           |           NOP
A1D3 38 00        |           JR C,A1D5h
A1D5 00           |           NOP
A1D6 00           |           NOP
A1D7 00           |           NOP
A1D8 00           |           NOP
A1D9 00           |           NOP
A1DA 00           |           NOP
A1DB 00           |           NOP
A1DC 00           |           NOP
A1DD 00           |           NOP
A1DE 00           |           NOP
A1DF 00           |           NOP
A1E0 00           |           NOP
A1E1 00           |           NOP
A1E2 00           |           NOP
A1E3 00           |           NOP
A1E4 00           |           NOP
A1E5 00           |           NOP
A1E6 00           |           NOP
A1E7 00           |           NOP
A1E8 00           |           NOP
A1E9 00           |           NOP
A1EA 00           |           NOP
A1EB 00           |           NOP
A1EC FF           |           RST $38
A1ED FF           |           RST $38
A1EE 00           |           NOP
A1EF 00           |           NOP
A1F0 00           |           NOP
A1F1 00           |           NOP
A1F2 00           |           NOP
A1F3 00           |           NOP
A1F4 00           |           NOP
A1F5 00           |           NOP
A1F6 00           |           NOP
A1F7 00           |           NOP
A1F8 00           |           NOP
A1F9 00           |           NOP
A1FA 00           |           NOP
A1FB 00           |           NOP
A1FC 76           |           HALT
A1FD 75           |           LD (HL),L
A1FE BF           |           CP A
A1FF CF           |           RST $08
A200 52           |           LD D,D
A201 45           |           LD B,L
A202 53           |           LD D,E
A203 20 4E        |           JR NZ,A253h
A205 2C           |           INC L
A206 41           |           LD B,C
A207 00           |           NOP
A208 FF           |           RST $38
A209 CB 86        |           RES 0,(HL)
A20B 3F           |           CCF
A20C 00           |           NOP
A20D 00           |           NOP
A20E FF           |           RST $38
A20F AA           |           XOR D
A210 CC BB EE     |           CALL Z,EEBBh
A213 DD           |           *ILLEGAL*
A214 0C           |           INC C
A215 88           |           ADC A,B
A216 88           |           ADC A,B
A217 DD 77 FD     |           LD (IX+FDh),A
A21A 34           |           INC (HL)
A21B 12           |           LD (DE),A
A21C 00           |           NOP
A21D C0           |           RET NZ
A21E 00           |           NOP
A21F 38 00        |           JR C,A221h
A221 00           |           NOP
A222 00           |           NOP
A223 00           |           NOP
A224 00           |           NOP
A225 00           |           NOP
A226 00           |           NOP
A227 00           |           NOP
A228 00           |           NOP
A229 00           |           NOP
A22A 00           |           NOP
A22B 00           |           NOP
A22C 00           |           NOP
A22D 00           |           NOP
A22E 00           |           NOP
A22F 00           |           NOP
A230 00           |           NOP
A231 00           |           NOP
A232 00           |           NOP
A233 00           |           NOP
A234 00           |           NOP
A235 00           |           NOP
A236 00           |           NOP
A237 00           |           NOP
A238 FF           |           RST $38
A239 28 00        |           JR Z,A23Bh
A23B 00           |           NOP
A23C 00           |           NOP
A23D 00           |           NOP
A23E 01 00 00     |           LD BC,0000h
A241 00           |           NOP
A242 00           |           NOP
A243 00           |           NOP
A244 FF           |           RST $38
A245 00           |           NOP
A246 00           |           NOP
A247 00           |           NOP
A248 A2           |           AND D
A249 0C           |           INC C
A24A 0C           |           INC C
A24B AF           |           XOR A
A24C 52           |           LD D,D
A24D 45           |           LD B,L
A24E 53           |           LD D,E
A24F 20 4E        |           JR NZ,A29Fh
A251 2C           |           INC L
A252 28 48        |           JR Z,A29Ch
A254 4C           |           LD C,H
A255 29           |           ADD HL,HL
A256 00           |           NOP
A257 FF           |           RST $38
A258 CB 80        |           RES 0,B
A25A 3F           |           CCF
A25B 00           |           NOP
A25C 00           |           NOP
A25D FF           |           RST $38
A25E AA           |           XOR D
A25F CC BB EE     |           CALL Z,EEBBh
A262 DD           |           *ILLEGAL*
A263 0C           |           INC C
A264 88           |           ADC A,B
A265 88           |           ADC A,B
A266 DD 77 FD     |           LD (IX+FDh),A
A269 34           |           INC (HL)
A26A 12           |           LD (DE),A
A26B 00           |           NOP
A26C C0           |           RET NZ
A26D 00           |           NOP
A26E 3F           |           CCF
A26F 00           |           NOP
A270 00           |           NOP
A271 00           |           NOP
A272 00           |           NOP
A273 00           |           NOP
A274 00           |           NOP
A275 00           |           NOP
A276 00           |           NOP
A277 00           |           NOP
A278 00           |           NOP
A279 00           |           NOP
A27A 00           |           NOP
A27B 00           |           NOP
A27C 00           |           NOP
A27D 00           |           NOP
A27E 00           |           NOP
A27F 00           |           NOP
A280 00           |           NOP
A281 00           |           NOP
A282 00           |           NOP
A283 00           |           NOP
A284 00           |           NOP
A285 00           |           NOP
A286 00           |           NOP
A287 FF           |           RST $38
A288 28 FF        |           JR Z,A289h
A28A FF           |           RST $38
A28B FF           |           RST $38
A28C FF           |           RST $38
A28D 00           |           NOP
A28E 00           |           NOP
A28F 00           |           NOP
A290 00           |           NOP
A291 00           |           NOP
A292 00           |           NOP
A293 00           |           NOP
A294 00           |           NOP
A295 00           |           NOP
A296 00           |           NOP
A297 86           |           ADD A,(HL)
A298 08           |           EX AF,AF'
A299 0F           |           RRCA
A29A A1           |           AND C
A29B 52           |           LD D,D
A29C 45           |           LD B,L
A29D 53           |           LD D,E
A29E 20 4E        |           JR NZ,A2EEh
A2A0 2C           |           INC L
A2A1 5B           |           LD E,E
A2A2 52           |           LD D,D
A2A3 2C           |           INC L
A2A4 28 48        |           JR Z,A2EEh
A2A6 4C           |           LD C,H
A2A7 29           |           ADD HL,HL
A2A8 5D           |           LD E,L
A2A9 00           |           NOP
A2AA FF           |           RST $38
A2AB DD CB 00 86  |           RES 0,(IX+{byte:02X}h)
A2AF 3F           |           CCF
A2B0 FF           |           RST $38
A2B1 AA           |           XOR D
A2B2 CC BB EE     |           CALL Z,EEBBh
A2B5 DD           |           *ILLEGAL*
A2B6 11 44 0C     |           LD DE,0C44h
A2B9 88           |           ADC A,B
A2BA 0C           |           INC C
A2BB 88           |           ADC A,B
A2BC 34           |           INC (HL)
A2BD 12           |           LD (DE),A
A2BE 00           |           NOP
A2BF C0           |           RET NZ
A2C0 20 00        |           JR NZ,A2C2h
A2C2 00           |           NOP
A2C3 38 00        |           JR C,A2C5h
A2C5 00           |           NOP
A2C6 00           |           NOP
A2C7 00           |           NOP
A2C8 00           |           NOP
A2C9 00           |           NOP
A2CA 00           |           NOP
A2CB 00           |           NOP
A2CC 00           |           NOP
A2CD 00           |           NOP
A2CE 00           |           NOP
A2CF 00           |           NOP
A2D0 00           |           NOP
A2D1 00           |           NOP
A2D2 00           |           NOP
A2D3 00           |           NOP
A2D4 00           |           NOP
A2D5 00           |           NOP
A2D6 00           |           NOP
A2D7 01 00 00     |           LD BC,0000h
A2DA FF           |           RST $38
A2DB 28 00        |           JR Z,A2DDh
A2DD 00           |           NOP
A2DE 00           |           NOP
A2DF 00           |           NOP
A2E0 00           |           NOP
A2E1 00           |           NOP
A2E2 01 00 01     |           LD BC,0100h
A2E5 00           |           NOP
A2E6 FF           |           RST $38
A2E7 00           |           NOP
A2E8 00           |           NOP
A2E9 00           |           NOP
A2EA C9           |           RET
A2EB 0F           |           RRCA
A2EC AD           |           XOR L
A2ED AD           |           XOR L
A2EE 52           |           LD D,D
A2EF 45           |           LD B,L
A2F0 53           |           LD D,E
A2F1 20 4E        |           JR NZ,A341h
A2F3 2C           |           INC L
A2F4 28 58        |           JR Z,A34Eh
A2F6 59           |           LD E,C
A2F7 29           |           ADD HL,HL
A2F8 00           |           NOP
A2F9 FF           |           RST $38
A2FA DD CB 00 80  |           RES 0,(IX+{byte:02X}h)
A2FE 3F           |           CCF
A2FF FF           |           RST $38
A300 AA           |           XOR D
A301 CC BB EE     |           CALL Z,EEBBh
A304 DD           |           *ILLEGAL*
A305 11 44 0C     |           LD DE,0C44h
A308 88           |           ADC A,B
A309 0C           |           INC C
A30A 88           |           ADC A,B
A30B 34           |           INC (HL)
A30C 12           |           LD (DE),A
A30D 00           |           NOP
A30E C0           |           RET NZ
A30F 20 00        |           JR NZ,A311h
A311 00           |           NOP
A312 3F           |           CCF
A313 00           |           NOP
A314 00           |           NOP
A315 00           |           NOP
A316 00           |           NOP
A317 00           |           NOP
A318 00           |           NOP
A319 00           |           NOP
A31A 00           |           NOP
A31B 00           |           NOP
A31C 00           |           NOP
A31D 00           |           NOP
A31E 00           |           NOP
A31F 00           |           NOP
A320 00           |           NOP
A321 00           |           NOP
A322 00           |           NOP
A323 00           |           NOP
A324 00           |           NOP
A325 00           |           NOP
A326 01 00 00     |           LD BC,0000h
A329 FF           |           RST $38
A32A 28 00        |           JR Z,A32Ch
A32C 00           |           NOP
A32D 00           |           NOP
A32E 00           |           NOP
A32F 00           |           NOP
A330 00           |           NOP
A331 01 00 01     |           LD BC,0100h
A334 00           |           NOP
A335 FF           |           RST $38
A336 00           |           NOP
A337 00           |           NOP
A338 00           |           NOP
A339 43           |           LD B,E
A33A 58           |           LD E,B
A33B 8B           |           ADC A,E
A33C 31 52 45     |           LD SP,4552h
A33F 53           |           LD D,E
A340 20 4E        |           JR NZ,A390h
A342 2C           |           INC L
A343 28 58        |           JR Z,A39Dh
A345 59           |           LD E,C
A346 29           |           ADD HL,HL
A347 2C           |           INC L
A348 52           |           LD D,D
A349 00           |           NOP
A34A FF           |           RST $38
A34B ED A0        |           LDI
A34D 3F           |           CCF
A34E 00           |           NOP
A34F 00           |           NOP
A350 FF           |           RST $38
A351 AA           |           XOR D
A352 01 00 0C     |           LD BC,0C00h
A355 88           |           ADC A,B
A356 0C           |           INC C
A357 88           |           ADC A,B
A358 88           |           ADC A,B
A359 DD 77 FD     |           LD (IX+FDh),A
A35C 34           |           INC (HL)
A35D 12           |           LD (DE),A
A35E 00           |           NOP
A35F C0           |           RET NZ
A360 00           |           NOP
A361 00           |           NOP
A362 00           |           NOP
A363 00           |           NOP
A364 00           |           NOP
A365 00           |           NOP
A366 09           |           ADD HL,BC
A367 00           |           NOP
A368 00           |           NOP
A369 01 00 01     |           LD BC,0100h
A36C 00           |           NOP
A36D 00           |           NOP
A36E 00           |           NOP
A36F 00           |           NOP
A370 00           |           NOP
A371 09           |           ADD HL,BC
A372 00           |           NOP
A373 00           |           NOP
A374 00           |           NOP
A375 00           |           NOP
A376 00           |           NOP
A377 00           |           NOP
A378 00           |           NOP
A379 00           |           NOP
A37A FF           |           RST $38
A37B F6 FF        |           OR FFh
A37D FF           |           RST $38
A37E 00           |           NOP
A37F 00           |           NOP
A380 00           |           NOP
A381 00           |           NOP
A382 00           |           NOP
A383 00           |           NOP
A384 00           |           NOP
A385 00           |           NOP
A386 F6 00        |           OR 00h
A388 00           |           NOP
A389 00           |           NOP
A38A 08           |           EX AF,AF'
A38B 2B           |           DEC HL
A38C 12           |           LD (DE),A
A38D 61           |           LD H,C
A38E 4C           |           LD C,H
A38F 44           |           LD B,H
A390 49           |           LD C,C
A391 00           |           NOP
A392 FF           |           RST $38
A393 ED A8        |           LDD
A395 3F           |           CCF
A396 00           |           NOP
A397 00           |           NOP
A398 FF           |           RST $38
A399 AA           |           XOR D
A39A 01 00 0C     |           LD BC,0C00h
A39D 88           |           ADC A,B
A39E 0C           |           INC C
A39F 88           |           ADC A,B
A3A0 88           |           ADC A,B
A3A1 DD 77 FD     |           LD (IX+FDh),A
A3A4 34           |           INC (HL)
A3A5 12           |           LD (DE),A
A3A6 00           |           NOP
A3A7 C0           |           RET NZ
A3A8 00           |           NOP
A3A9 00           |           NOP
A3AA 00           |           NOP
A3AB 00           |           NOP
A3AC 00           |           NOP
A3AD 00           |           NOP
A3AE 09           |           ADD HL,BC
A3AF 00           |           NOP
A3B0 00           |           NOP
A3B1 01 00 01     |           LD BC,0100h
A3B4 00           |           NOP
A3B5 00           |           NOP
A3B6 00           |           NOP
A3B7 00           |           NOP
A3B8 00           |           NOP
A3B9 09           |           ADD HL,BC
A3BA 00           |           NOP
A3BB 00           |           NOP
A3BC 00           |           NOP
A3BD 00           |           NOP
A3BE 00           |           NOP
A3BF 00           |           NOP
A3C0 00           |           NOP
A3C1 00           |           NOP
A3C2 FF           |           RST $38
A3C3 F6 FF        |           OR FFh
A3C5 FF           |           RST $38
A3C6 00           |           NOP
A3C7 00           |           NOP
A3C8 00           |           NOP
A3C9 00           |           NOP
A3CA 00           |           NOP
A3CB 00           |           NOP
A3CC 00           |           NOP
A3CD 00           |           NOP
A3CE F6 00        |           OR 00h
A3D0 00           |           NOP
A3D1 00           |           NOP
A3D2 08           |           EX AF,AF'
A3D3 2B           |           DEC HL
A3D4 12           |           LD (DE),A
A3D5 61           |           LD H,C
A3D6 4C           |           LD C,H
A3D7 44           |           LD B,H
A3D8 44           |           LD B,H
A3D9 00           |           NOP
A3DA FF           |           RST $38
A3DB ED B0        |           LDIR
A3DD 3F           |           CCF
A3DE 00           |           NOP
A3DF 00           |           NOP
A3E0 FF           |           RST $38
A3E1 AA           |           XOR D
A3E2 01 00 0C     |           LD BC,0C00h
A3E5 88           |           ADC A,B
A3E6 0C           |           INC C
A3E7 88           |           ADC A,B
A3E8 88           |           ADC A,B
A3E9 DD 77 FD     |           LD (IX+FDh),A
A3EC 34           |           INC (HL)
A3ED 12           |           LD (DE),A
A3EE 00           |           NOP
A3EF C0           |           RET NZ
A3F0 00           |           NOP
A3F1 00           |           NOP
A3F2 00           |           NOP
A3F3 00           |           NOP
A3F4 00           |           NOP
A3F5 00           |           NOP
A3F6 09           |           ADD HL,BC
A3F7 00           |           NOP
A3F8 00           |           NOP
A3F9 01 00 01     |           LD BC,0100h
A3FC 00           |           NOP
A3FD 00           |           NOP
A3FE 00           |           NOP
A3FF 00           |           NOP
A400 00           |           NOP
A401 09           |           ADD HL,BC
A402 00           |           NOP
A403 00           |           NOP
A404 00           |           NOP
A405 00           |           NOP
A406 00           |           NOP
A407 00           |           NOP
A408 00           |           NOP
A409 00           |           NOP
A40A FF           |           RST $38
A40B F6 02        |           OR 02h
A40D 00           |           NOP
A40E 00           |           NOP
A40F 00           |           NOP
A410 00           |           NOP
A411 00           |           NOP
A412 00           |           NOP
A413 00           |           NOP
A414 00           |           NOP
A415 00           |           NOP
A416 F6 00        |           OR 00h
A418 00           |           NOP
A419 00           |           NOP
A41A E2 5B 3A     |           JP PO,3A5Bh
A41D 0B           |           DEC BC
A41E 4C           |           LD C,H
A41F 44           |           LD B,H
A420 49           |           LD C,C
A421 52           |           LD D,D
A422 00           |           NOP
A423 FF           |           RST $38
A424 ED B8        |           LDDR
A426 3F           |           CCF
A427 00           |           NOP
A428 00           |           NOP
A429 FF           |           RST $38
A42A AA           |           XOR D
A42B 01 00 0D     |           LD BC,0D00h
A42E 88           |           ADC A,B
A42F 0D           |           DEC C
A430 88           |           ADC A,B
A431 88           |           ADC A,B
A432 DD 77 FD     |           LD (IX+FDh),A
A435 34           |           INC (HL)
A436 12           |           LD (DE),A
A437 00           |           NOP
A438 C0           |           RET NZ
A439 00           |           NOP
A43A 00           |           NOP
A43B 00           |           NOP
A43C 00           |           NOP
A43D 00           |           NOP
A43E 00           |           NOP
A43F 09           |           ADD HL,BC
A440 00           |           NOP
A441 00           |           NOP
A442 01 00 01     |           LD BC,0100h
A445 00           |           NOP
A446 00           |           NOP
A447 00           |           NOP
A448 00           |           NOP
A449 00           |           NOP
A44A 00           |           NOP
A44B 09           |           ADD HL,BC
A44C 00           |           NOP
A44D 00           |           NOP
A44E 00           |           NOP
A44F 00           |           NOP
A450 00           |           NOP
A451 00           |           NOP
A452 00           |           NOP
A453 FF           |           RST $38
A454 F6 02        |           OR 02h
A456 00           |           NOP
A457 00           |           NOP
A458 00           |           NOP
A459 00           |           NOP
A45A 00           |           NOP
A45B 00           |           NOP
A45C 00           |           NOP
A45D 00           |           NOP
A45E 00           |           NOP
A45F 00           |           NOP
A460 F6 00        |           OR 00h
A462 00           |           NOP
A463 E2 5B 3A     |           JP PO,3A5Bh
A466 0B           |           DEC BC
A467 4C           |           LD C,H
A468 44           |           LD B,H
A469 44           |           LD B,H
A46A 52           |           LD D,D
A46B 00           |           NOP
A46C FF           |           RST $38
A46D ED B0        |           LDIR
A46F 3F           |           CCF
A470 00           |           NOP
A471 00           |           NOP
A472 FF           |           RST $38
A473 AA           |           XOR D
A474 00           |           NOP
A475 00           |           NOP
A476 36 83        |           LD (HL),83h
A478 0C           |           INC C
A479 88           |           ADC A,B
A47A 88           |           ADC A,B
A47B DD 77 FD     |           LD (IX+FDh),A
A47E 00           |           NOP
A47F 00           |           NOP
A480 00           |           NOP
A481 C0           |           RET NZ
A482 00           |           NOP
A483 00           |           NOP
A484 00           |           NOP
A485 00           |           NOP
A486 00           |           NOP
A487 00           |           NOP
A488 09           |           ADD HL,BC
A489 01 00 00     |           LD BC,0000h
A48C 00           |           NOP
A48D 00           |           NOP
A48E 00           |           NOP
A48F 00           |           NOP
A490 00           |           NOP
A491 00           |           NOP
A492 00           |           NOP
A493 09           |           ADD HL,BC
A494 00           |           NOP
A495 00           |           NOP
A496 00           |           NOP
A497 00           |           NOP
A498 00           |           NOP
A499 00           |           NOP
A49A 00           |           NOP
A49B 00           |           NOP
A49C FF           |           RST $38
A49D F6 FE        |           OR FEh
A49F FF           |           RST $38
A4A0 00           |           NOP
A4A1 00           |           NOP
A4A2 00           |           NOP
A4A3 00           |           NOP
A4A4 00           |           NOP
A4A5 00           |           NOP
A4A6 00           |           NOP
A4A7 00           |           NOP
A4A8 00           |           NOP
A4A9 00           |           NOP
A4AA 00           |           NOP
A4AB 00           |           NOP
A4AC 75           |           LD (HL),L
A4AD 88           |           ADC A,B
A4AE 64           |           LD H,H
A4AF 49           |           LD C,C
A4B0 4C           |           LD C,H
A4B1 44           |           LD B,H
A4B2 49           |           LD C,C
A4B3 52           |           LD D,D
A4B4 2D           |           DEC L
A4B5 3E 4E        |           LD A,4Eh
A4B7 4F           |           LD C,A
A4B8 50           |           LD D,B
A4B9 27           |           DAA
A4BA 00           |           NOP
A4BB FF           |           RST $38
A4BC ED B8        |           LDDR
A4BE 3F           |           CCF
A4BF 00           |           NOP
A4C0 00           |           NOP
A4C1 FF           |           RST $38
A4C2 AA           |           XOR D
A4C3 00           |           NOP
A4C4 00           |           NOP
A4C5 36 83        |           LD (HL),83h
A4C7 0C           |           INC C
A4C8 88           |           ADC A,B
A4C9 88           |           ADC A,B
A4CA DD 77 FD     |           LD (IX+FDh),A
A4CD 00           |           NOP
A4CE 00           |           NOP
A4CF 00           |           NOP
A4D0 C0           |           RET NZ
A4D1 00           |           NOP
A4D2 00           |           NOP
A4D3 00           |           NOP
A4D4 00           |           NOP
A4D5 00           |           NOP
A4D6 00           |           NOP
A4D7 09           |           ADD HL,BC
A4D8 01 00 00     |           LD BC,0000h
A4DB 00           |           NOP
A4DC 00           |           NOP
A4DD 00           |           NOP
A4DE 00           |           NOP
A4DF 00           |           NOP
A4E0 00           |           NOP
A4E1 00           |           NOP
A4E2 09           |           ADD HL,BC
A4E3 00           |           NOP
A4E4 00           |           NOP
A4E5 00           |           NOP
A4E6 00           |           NOP
A4E7 00           |           NOP
A4E8 00           |           NOP
A4E9 00           |           NOP
A4EA 00           |           NOP
A4EB FF           |           RST $38
A4EC F6 FE        |           OR FEh
A4EE FF           |           RST $38
A4EF 00           |           NOP
A4F0 00           |           NOP
A4F1 00           |           NOP
A4F2 00           |           NOP
A4F3 00           |           NOP
A4F4 00           |           NOP
A4F5 00           |           NOP
A4F6 00           |           NOP
A4F7 00           |           NOP
A4F8 00           |           NOP
A4F9 00           |           NOP
A4FA 00           |           NOP
A4FB 75           |           LD (HL),L
A4FC 88           |           ADC A,B
A4FD 64           |           LD H,H
A4FE 49           |           LD C,C
A4FF 4C           |           LD C,H
A500 44           |           LD B,H
A501 44           |           LD B,H
A502 52           |           LD D,D
A503 2D           |           DEC L
A504 3E 4E        |           LD A,4Eh
A506 4F           |           LD C,A
A507 50           |           LD D,B
A508 27           |           DAA
A509 00           |           NOP
A50A FF           |           RST $38
A50B ED A1        |           CPI
A50D 3F           |           CCF
A50E 00           |           NOP
A50F 00           |           NOP
A510 FF           |           RST $38
A511 00           |           NOP
A512 01 00 EE     |           LD BC,EE00h
A515 DD           |           *ILLEGAL*
A516 0C           |           INC C
A517 88           |           ADC A,B
A518 88           |           ADC A,B
A519 DD 77 FD     |           LD (IX+FDh),A
A51C 00           |           NOP
A51D 00           |           NOP
A51E 00           |           NOP
A51F C0           |           RET NZ
A520 00           |           NOP
A521 00           |           NOP
A522 00           |           NOP
A523 00           |           NOP
A524 00           |           NOP
A525 00           |           NOP
A526 89           |           ADC A,C
A527 00           |           NOP
A528 00           |           NOP
A529 00           |           NOP
A52A 00           |           NOP
A52B 01 00 00     |           LD BC,0000h
A52E 00           |           NOP
A52F 00           |           NOP
A530 00           |           NOP
A531 89           |           ADC A,C
A532 00           |           NOP
A533 00           |           NOP
A534 00           |           NOP
A535 00           |           NOP
A536 00           |           NOP
A537 00           |           NOP
A538 00           |           NOP
A539 00           |           NOP
A53A FF           |           RST $38
A53B 76           |           HALT
A53C FF           |           RST $38
A53D FF           |           RST $38
A53E 00           |           NOP
A53F 00           |           NOP
A540 00           |           NOP
A541 00           |           NOP
A542 00           |           NOP
A543 00           |           NOP
A544 00           |           NOP
A545 00           |           NOP
A546 76           |           HALT
A547 00           |           NOP
A548 00           |           NOP
A549 00           |           NOP
A54A 43           |           LD B,E
A54B 5C           |           LD E,H
A54C 42           |           LD B,D
A54D 3D           |           DEC A
A54E 43           |           LD B,E
A54F 50           |           LD D,B
A550 49           |           LD C,C
A551 00           |           NOP
A552 FF           |           RST $38
A553 ED A9        |           CPD
A555 3F           |           CCF
A556 00           |           NOP
A557 00           |           NOP
A558 FF           |           RST $38
A559 00           |           NOP
A55A 01 00 EE     |           LD BC,EE00h
A55D DD           |           *ILLEGAL*
A55E 0C           |           INC C
A55F 88           |           ADC A,B
A560 88           |           ADC A,B
A561 DD 77 FD     |           LD (IX+FDh),A
A564 00           |           NOP
A565 00           |           NOP
A566 00           |           NOP
A567 C0           |           RET NZ
A568 00           |           NOP
A569 00           |           NOP
A56A 00           |           NOP
A56B 00           |           NOP
A56C 00           |           NOP
A56D 00           |           NOP
A56E 89           |           ADC A,C
A56F 00           |           NOP
A570 00           |           NOP
A571 00           |           NOP
A572 00           |           NOP
A573 01 00 00     |           LD BC,0000h
A576 00           |           NOP
A577 00           |           NOP
A578 00           |           NOP
A579 89           |           ADC A,C
A57A 00           |           NOP
A57B 00           |           NOP
A57C 00           |           NOP
A57D 00           |           NOP
A57E 00           |           NOP
A57F 00           |           NOP
A580 00           |           NOP
A581 00           |           NOP
A582 FF           |           RST $38
A583 76           |           HALT
A584 FF           |           RST $38
A585 FF           |           RST $38
A586 00           |           NOP
A587 00           |           NOP
A588 00           |           NOP
A589 00           |           NOP
A58A 00           |           NOP
A58B 00           |           NOP
A58C 00           |           NOP
A58D 00           |           NOP
A58E 76           |           HALT
A58F 00           |           NOP
A590 00           |           NOP
A591 00           |           NOP
A592 43           |           LD B,E
A593 5C           |           LD E,H
A594 42           |           LD B,D
A595 3D           |           DEC A
A596 43           |           LD B,E
A597 50           |           LD D,B
A598 44           |           LD B,H
A599 00           |           NOP
A59A FF           |           RST $38
A59B ED B1        |           CPIR
A59D 3F           |           CCF
A59E 00           |           NOP
A59F 00           |           NOP
A5A0 FF           |           RST $38
A5A1 00           |           NOP
A5A2 01 00 EE     |           LD BC,EE00h
A5A5 DD           |           *ILLEGAL*
A5A6 0C           |           INC C
A5A7 88           |           ADC A,B
A5A8 88           |           ADC A,B
A5A9 DD 77 FD     |           LD (IX+FDh),A
A5AC 00           |           NOP
A5AD 00           |           NOP
A5AE 00           |           NOP
A5AF C0           |           RET NZ
A5B0 00           |           NOP
A5B1 00           |           NOP
A5B2 00           |           NOP
A5B3 00           |           NOP
A5B4 00           |           NOP
A5B5 00           |           NOP
A5B6 89           |           ADC A,C
A5B7 00           |           NOP
A5B8 00           |           NOP
A5B9 00           |           NOP
A5BA 00           |           NOP
A5BB 01 00 00     |           LD BC,0000h
A5BE 00           |           NOP
A5BF 00           |           NOP
A5C0 00           |           NOP
A5C1 89           |           ADC A,C
A5C2 00           |           NOP
A5C3 00           |           NOP
A5C4 00           |           NOP
A5C5 00           |           NOP
A5C6 00           |           NOP
A5C7 00           |           NOP
A5C8 00           |           NOP
A5C9 00           |           NOP
A5CA FF           |           RST $38
A5CB 76           |           HALT
A5CC 02           |           LD (BC),A
A5CD 00           |           NOP
A5CE 00           |           NOP
A5CF 00           |           NOP
A5D0 00           |           NOP
A5D1 00           |           NOP
A5D2 00           |           NOP
A5D3 00           |           NOP
A5D4 00           |           NOP
A5D5 00           |           NOP
A5D6 76           |           HALT
A5D7 00           |           NOP
A5D8 00           |           NOP
A5D9 00           |           NOP
A5DA C9           |           RET
A5DB 3A 13 49     |           LD A,(4913h)
A5DE 43           |           LD B,E
A5DF 50           |           LD D,B
A5E0 49           |           LD C,C
A5E1 52           |           LD D,D
A5E2 00           |           NOP
A5E3 FF           |           RST $38
A5E4 ED B9        |           CPDR
A5E6 3F           |           CCF
A5E7 00           |           NOP
A5E8 00           |           NOP
A5E9 FF           |           RST $38
A5EA 00           |           NOP
A5EB 01 00 EE     |           LD BC,EE00h
A5EE DD           |           *ILLEGAL*
A5EF 0C           |           INC C
A5F0 88           |           ADC A,B
A5F1 88           |           ADC A,B
A5F2 DD 77 FD     |           LD (IX+FDh),A
A5F5 00           |           NOP
A5F6 00           |           NOP
A5F7 00           |           NOP
A5F8 C0           |           RET NZ
A5F9 00           |           NOP
A5FA 00           |           NOP
A5FB 00           |           NOP
A5FC 00           |           NOP
A5FD 00           |           NOP
A5FE 00           |           NOP
A5FF 89           |           ADC A,C
A600 00           |           NOP
A601 00           |           NOP
A602 00           |           NOP
A603 00           |           NOP
A604 01 00 00     |           LD BC,0000h
A607 00           |           NOP
A608 00           |           NOP
A609 00           |           NOP
A60A 00           |           NOP
A60B 89           |           ADC A,C
A60C 00           |           NOP
A60D 00           |           NOP
A60E 00           |           NOP
A60F 00           |           NOP
A610 00           |           NOP
A611 00           |           NOP
A612 00           |           NOP
A613 FF           |           RST $38
A614 76           |           HALT
A615 02           |           LD (BC),A
A616 00           |           NOP
A617 00           |           NOP
A618 00           |           NOP
A619 00           |           NOP
A61A 00           |           NOP
A61B 00           |           NOP
A61C 00           |           NOP
A61D 00           |           NOP
A61E 00           |           NOP
A61F 00           |           NOP
A620 76           |           HALT
A621 00           |           NOP
A622 00           |           NOP
A623 AE           |           XOR (HL)
A624 A4           |           AND H
A625 D4 55 43     |           CALL NC,4355h
A628 50           |           LD D,B
A629 44           |           LD B,H
A62A 52           |           LD D,D
A62B 00           |           NOP
A62C FF           |           RST $38
A62D DB FE        |           IN A,(FEh)
A62F 3F           |           CCF
A630 00           |           NOP
A631 00           |           NOP
A632 FF           |           RST $38
A633 AA           |           XOR D
A634 CC BB EE     |           CALL Z,EEBBh
A637 DD           |           *ILLEGAL*
A638 11 44 88     |           LD DE,8844h
A63B DD 77 FD     |           LD (IX+FDh),A
A63E 34           |           INC (HL)
A63F 12           |           LD (DE),A
A640 00           |           NOP
A641 C0           |           RET NZ
A642 00           |           NOP
A643 00           |           NOP
A644 00           |           NOP
A645 00           |           NOP
A646 00           |           NOP
A647 00           |           NOP
A648 00           |           NOP
A649 00           |           NOP
A64A 00           |           NOP
A64B 00           |           NOP
A64C 00           |           NOP
A64D 00           |           NOP
A64E 00           |           NOP
A64F 00           |           NOP
A650 00           |           NOP
A651 00           |           NOP
A652 00           |           NOP
A653 00           |           NOP
A654 00           |           NOP
A655 00           |           NOP
A656 00           |           NOP
A657 00           |           NOP
A658 00           |           NOP
A659 00           |           NOP
A65A 00           |           NOP
A65B 00           |           NOP
A65C FF           |           RST $38
A65D 28 00        |           JR Z,A65Fh
A65F 00           |           NOP
A660 00           |           NOP
A661 00           |           NOP
A662 00           |           NOP
A663 00           |           NOP
A664 00           |           NOP
A665 00           |           NOP
A666 00           |           NOP
A667 00           |           NOP
A668 00           |           NOP
A669 00           |           NOP
A66A 00           |           NOP
A66B 00           |           NOP
A66C C3 F6 46     |           JP 46F6h
A66F 0B           |           DEC BC
A670 49           |           LD C,C
A671 4E           |           LD C,(HL)
A672 20 41        |           JR NZ,A6B5h
A674 2C           |           INC L
A675 28 4E        |           JR Z,A6C5h
A677 29           |           ADD HL,HL
A678 00           |           NOP
A679 01 FF ED     |           LD BC,EDFFh
A67C 40           |           LD B,B
A67D 3F           |           CCF
A67E 00           |           NOP
A67F 00           |           NOP
A680 FF           |           RST $38
A681 AA           |           XOR D
A682 FE BB        |           CP BBh
A684 EE DD        |           XOR DDh
A686 11 44 88     |           LD DE,8844h
A689 DD 77 FD     |           LD (IX+FDh),A
A68C 34           |           INC (HL)
A68D 12           |           LD (DE),A
A68E 00           |           NOP
A68F C0           |           RET NZ
A690 00           |           NOP
A691 38 00        |           JR C,A693h
A693 00           |           NOP
A694 00           |           NOP
A695 00           |           NOP
A696 00           |           NOP
A697 00           |           NOP
A698 00           |           NOP
A699 00           |           NOP
A69A 00           |           NOP
A69B 00           |           NOP
A69C 00           |           NOP
A69D 00           |           NOP
A69E 00           |           NOP
A69F 00           |           NOP
A6A0 00           |           NOP
A6A1 00           |           NOP
A6A2 00           |           NOP
A6A3 00           |           NOP
A6A4 00           |           NOP
A6A5 00           |           NOP
A6A6 00           |           NOP
A6A7 00           |           NOP
A6A8 00           |           NOP
A6A9 00           |           NOP
A6AA FF           |           RST $38
A6AB 28 00        |           JR Z,A6ADh
A6AD 00           |           NOP
A6AE 00           |           NOP
A6AF 00           |           NOP
A6B0 00           |           NOP
A6B1 00           |           NOP
A6B2 00           |           NOP
A6B3 00           |           NOP
A6B4 00           |           NOP
A6B5 00           |           NOP
A6B6 00           |           NOP
A6B7 00           |           NOP
A6B8 00           |           NOP
A6B9 00           |           NOP
A6BA 48           |           LD C,B
A6BB 01 A6 33     |           LD BC,33A6h
A6BE 49           |           LD C,C
A6BF 4E           |           LD C,(HL)
A6C0 20 52        |           JR NZ,A714h
A6C2 2C           |           INC L
A6C3 28 43        |           JR Z,A708h
A6C5 29           |           ADD HL,HL
A6C6 00           |           NOP
A6C7 01 FF ED     |           LD BC,EDFFh
A6CA 70           |           LD (HL),B
A6CB 3F           |           CCF
A6CC 00           |           NOP
A6CD 00           |           NOP
A6CE FF           |           RST $38
A6CF AA           |           XOR D
A6D0 FE BB        |           CP BBh
A6D2 EE DD        |           XOR DDh
A6D4 11 44 88     |           LD DE,8844h
A6D7 DD 77 FD     |           LD (IX+FDh),A
A6DA 34           |           INC (HL)
A6DB 12           |           LD (DE),A
A6DC 00           |           NOP
A6DD C0           |           RET NZ
A6DE 00           |           NOP
A6DF 00           |           NOP
A6E0 00           |           NOP
A6E1 00           |           NOP
A6E2 00           |           NOP
A6E3 00           |           NOP
A6E4 00           |           NOP
A6E5 00           |           NOP
A6E6 00           |           NOP
A6E7 00           |           NOP
A6E8 00           |           NOP
A6E9 00           |           NOP
A6EA 00           |           NOP
A6EB 00           |           NOP
A6EC 00           |           NOP
A6ED 00           |           NOP
A6EE 00           |           NOP
A6EF 00           |           NOP
A6F0 00           |           NOP
A6F1 00           |           NOP
A6F2 00           |           NOP
A6F3 00           |           NOP
A6F4 00           |           NOP
A6F5 00           |           NOP
A6F6 00           |           NOP
A6F7 00           |           NOP
A6F8 FF           |           RST $38
A6F9 28 00        |           JR Z,A6FBh
A6FB 00           |           NOP
A6FC 00           |           NOP
A6FD 00           |           NOP
A6FE 00           |           NOP
A6FF 00           |           NOP
A700 00           |           NOP
A701 00           |           NOP
A702 00           |           NOP
A703 00           |           NOP
A704 00           |           NOP
A705 00           |           NOP
A706 00           |           NOP
A707 00           |           NOP
A708 1E FC        |           LD E,FCh
A70A F0           |           RET P
A70B 40           |           LD B,B
A70C 49           |           LD C,C
A70D 4E           |           LD C,(HL)
A70E 20 28        |           JR NZ,A738h
A710 43           |           LD B,E
A711 29           |           ADD HL,HL
A712 00           |           NOP
A713 01 FF ED     |           LD BC,EDFFh
A716 A2           |           AND D
A717 3F           |           CCF
A718 00           |           NOP
A719 00           |           NOP
A71A FF           |           RST $38
A71B AA           |           XOR D
A71C FE 00        |           CP 00h
A71E EE DD        |           XOR DDh
A720 0C           |           INC C
A721 88           |           ADC A,B
A722 88           |           ADC A,B
A723 DD 77 FD     |           LD (IX+FDh),A
A726 34           |           INC (HL)
A727 12           |           LD (DE),A
A728 00           |           NOP
A729 C0           |           RET NZ
A72A 00           |           NOP
A72B 00           |           NOP
A72C 00           |           NOP
A72D 00           |           NOP
A72E 00           |           NOP
A72F 00           |           NOP
A730 00           |           NOP
A731 00           |           NOP
A732 FF           |           RST $38
A733 00           |           NOP
A734 00           |           NOP
A735 00           |           NOP
A736 00           |           NOP
A737 00           |           NOP
A738 00           |           NOP
A739 00           |           NOP
A73A 00           |           NOP
A73B 00           |           NOP
A73C 00           |           NOP
A73D 00           |           NOP
A73E 00           |           NOP
A73F 00           |           NOP
A740 00           |           NOP
A741 00           |           NOP
A742 00           |           NOP
A743 00           |           NOP
A744 FF           |           RST $38
A745 28 00        |           JR Z,A747h
A747 00           |           NOP
A748 00           |           NOP
A749 00           |           NOP
A74A 01 00 00     |           LD BC,0000h
A74D 00           |           NOP
A74E 00           |           NOP
A74F 00           |           NOP
A750 00           |           NOP
A751 00           |           NOP
A752 00           |           NOP
A753 00           |           NOP
A754 3C           |           INC A
A755 48           |           LD C,B
A756 0A           |           LD A,(BC)
A757 E3           |           EX (SP),HL
A758 49           |           LD C,C
A759 4E           |           LD C,(HL)
A75A 49           |           LD C,C
A75B 00           |           NOP
A75C 01 FF ED     |           LD BC,EDFFh
A75F AA           |           XOR D
A760 3F           |           CCF
A761 00           |           NOP
A762 00           |           NOP
A763 FF           |           RST $38
A764 AA           |           XOR D
A765 FE 00        |           CP 00h
A767 EE DD        |           XOR DDh
A769 0C           |           INC C
A76A 88           |           ADC A,B
A76B 88           |           ADC A,B
A76C DD 77 FD     |           LD (IX+FDh),A
A76F 34           |           INC (HL)
A770 12           |           LD (DE),A
A771 00           |           NOP
A772 C0           |           RET NZ
A773 00           |           NOP
A774 00           |           NOP
A775 00           |           NOP
A776 00           |           NOP
A777 00           |           NOP
A778 00           |           NOP
A779 00           |           NOP
A77A 00           |           NOP
A77B FF           |           RST $38
A77C 00           |           NOP
A77D 00           |           NOP
A77E 00           |           NOP
A77F 00           |           NOP
A780 00           |           NOP
A781 00           |           NOP
A782 00           |           NOP
A783 00           |           NOP
A784 00           |           NOP
A785 00           |           NOP
A786 00           |           NOP
A787 00           |           NOP
A788 00           |           NOP
A789 00           |           NOP
A78A 00           |           NOP
A78B 00           |           NOP
A78C 00           |           NOP
A78D FF           |           RST $38
A78E 28 00        |           JR Z,A790h
A790 00           |           NOP
A791 00           |           NOP
A792 00           |           NOP
A793 01 00 00     |           LD BC,0000h
A796 00           |           NOP
A797 00           |           NOP
A798 00           |           NOP
A799 00           |           NOP
A79A 00           |           NOP
A79B 00           |           NOP
A79C 00           |           NOP
A79D C9           |           RET
A79E 08           |           EX AF,AF'
A79F 49           |           LD C,C
A7A0 AB           |           XOR E
A7A1 49           |           LD C,C
A7A2 4E           |           LD C,(HL)
A7A3 44           |           LD B,H
A7A4 00           |           NOP
A7A5 01 FF ED     |           LD BC,EDFFh
A7A8 B2           |           OR D
A7A9 3F           |           CCF
A7AA 00           |           NOP
A7AB 00           |           NOP
A7AC FF           |           RST $38
A7AD AA           |           XOR D
A7AE FE 01        |           CP 01h
A7B0 EE DD        |           XOR DDh
A7B2 0C           |           INC C
A7B3 88           |           ADC A,B
A7B4 88           |           ADC A,B
A7B5 DD 77 FD     |           LD (IX+FDh),A
A7B8 34           |           INC (HL)
A7B9 12           |           LD (DE),A
A7BA 00           |           NOP
A7BB C0           |           RET NZ
A7BC 00           |           NOP
A7BD 00           |           NOP
A7BE 00           |           NOP
A7BF 00           |           NOP
A7C0 00           |           NOP
A7C1 00           |           NOP
A7C2 00           |           NOP
A7C3 00           |           NOP
A7C4 00           |           NOP
A7C5 00           |           NOP
A7C6 00           |           NOP
A7C7 00           |           NOP
A7C8 00           |           NOP
A7C9 00           |           NOP
A7CA 00           |           NOP
A7CB 00           |           NOP
A7CC 00           |           NOP
A7CD 00           |           NOP
A7CE 00           |           NOP
A7CF 00           |           NOP
A7D0 00           |           NOP
A7D1 00           |           NOP
A7D2 00           |           NOP
A7D3 00           |           NOP
A7D4 00           |           NOP
A7D5 00           |           NOP
A7D6 FF           |           RST $38
A7D7 28 00        |           JR Z,A7D9h
A7D9 02           |           LD (BC),A
A7DA 00           |           NOP
A7DB 00           |           NOP
A7DC 01 00 00     |           LD BC,0000h
A7DF 00           |           NOP
A7E0 00           |           NOP
A7E1 00           |           NOP
A7E2 00           |           NOP
A7E3 00           |           NOP
A7E4 00           |           NOP
A7E5 00           |           NOP
A7E6 34           |           INC (HL)
A7E7 68           |           LD L,B
A7E8 30 92        |           JR NC,A77Ch
A7EA 49           |           LD C,C
A7EB 4E           |           LD C,(HL)
A7EC 49           |           LD C,C
A7ED 52           |           LD D,D
A7EE 00           |           NOP
A7EF 01 FF ED     |           LD BC,EDFFh
A7F2 BA           |           CP D
A7F3 3F           |           CCF
A7F4 00           |           NOP
A7F5 00           |           NOP
A7F6 FF           |           RST $38
A7F7 AA           |           XOR D
A7F8 FE 01        |           CP 01h
A7FA EE DD        |           XOR DDh
A7FC 0D           |           DEC C
A7FD 88           |           ADC A,B
A7FE 88           |           ADC A,B
A7FF DD 77 FD     |           LD (IX+FDh),A
A802 34           |           INC (HL)
A803 12           |           LD (DE),A
A804 00           |           NOP
A805 C0           |           RET NZ
A806 00           |           NOP
A807 00           |           NOP
A808 00           |           NOP
A809 00           |           NOP
A80A 00           |           NOP
A80B 00           |           NOP
A80C 00           |           NOP
A80D 00           |           NOP
A80E 00           |           NOP
A80F 00           |           NOP
A810 00           |           NOP
A811 00           |           NOP
A812 00           |           NOP
A813 00           |           NOP
A814 00           |           NOP
A815 00           |           NOP
A816 00           |           NOP
A817 00           |           NOP
A818 00           |           NOP
A819 00           |           NOP
A81A 00           |           NOP
A81B 00           |           NOP
A81C 00           |           NOP
A81D 00           |           NOP
A81E 00           |           NOP
A81F 00           |           NOP
A820 FF           |           RST $38
A821 28 00        |           JR Z,A823h
A823 02           |           LD (BC),A
A824 00           |           NOP
A825 00           |           NOP
A826 01 00 00     |           LD BC,0000h
A829 00           |           NOP
A82A 00           |           NOP
A82B 00           |           NOP
A82C 00           |           NOP
A82D 00           |           NOP
A82E 00           |           NOP
A82F 00           |           NOP
A830 E6 77        |           AND 77h
A832 13           |           INC DE
A833 26 49        |           LD H,49h
A835 4E           |           LD C,(HL)
A836 44           |           LD B,H
A837 52           |           LD D,D
A838 00           |           NOP
A839 01 FF ED     |           LD BC,EDFFh
A83C B2           |           OR D
A83D 3F           |           CCF
A83E 00           |           NOP
A83F 00           |           NOP
A840 FF           |           RST $38
A841 AA           |           XOR D
A842 FE 00        |           CP 00h
A844 EE DD        |           XOR DDh
A846 36 83        |           LD (HL),83h
A848 88           |           ADC A,B
A849 DD 77 FD     |           LD (IX+FDh),A
A84C 00           |           NOP
A84D 00           |           NOP
A84E 00           |           NOP
A84F C0           |           RET NZ
A850 00           |           NOP
A851 00           |           NOP
A852 00           |           NOP
A853 00           |           NOP
A854 00           |           NOP
A855 38 00        |           JR C,A857h
A857 00           |           NOP
A858 01 00 00     |           LD BC,0000h
A85B 00           |           NOP
A85C 00           |           NOP
A85D 00           |           NOP
A85E 00           |           NOP
A85F 00           |           NOP
A860 00           |           NOP
A861 00           |           NOP
A862 00           |           NOP
A863 00           |           NOP
A864 00           |           NOP
A865 00           |           NOP
A866 00           |           NOP
A867 00           |           NOP
A868 00           |           NOP
A869 00           |           NOP
A86A C7           |           RST $00
A86B 28 00        |           JR Z,A86Dh
A86D FE 00        |           CP 00h
A86F 00           |           NOP
A870 00           |           NOP
A871 00           |           NOP
A872 00           |           NOP
A873 00           |           NOP
A874 00           |           NOP
A875 00           |           NOP
A876 00           |           NOP
A877 00           |           NOP
A878 00           |           NOP
A879 00           |           NOP
A87A EE E4        |           XOR E4h
A87C 9E           |           SBC A,(HL)
A87D 3B           |           DEC SP
A87E 49           |           LD C,C
A87F 4E           |           LD C,(HL)
A880 49           |           LD C,C
A881 52           |           LD D,D
A882 2D           |           DEC L
A883 3E 4E        |           LD A,4Eh
A885 4F           |           LD C,A
A886 50           |           LD D,B
A887 27           |           DAA
A888 00           |           NOP
A889 01 FF ED     |           LD BC,EDFFh
A88C BA           |           CP D
A88D 3F           |           CCF
A88E 00           |           NOP
A88F 00           |           NOP
A890 FF           |           RST $38
A891 AA           |           XOR D
A892 FE 00        |           CP 00h
A894 EE DD        |           XOR DDh
A896 36 83        |           LD (HL),83h
A898 88           |           ADC A,B
A899 DD 77 FD     |           LD (IX+FDh),A
A89C 00           |           NOP
A89D 00           |           NOP
A89E 00           |           NOP
A89F C0           |           RET NZ
A8A0 00           |           NOP
A8A1 00           |           NOP
A8A2 00           |           NOP
A8A3 00           |           NOP
A8A4 00           |           NOP
A8A5 38 00        |           JR C,A8A7h
A8A7 00           |           NOP
A8A8 01 00 00     |           LD BC,0000h
A8AB 00           |           NOP
A8AC 00           |           NOP
A8AD 00           |           NOP
A8AE 00           |           NOP
A8AF 00           |           NOP
A8B0 00           |           NOP
A8B1 00           |           NOP
A8B2 00           |           NOP
A8B3 00           |           NOP
A8B4 00           |           NOP
A8B5 00           |           NOP
A8B6 00           |           NOP
A8B7 00           |           NOP
A8B8 00           |           NOP
A8B9 00           |           NOP
A8BA C7           |           RST $00
A8BB 28 00        |           JR Z,A8BDh
A8BD FE 00        |           CP 00h
A8BF 00           |           NOP
A8C0 00           |           NOP
A8C1 00           |           NOP
A8C2 00           |           NOP
A8C3 00           |           NOP
A8C4 00           |           NOP
A8C5 00           |           NOP
A8C6 00           |           NOP
A8C7 00           |           NOP
A8C8 00           |           NOP
A8C9 00           |           NOP
A8CA D2 DA 9B     |           JP NC,9BDAh
A8CD 2F           |           CPL
A8CE 49           |           LD C,C
A8CF 4E           |           LD C,(HL)
A8D0 44           |           LD B,H
A8D1 52           |           LD D,D
A8D2 2D           |           DEC L
A8D3 3E 4E        |           LD A,4Eh
A8D5 4F           |           LD C,A
A8D6 50           |           LD D,B
A8D7 27           |           DAA
A8D8 00           |           NOP
A8D9 01 FF D3     |           LD BC,D3FFh
A8DC FE 3F        |           CP 3Fh
A8DE 00           |           NOP
A8DF 00           |           NOP
A8E0 FF           |           RST $38
A8E1 AA           |           XOR D
A8E2 CC BB EE     |           CALL Z,EEBBh
A8E5 DD           |           *ILLEGAL*
A8E6 11 44 88     |           LD DE,8844h
A8E9 DD 77 FD     |           LD (IX+FDh),A
A8EC 34           |           INC (HL)
A8ED 12           |           LD (DE),A
A8EE 00           |           NOP
A8EF C0           |           RET NZ
A8F0 00           |           NOP
A8F1 00           |           NOP
A8F2 00           |           NOP
A8F3 00           |           NOP
A8F4 00           |           NOP
A8F5 00           |           NOP
A8F6 FF           |           RST $38
A8F7 00           |           NOP
A8F8 00           |           NOP
A8F9 00           |           NOP
A8FA 00           |           NOP
A8FB 00           |           NOP
A8FC 00           |           NOP
A8FD 00           |           NOP
A8FE 00           |           NOP
A8FF 00           |           NOP
A900 00           |           NOP
A901 00           |           NOP
A902 00           |           NOP
A903 00           |           NOP
A904 00           |           NOP
A905 00           |           NOP
A906 00           |           NOP
A907 00           |           NOP
A908 00           |           NOP
A909 00           |           NOP
A90A FF           |           RST $38
A90B 00           |           NOP
A90C 00           |           NOP
A90D 00           |           NOP
A90E 00           |           NOP
A90F 00           |           NOP
A910 00           |           NOP
A911 00           |           NOP
A912 00           |           NOP
A913 00           |           NOP
A914 00           |           NOP
A915 00           |           NOP
A916 00           |           NOP
A917 00           |           NOP
A918 00           |           NOP
A919 00           |           NOP
A91A 04           |           INC B
A91B 27           |           DAA
A91C 0B           |           DEC BC
A91D 9E           |           SBC A,(HL)
A91E 4F           |           LD C,A
A91F 55           |           LD D,L
A920 54           |           LD D,H
A921 20 28        |           JR NZ,A94Bh
A923 4E           |           LD C,(HL)
A924 29           |           ADD HL,HL
A925 2C           |           INC L
A926 41           |           LD B,C
A927 00           |           NOP
A928 FF           |           RST $38
A929 ED 41        |           OUT (C),B
A92B 3F           |           CCF
A92C 00           |           NOP
A92D 00           |           NOP
A92E FF           |           RST $38
A92F AA           |           XOR D
A930 FE 00        |           CP 00h
A932 EE DD        |           XOR DDh
A934 11 44 88     |           LD DE,8844h
A937 DD 77 FD     |           LD (IX+FDh),A
A93A 34           |           INC (HL)
A93B 12           |           LD (DE),A
A93C 00           |           NOP
A93D C0           |           RET NZ
A93E 00           |           NOP
A93F 38 00        |           JR C,A941h
A941 00           |           NOP
A942 00           |           NOP
A943 00           |           NOP
A944 00           |           NOP
A945 00           |           NOP
A946 00           |           NOP
A947 00           |           NOP
A948 00           |           NOP
A949 00           |           NOP
A94A 00           |           NOP
A94B 00           |           NOP
A94C 00           |           NOP
A94D 00           |           NOP
A94E 00           |           NOP
A94F 00           |           NOP
A950 00           |           NOP
A951 00           |           NOP
A952 00           |           NOP
A953 00           |           NOP
A954 00           |           NOP
A955 00           |           NOP
A956 00           |           NOP
A957 00           |           NOP
A958 FF           |           RST $38
A959 FF           |           RST $38
A95A 00           |           NOP
A95B FF           |           RST $38
A95C FF           |           RST $38
A95D FF           |           RST $38
A95E FF           |           RST $38
A95F FF           |           RST $38
A960 00           |           NOP
A961 00           |           NOP
A962 00           |           NOP
A963 00           |           NOP
A964 00           |           NOP
A965 00           |           NOP
A966 00           |           NOP
A967 00           |           NOP
A968 36 54        |           LD (HL),54h
A96A 7C           |           LD A,H
A96B 3C           |           INC A
A96C 4F           |           LD C,A
A96D 55           |           LD D,L
A96E 54           |           LD D,H
A96F 20 28        |           JR NZ,A999h
A971 43           |           LD B,E
A972 29           |           ADD HL,HL
A973 2C           |           INC L
A974 52           |           LD D,D
A975 00           |           NOP
A976 FF           |           RST $38
A977 ED 71        |           OUT (C),F
A979 3F           |           CCF
A97A 00           |           NOP
A97B 00           |           NOP
A97C FF           |           RST $38
A97D AA           |           XOR D
A97E FE 00        |           CP 00h
A980 EE DD        |           XOR DDh
A982 11 44 88     |           LD DE,8844h
A985 DD 77 FD     |           LD (IX+FDh),A
A988 34           |           INC (HL)
A989 12           |           LD (DE),A
A98A 00           |           NOP
A98B C0           |           RET NZ
A98C 00           |           NOP
A98D 00           |           NOP
A98E 00           |           NOP
A98F 00           |           NOP
A990 00           |           NOP
A991 00           |           NOP
A992 00           |           NOP
A993 00           |           NOP
A994 00           |           NOP
A995 00           |           NOP
A996 00           |           NOP
A997 00           |           NOP
A998 00           |           NOP
A999 00           |           NOP
A99A 00           |           NOP
A99B 00           |           NOP
A99C 00           |           NOP
A99D 00           |           NOP
A99E 00           |           NOP
A99F 00           |           NOP
A9A0 00           |           NOP
A9A1 00           |           NOP
A9A2 00           |           NOP
A9A3 00           |           NOP
A9A4 00           |           NOP
A9A5 00           |           NOP
A9A6 FF           |           RST $38
A9A7 FF           |           RST $38
A9A8 00           |           NOP
A9A9 FF           |           RST $38
A9AA 00           |           NOP
A9AB 00           |           NOP
A9AC 00           |           NOP
A9AD 00           |           NOP
A9AE 00           |           NOP
A9AF 00           |           NOP
A9B0 00           |           NOP
A9B1 00           |           NOP
A9B2 00           |           NOP
A9B3 00           |           NOP
A9B4 00           |           NOP
A9B5 00           |           NOP
A9B6 22 68 55     |           LD (5568h),HL
A9B9 E0           |           RET PO
A9BA 4F           |           LD C,A
A9BB 55           |           LD D,L
A9BC 54           |           LD D,H
A9BD 20 28        |           JR NZ,A9E7h
A9BF 43           |           LD B,E
A9C0 29           |           ADD HL,HL
A9C1 2C           |           INC L
A9C2 30 00        |           JR NC,A9C4h
A9C4 FF           |           RST $38
A9C5 ED A3        |           OTI
A9C7 3F           |           CCF
A9C8 00           |           NOP
A9C9 00           |           NOP
A9CA FF           |           RST $38
A9CB AA           |           XOR D
A9CC FE 00        |           CP 00h
A9CE EE DD        |           XOR DDh
A9D0 0C           |           INC C
A9D1 88           |           ADC A,B
A9D2 88           |           ADC A,B
A9D3 DD 77 FD     |           LD (IX+FDh),A
A9D6 00           |           NOP
A9D7 00           |           NOP
A9D8 00           |           NOP
A9D9 C0           |           RET NZ
A9DA 00           |           NOP
A9DB 00           |           NOP
A9DC 00           |           NOP
A9DD 00           |           NOP
A9DE 00           |           NOP
A9DF 00           |           NOP
A9E0 00           |           NOP
A9E1 00           |           NOP
A9E2 87           |           ADD A,A
A9E3 00           |           NOP
A9E4 00           |           NOP
A9E5 00           |           NOP
A9E6 00           |           NOP
A9E7 00           |           NOP
A9E8 00           |           NOP
A9E9 00           |           NOP
A9EA 00           |           NOP
A9EB 87           |           ADD A,A
A9EC 00           |           NOP
A9ED 00           |           NOP
A9EE 00           |           NOP
A9EF 00           |           NOP
A9F0 00           |           NOP
A9F1 00           |           NOP
A9F2 00           |           NOP
A9F3 00           |           NOP
A9F4 FF           |           RST $38
A9F5 28 00        |           JR Z,A9F7h
A9F7 78           |           LD A,B
A9F8 00           |           NOP
A9F9 00           |           NOP
A9FA 01 00 00     |           LD BC,0000h
A9FD 00           |           NOP
A9FE 00           |           NOP
A9FF 00           |           NOP
AA00 78           |           LD A,B
AA01 00           |           NOP
AA02 00           |           NOP
AA03 00           |           NOP
AA04 BA           |           CP D
AA05 90           |           SUB A,B
AA06 3A B0 4F     |           LD A,(4FB0h)
AA09 55           |           LD D,L
AA0A 54           |           LD D,H
AA0B 49           |           LD C,C
AA0C 00           |           NOP
AA0D FF           |           RST $38
AA0E ED AB        |           OTD
AA10 3F           |           CCF
AA11 00           |           NOP
AA12 00           |           NOP
AA13 FF           |           RST $38
AA14 AA           |           XOR D
AA15 FE 00        |           CP 00h
AA17 EE DD        |           XOR DDh
AA19 0C           |           INC C
AA1A 88           |           ADC A,B
AA1B 88           |           ADC A,B
AA1C DD 77 FD     |           LD (IX+FDh),A
AA1F 00           |           NOP
AA20 00           |           NOP
AA21 00           |           NOP
AA22 C0           |           RET NZ
AA23 00           |           NOP
AA24 00           |           NOP
AA25 00           |           NOP
AA26 00           |           NOP
AA27 00           |           NOP
AA28 00           |           NOP
AA29 00           |           NOP
AA2A 00           |           NOP
AA2B 87           |           ADD A,A
AA2C 00           |           NOP
AA2D 00           |           NOP
AA2E 00           |           NOP
AA2F 00           |           NOP
AA30 00           |           NOP
AA31 00           |           NOP
AA32 00           |           NOP
AA33 00           |           NOP
AA34 87           |           ADD A,A
AA35 00           |           NOP
AA36 00           |           NOP
AA37 00           |           NOP
AA38 00           |           NOP
AA39 00           |           NOP
AA3A 00           |           NOP
AA3B 00           |           NOP
AA3C 00           |           NOP
AA3D FF           |           RST $38
AA3E 28 00        |           JR Z,AA40h
AA40 78           |           LD A,B
AA41 00           |           NOP
AA42 00           |           NOP
AA43 01 00 00     |           LD BC,0000h
AA46 00           |           NOP
AA47 00           |           NOP
AA48 00           |           NOP
AA49 78           |           LD A,B
AA4A 00           |           NOP
AA4B 00           |           NOP
AA4C 00           |           NOP
AA4D 03           |           INC BC
AA4E 27           |           DAA
AA4F 5B           |           LD E,E
AA50 EE 4F        |           XOR 4Fh
AA52 55           |           LD D,L
AA53 54           |           LD D,H
AA54 44           |           LD B,H
AA55 00           |           NOP
AA56 FF           |           RST $38
AA57 ED B3        |           OTIR
AA59 3F           |           CCF
AA5A 00           |           NOP
AA5B 00           |           NOP
AA5C FF           |           RST $38
AA5D AA           |           XOR D
AA5E FE 01        |           CP 01h
AA60 EE DD        |           XOR DDh
AA62 0C           |           INC C
AA63 88           |           ADC A,B
AA64 88           |           ADC A,B
AA65 DD 77 FD     |           LD (IX+FDh),A
AA68 00           |           NOP
AA69 00           |           NOP
AA6A 00           |           NOP
AA6B C0           |           RET NZ
AA6C 00           |           NOP
AA6D 00           |           NOP
AA6E 00           |           NOP
AA6F 00           |           NOP
AA70 00           |           NOP
AA71 00           |           NOP
AA72 00           |           NOP
AA73 00           |           NOP
AA74 00           |           NOP
AA75 00           |           NOP
AA76 00           |           NOP
AA77 00           |           NOP
AA78 00           |           NOP
AA79 00           |           NOP
AA7A 00           |           NOP
AA7B 00           |           NOP
AA7C 00           |           NOP
AA7D 87           |           ADD A,A
AA7E 00           |           NOP
AA7F 00           |           NOP
AA80 00           |           NOP
AA81 00           |           NOP
AA82 00           |           NOP
AA83 00           |           NOP
AA84 00           |           NOP
AA85 00           |           NOP
AA86 FF           |           RST $38
AA87 28 00        |           JR Z,AA89h
AA89 02           |           LD (BC),A
AA8A 00           |           NOP
AA8B 00           |           NOP
AA8C 01 00 00     |           LD BC,0000h
AA8F 00           |           NOP
AA90 00           |           NOP
AA91 00           |           NOP
AA92 78           |           LD A,B
AA93 00           |           NOP
AA94 00           |           NOP
AA95 00           |           NOP
AA96 27           |           DAA
AA97 5E           |           LD E,(HL)
AA98 34           |           INC (HL)
AA99 30 4F        |           JR NC,AAEAh
AA9B 54           |           LD D,H
AA9C 49           |           LD C,C
AA9D 52           |           LD D,D
AA9E 00           |           NOP
AA9F FF           |           RST $38
AAA0 ED BB        |           OTDR
AAA2 3F           |           CCF
AAA3 00           |           NOP
AAA4 00           |           NOP
AAA5 FF           |           RST $38
AAA6 AA           |           XOR D
AAA7 FE 01        |           CP 01h
AAA9 EE DD        |           XOR DDh
AAAB 0D           |           DEC C
AAAC 88           |           ADC A,B
AAAD 88           |           ADC A,B
AAAE DD 77 FD     |           LD (IX+FDh),A
AAB1 00           |           NOP
AAB2 00           |           NOP
AAB3 00           |           NOP
AAB4 C0           |           RET NZ
AAB5 00           |           NOP
AAB6 00           |           NOP
AAB7 00           |           NOP
AAB8 00           |           NOP
AAB9 00           |           NOP
AABA 00           |           NOP
AABB 00           |           NOP
AABC 00           |           NOP
AABD 00           |           NOP
AABE 00           |           NOP
AABF 00           |           NOP
AAC0 00           |           NOP
AAC1 00           |           NOP
AAC2 00           |           NOP
AAC3 00           |           NOP
AAC4 00           |           NOP
AAC5 00           |           NOP
AAC6 00           |           NOP
AAC7 87           |           ADD A,A
AAC8 00           |           NOP
AAC9 00           |           NOP
AACA 00           |           NOP
AACB 00           |           NOP
AACC 00           |           NOP
AACD 00           |           NOP
AACE 00           |           NOP
AACF FF           |           RST $38
AAD0 28 00        |           JR Z,AAD2h
AAD2 02           |           LD (BC),A
AAD3 00           |           NOP
AAD4 00           |           NOP
AAD5 01 00 00     |           LD BC,0000h
AAD8 00           |           NOP
AAD9 00           |           NOP
AADA 00           |           NOP
AADB 00           |           NOP
AADC 78           |           LD A,B
AADD 00           |           NOP
AADE 00           |           NOP
AADF DE 27        |           SBC A,27h
AAE1 2F           |           CPL
AAE2 70           |           LD (HL),B
AAE3 4F           |           LD C,A
AAE4 54           |           LD D,H
AAE5 44           |           LD B,H
AAE6 52           |           LD D,D
AAE7 00           |           NOP
AAE8 FF           |           RST $38
AAE9 C3 10 88     |           JP 8810h
AAEC 3F           |           CCF
AAED 00           |           NOP
AAEE FF           |           RST $38
AAEF AA           |           XOR D
AAF0 CC BB EE     |           CALL Z,EEBBh
AAF3 DD           |           *ILLEGAL*
AAF4 11 44 88     |           LD DE,8844h
AAF7 DD 77 FD     |           LD (IX+FDh),A
AAFA 34           |           INC (HL)
AAFB 12           |           LD (DE),A
AAFC 00           |           NOP
AAFD C0           |           RET NZ
AAFE 00           |           NOP
AAFF 00           |           NOP
AB00 00           |           NOP
AB01 00           |           NOP
AB02 00           |           NOP
AB03 00           |           NOP
AB04 00           |           NOP
AB05 00           |           NOP
AB06 00           |           NOP
AB07 00           |           NOP
AB08 00           |           NOP
AB09 00           |           NOP
AB0A 00           |           NOP
AB0B 00           |           NOP
AB0C 00           |           NOP
AB0D 00           |           NOP
AB0E 00           |           NOP
AB0F 00           |           NOP
AB10 00           |           NOP
AB11 00           |           NOP
AB12 00           |           NOP
AB13 00           |           NOP
AB14 00           |           NOP
AB15 00           |           NOP
AB16 00           |           NOP
AB17 00           |           NOP
AB18 FF           |           RST $38
AB19 28 00        |           JR Z,AB1Bh
AB1B 00           |           NOP
AB1C 00           |           NOP
AB1D 00           |           NOP
AB1E 00           |           NOP
AB1F 00           |           NOP
AB20 00           |           NOP
AB21 00           |           NOP
AB22 00           |           NOP
AB23 00           |           NOP
AB24 00           |           NOP
AB25 00           |           NOP
AB26 00           |           NOP
AB27 00           |           NOP
AB28 C3 F6 46     |           JP 46F6h
AB2B 0B           |           DEC BC
AB2C 4A           |           LD C,D
AB2D 50           |           LD D,B
AB2E 20 4E        |           JR NZ,AB7Eh
AB30 4E           |           LD C,(HL)
AB31 00           |           NOP
AB32 FF           |           RST $38
AB33 C2 10 88     |           JP NZ,8810h
AB36 3F           |           CCF
AB37 00           |           NOP
AB38 FF           |           RST $38
AB39 AA           |           XOR D
AB3A CC BB EE     |           CALL Z,EEBBh
AB3D DD           |           *ILLEGAL*
AB3E 11 44 88     |           LD DE,8844h
AB41 DD 77 FD     |           LD (IX+FDh),A
AB44 34           |           INC (HL)
AB45 12           |           LD (DE),A
AB46 00           |           NOP
AB47 C0           |           RET NZ
AB48 38 00        |           JR C,AB4Ah
AB4A 00           |           NOP
AB4B 00           |           NOP
AB4C 00           |           NOP
AB4D 00           |           NOP
AB4E 00           |           NOP
AB4F 00           |           NOP
AB50 00           |           NOP
AB51 00           |           NOP
AB52 00           |           NOP
AB53 00           |           NOP
AB54 00           |           NOP
AB55 00           |           NOP
AB56 00           |           NOP
AB57 00           |           NOP
AB58 00           |           NOP
AB59 00           |           NOP
AB5A 00           |           NOP
AB5B 00           |           NOP
AB5C 00           |           NOP
AB5D 00           |           NOP
AB5E 00           |           NOP
AB5F 00           |           NOP
AB60 00           |           NOP
AB61 00           |           NOP
AB62 FF           |           RST $38
AB63 28 00        |           JR Z,AB65h
AB65 00           |           NOP
AB66 00           |           NOP
AB67 00           |           NOP
AB68 00           |           NOP
AB69 00           |           NOP
AB6A 00           |           NOP
AB6B 00           |           NOP
AB6C 00           |           NOP
AB6D 00           |           NOP
AB6E 00           |           NOP
AB6F 00           |           NOP
AB70 00           |           NOP
AB71 00           |           NOP
AB72 05           |           DEC B
AB73 E7           |           RST $20
AB74 05           |           DEC B
AB75 E5           |           PUSH HL
AB76 4A           |           LD C,D
AB77 50           |           LD D,B
AB78 20 43        |           JR NZ,ABBDh
AB7A 43           |           LD B,E
AB7B 2C           |           INC L
AB7C 4E           |           LD C,(HL)
AB7D 4E           |           LD C,(HL)
AB7E 00           |           NOP
AB7F FF           |           RST $38
AB80 E9           |           JP (HL)
AB81 3F           |           CCF
AB82 00           |           NOP
AB83 00           |           NOP
AB84 00           |           NOP
AB85 FF           |           RST $38
AB86 AA           |           XOR D
AB87 CC BB EE     |           CALL Z,EEBBh
AB8A DD           |           *ILLEGAL*
AB8B 10 88        |           DJNZ AB15h
AB8D 88           |           ADC A,B
AB8E DD 77 FD     |           LD (IX+FDh),A
AB91 34           |           INC (HL)
AB92 12           |           LD (DE),A
AB93 00           |           NOP
AB94 C0           |           RET NZ
AB95 00           |           NOP
AB96 00           |           NOP
AB97 00           |           NOP
AB98 00           |           NOP
AB99 00           |           NOP
AB9A 00           |           NOP
AB9B 00           |           NOP
AB9C 00           |           NOP
AB9D 00           |           NOP
AB9E 00           |           NOP
AB9F 00           |           NOP
ABA0 00           |           NOP
ABA1 00           |           NOP
ABA2 00           |           NOP
ABA3 00           |           NOP
ABA4 00           |           NOP
ABA5 00           |           NOP
ABA6 00           |           NOP
ABA7 00           |           NOP
ABA8 00           |           NOP
ABA9 00           |           NOP
ABAA 00           |           NOP
ABAB 00           |           NOP
ABAC 00           |           NOP
ABAD 00           |           NOP
ABAE 00           |           NOP
ABAF FF           |           RST $38
ABB0 28 00        |           JR Z,ABB2h
ABB2 00           |           NOP
ABB3 00           |           NOP
ABB4 00           |           NOP
ABB5 01 00 00     |           LD BC,0000h
ABB8 00           |           NOP
ABB9 00           |           NOP
ABBA 00           |           NOP
ABBB 00           |           NOP
ABBC 00           |           NOP
ABBD 00           |           NOP
ABBE 00           |           NOP
ABBF BA           |           CP D
ABC0 13           |           INC DE
ABC1 C0           |           RET NZ
ABC2 43           |           LD B,E
ABC3 4A           |           LD C,D
ABC4 50           |           LD D,B
ABC5 20 28        |           JR NZ,ABEFh
ABC7 48           |           LD C,B
ABC8 4C           |           LD C,H
ABC9 29           |           ADD HL,HL
ABCA 00           |           NOP
ABCB FF           |           RST $38
ABCC DD E9        |           JP (IX)
ABCE 3F           |           CCF
ABCF 00           |           NOP
ABD0 00           |           NOP
ABD1 FF           |           RST $38
ABD2 AA           |           XOR D
ABD3 CC BB EE     |           CALL Z,EEBBh
ABD6 DD           |           *ILLEGAL*
ABD7 11 44 10     |           LD DE,1044h
ABDA 88           |           ADC A,B
ABDB 10 88        |           DJNZ AB65h
ABDD 34           |           INC (HL)
ABDE 12           |           LD (DE),A
ABDF 00           |           NOP
ABE0 C0           |           RET NZ
ABE1 20 00        |           JR NZ,ABE3h
ABE3 00           |           NOP
ABE4 00           |           NOP
ABE5 00           |           NOP
ABE6 00           |           NOP
ABE7 00           |           NOP
ABE8 00           |           NOP
ABE9 00           |           NOP
ABEA 00           |           NOP
ABEB 00           |           NOP
ABEC 00           |           NOP
ABED 00           |           NOP
ABEE 00           |           NOP
ABEF 00           |           NOP
ABF0 00           |           NOP
ABF1 00           |           NOP
ABF2 00           |           NOP
ABF3 00           |           NOP
ABF4 00           |           NOP
ABF5 00           |           NOP
ABF6 00           |           NOP
ABF7 00           |           NOP
ABF8 00           |           NOP
ABF9 00           |           NOP
ABFA 00           |           NOP
ABFB FF           |           RST $38
ABFC 28 00        |           JR Z,ABFEh
ABFE 00           |           NOP
ABFF 00           |           NOP
AC00 00           |           NOP
AC01 00           |           NOP
AC02 00           |           NOP
AC03 01 00 01     |           LD BC,0100h
AC06 00           |           NOP
AC07 00           |           NOP
AC08 00           |           NOP
AC09 00           |           NOP
AC0A 00           |           NOP
AC0B 86           |           ADD A,(HL)
AC0C 5A           |           LD E,D
AC0D F2 B2 4A     |           JP P,4AB2h
AC10 50           |           LD D,B
AC11 20 28        |           JR NZ,AC3Bh
AC13 58           |           LD E,B
AC14 59           |           LD E,C
AC15 29           |           ADD HL,HL
AC16 00           |           NOP
AC17 FF           |           RST $38
AC18 18 00        |           JR AC1Ah
AC1A 03           |           INC BC
AC1B 3F           |           CCF
AC1C 00           |           NOP
AC1D FF           |           RST $38
AC1E AA           |           XOR D
AC1F CC BB EE     |           CALL Z,EEBBh
AC22 DD           |           *ILLEGAL*
AC23 11 44 88     |           LD DE,8844h
AC26 DD 77 FD     |           LD (IX+FDh),A
AC29 34           |           INC (HL)
AC2A 12           |           LD (DE),A
AC2B 00           |           NOP
AC2C C0           |           RET NZ
AC2D 00           |           NOP
AC2E 01 00 00     |           LD BC,0000h
AC31 00           |           NOP
AC32 00           |           NOP
AC33 00           |           NOP
AC34 00           |           NOP
AC35 00           |           NOP
AC36 00           |           NOP
AC37 00           |           NOP
AC38 00           |           NOP
AC39 00           |           NOP
AC3A 00           |           NOP
AC3B 00           |           NOP
AC3C 00           |           NOP
AC3D 00           |           NOP
AC3E 00           |           NOP
AC3F 00           |           NOP
AC40 00           |           NOP
AC41 00           |           NOP
AC42 00           |           NOP
AC43 00           |           NOP
AC44 00           |           NOP
AC45 00           |           NOP
AC46 00           |           NOP
AC47 FF           |           RST $38
AC48 28 00        |           JR Z,AC4Ah
AC4A 00           |           NOP
AC4B 00           |           NOP
AC4C 00           |           NOP
AC4D 00           |           NOP
AC4E 00           |           NOP
AC4F 00           |           NOP
AC50 00           |           NOP
AC51 00           |           NOP
AC52 00           |           NOP
AC53 00           |           NOP
AC54 00           |           NOP
AC55 00           |           NOP
AC56 00           |           NOP
AC57 69           |           LD L,C
AC58 9B           |           SBC A,E
AC59 BC           |           CP H
AC5A EA 4A 52     |           JP PE,524Ah
AC5D 20 4E        |           JR NZ,ACADh
AC5F 00           |           NOP
AC60 FF           |           RST $38
AC61 20 00        |           JR NZ,AC63h
AC63 03           |           INC BC
AC64 3F           |           CCF
AC65 00           |           NOP
AC66 FF           |           RST $38
AC67 AA           |           XOR D
AC68 CC BB EE     |           CALL Z,EEBBh
AC6B DD           |           *ILLEGAL*
AC6C 11 44 88     |           LD DE,8844h
AC6F DD 77 FD     |           LD (IX+FDh),A
AC72 34           |           INC (HL)
AC73 12           |           LD (DE),A
AC74 00           |           NOP
AC75 C0           |           RET NZ
AC76 18 01        |           JR AC79h
AC78 00           |           NOP
AC79 00           |           NOP
AC7A 00           |           NOP
AC7B 00           |           NOP
AC7C 00           |           NOP
AC7D 00           |           NOP
AC7E 00           |           NOP
AC7F 00           |           NOP
AC80 00           |           NOP
AC81 00           |           NOP
AC82 00           |           NOP
AC83 00           |           NOP
AC84 00           |           NOP
AC85 00           |           NOP
AC86 00           |           NOP
AC87 00           |           NOP
AC88 00           |           NOP
AC89 00           |           NOP
AC8A 00           |           NOP
AC8B 00           |           NOP
AC8C 00           |           NOP
AC8D 00           |           NOP
AC8E 00           |           NOP
AC8F 00           |           NOP
AC90 FF           |           RST $38
AC91 28 00        |           JR Z,AC93h
AC93 00           |           NOP
AC94 00           |           NOP
AC95 00           |           NOP
AC96 00           |           NOP
AC97 00           |           NOP
AC98 00           |           NOP
AC99 00           |           NOP
AC9A 00           |           NOP
AC9B 00           |           NOP
AC9C 00           |           NOP
AC9D 00           |           NOP
AC9E 00           |           NOP
AC9F 00           |           NOP
ACA0 05           |           DEC B
ACA1 E7           |           RST $20
ACA2 05           |           DEC B
ACA3 E5           |           PUSH HL
ACA4 4A           |           LD C,D
ACA5 52           |           LD D,D
ACA6 20 43        |           JR NZ,ACEBh
ACA8 43           |           LD B,E
ACA9 2C           |           INC L
ACAA 4E           |           LD C,(HL)
ACAB 00           |           NOP
ACAC FF           |           RST $38
ACAD 10 00        |           DJNZ ACAFh
ACAF 03           |           INC BC
ACB0 3F           |           CCF
ACB1 00           |           NOP
ACB2 FF           |           RST $38
ACB3 AA           |           XOR D
ACB4 CC BB EE     |           CALL Z,EEBBh
ACB7 DD           |           *ILLEGAL*
ACB8 11 44 88     |           LD DE,8844h
ACBB DD 77 FD     |           LD (IX+FDh),A
ACBE 34           |           INC (HL)
ACBF 12           |           LD (DE),A
ACC0 00           |           NOP
ACC1 C0           |           RET NZ
ACC2 00           |           NOP
ACC3 01 00 00     |           LD BC,0000h
ACC6 00           |           NOP
ACC7 00           |           NOP
ACC8 00           |           NOP
ACC9 00           |           NOP
ACCA FF           |           RST $38
ACCB 00           |           NOP
ACCC 00           |           NOP
ACCD 00           |           NOP
ACCE 00           |           NOP
ACCF 00           |           NOP
ACD0 00           |           NOP
ACD1 00           |           NOP
ACD2 00           |           NOP
ACD3 00           |           NOP
ACD4 00           |           NOP
ACD5 00           |           NOP
ACD6 00           |           NOP
ACD7 00           |           NOP
ACD8 00           |           NOP
ACD9 00           |           NOP
ACDA 00           |           NOP
ACDB 00           |           NOP
ACDC FF           |           RST $38
ACDD 28 00        |           JR Z,ACDFh
ACDF 00           |           NOP
ACE0 00           |           NOP
ACE1 00           |           NOP
ACE2 00           |           NOP
ACE3 00           |           NOP
ACE4 00           |           NOP
ACE5 00           |           NOP
ACE6 00           |           NOP
ACE7 00           |           NOP
ACE8 00           |           NOP
ACE9 00           |           NOP
ACEA 00           |           NOP
ACEB 00           |           NOP
ACEC 44           |           LD B,H
ACED BE           |           CP (HL)
ACEE 15           |           DEC D
ACEF 74           |           LD (HL),H
ACF0 44           |           LD B,H
ACF1 4A           |           LD C,D
ACF2 4E           |           LD C,(HL)
ACF3 5A           |           LD E,D
ACF4 20 4E        |           JR NZ,AD44h
ACF6 00           |           NOP
ACF7 FF           |           RST $38
ACF8 CD 10 88     |           CALL 8810h
ACFB 3F           |           CCF
ACFC 00           |           NOP
ACFD FF           |           RST $38
ACFE AA           |           XOR D
ACFF CC BB EE     |           CALL Z,EEBBh
AD02 DD           |           *ILLEGAL*
AD03 11 44 88     |           LD DE,8844h
AD06 DD 77 FD     |           LD (IX+FDh),A
AD09 34           |           INC (HL)
AD0A 12           |           LD (DE),A
AD0B 0C           |           INC C
AD0C 88           |           ADC A,B
AD0D 00           |           NOP
AD0E 00           |           NOP
AD0F 00           |           NOP
AD10 00           |           NOP
AD11 00           |           NOP
AD12 00           |           NOP
AD13 00           |           NOP
AD14 00           |           NOP
AD15 00           |           NOP
AD16 00           |           NOP
AD17 00           |           NOP
AD18 00           |           NOP
AD19 00           |           NOP
AD1A 00           |           NOP
AD1B 00           |           NOP
AD1C 00           |           NOP
AD1D 00           |           NOP
AD1E 00           |           NOP
AD1F 00           |           NOP
AD20 00           |           NOP
AD21 00           |           NOP
AD22 00           |           NOP
AD23 00           |           NOP
AD24 00           |           NOP
AD25 00           |           NOP
AD26 00           |           NOP
AD27 FF           |           RST $38
AD28 28 00        |           JR Z,AD2Ah
AD2A 00           |           NOP
AD2B 00           |           NOP
AD2C 00           |           NOP
AD2D 00           |           NOP
AD2E 00           |           NOP
AD2F 00           |           NOP
AD30 00           |           NOP
AD31 00           |           NOP
AD32 00           |           NOP
AD33 00           |           NOP
AD34 00           |           NOP
AD35 00           |           NOP
AD36 00           |           NOP
AD37 C3 F6 46     |           JP 46F6h
AD3A 0B           |           DEC BC
AD3B 43           |           LD B,E
AD3C 41           |           LD B,C
AD3D 4C           |           LD C,H
AD3E 4C           |           LD C,H
AD3F 20 4E        |           JR NZ,AD8Fh
AD41 4E           |           LD C,(HL)
AD42 00           |           NOP
AD43 FF           |           RST $38
AD44 C4 10 88     |           CALL NZ,8810h
AD47 3F           |           CCF
AD48 00           |           NOP
AD49 FF           |           RST $38
AD4A AA           |           XOR D
AD4B CC BB EE     |           CALL Z,EEBBh
AD4E DD           |           *ILLEGAL*
AD4F 11 44 88     |           LD DE,8844h
AD52 DD 77 FD     |           LD (IX+FDh),A
AD55 34           |           INC (HL)
AD56 12           |           LD (DE),A
AD57 0C           |           INC C
AD58 88           |           ADC A,B
AD59 38 00        |           JR C,AD5Bh
AD5B 00           |           NOP
AD5C 00           |           NOP
AD5D 00           |           NOP
AD5E 00           |           NOP
AD5F 00           |           NOP
AD60 00           |           NOP
AD61 00           |           NOP
AD62 00           |           NOP
AD63 00           |           NOP
AD64 00           |           NOP
AD65 00           |           NOP
AD66 00           |           NOP
AD67 00           |           NOP
AD68 00           |           NOP
AD69 00           |           NOP
AD6A 00           |           NOP
AD6B 00           |           NOP
AD6C 00           |           NOP
AD6D 00           |           NOP
AD6E 00           |           NOP
AD6F 00           |           NOP
AD70 00           |           NOP
AD71 00           |           NOP
AD72 00           |           NOP
AD73 FF           |           RST $38
AD74 28 00        |           JR Z,AD76h
AD76 00           |           NOP
AD77 00           |           NOP
AD78 00           |           NOP
AD79 00           |           NOP
AD7A 00           |           NOP
AD7B 00           |           NOP
AD7C 00           |           NOP
AD7D 00           |           NOP
AD7E 00           |           NOP
AD7F 00           |           NOP
AD80 00           |           NOP
AD81 00           |           NOP
AD82 00           |           NOP
AD83 05           |           DEC B
AD84 E7           |           RST $20
AD85 05           |           DEC B
AD86 E5           |           PUSH HL
AD87 43           |           LD B,E
AD88 41           |           LD B,C
AD89 4C           |           LD C,H
AD8A 4C           |           LD C,H
AD8B 20 43        |           JR NZ,ADD0h
AD8D 43           |           LD B,E
AD8E 2C           |           INC L
AD8F 4E           |           LD C,(HL)
AD90 4E           |           LD C,(HL)
AD91 00           |           NOP
AD92 FF           |           RST $38
AD93 C9           |           RET
AD94 3F           |           CCF
AD95 00           |           NOP
AD96 00           |           NOP
AD97 00           |           NOP
AD98 FF           |           RST $38
AD99 AA           |           XOR D
AD9A CC BB EE     |           CALL Z,EEBBh
AD9D DD           |           *ILLEGAL*
AD9E 11 44 88     |           LD DE,8844h
ADA1 DD 77 FD     |           LD (IX+FDh),A
ADA4 10 88        |           DJNZ AD2Eh
ADA6 0C           |           INC C
ADA7 88           |           ADC A,B
ADA8 00           |           NOP
ADA9 00           |           NOP
ADAA 00           |           NOP
ADAB 00           |           NOP
ADAC 00           |           NOP
ADAD 00           |           NOP
ADAE 00           |           NOP
ADAF 00           |           NOP
ADB0 00           |           NOP
ADB1 00           |           NOP
ADB2 00           |           NOP
ADB3 00           |           NOP
ADB4 00           |           NOP
ADB5 00           |           NOP
ADB6 00           |           NOP
ADB7 00           |           NOP
ADB8 00           |           NOP
ADB9 00           |           NOP
ADBA 00           |           NOP
ADBB 00           |           NOP
ADBC 00           |           NOP
ADBD 00           |           NOP
ADBE 00           |           NOP
ADBF 00           |           NOP
ADC0 00           |           NOP
ADC1 00           |           NOP
ADC2 FF           |           RST $38
ADC3 28 00        |           JR Z,ADC5h
ADC5 00           |           NOP
ADC6 00           |           NOP
ADC7 00           |           NOP
ADC8 00           |           NOP
ADC9 00           |           NOP
ADCA 00           |           NOP
ADCB 00           |           NOP
ADCC 00           |           NOP
ADCD 00           |           NOP
ADCE 00           |           NOP
ADCF 00           |           NOP
ADD0 00           |           NOP
ADD1 00           |           NOP
ADD2 C3 F6 46     |           JP 46F6h
ADD5 0B           |           DEC BC
ADD6 52           |           LD D,D
ADD7 45           |           LD B,L
ADD8 54           |           LD D,H
ADD9 00           |           NOP
ADDA FF           |           RST $38
ADDB C0           |           RET NZ
ADDC 3F           |           CCF
ADDD 00           |           NOP
ADDE 00           |           NOP
ADDF 00           |           NOP
ADE0 FF           |           RST $38
ADE1 AA           |           XOR D
ADE2 CC BB EE     |           CALL Z,EEBBh
ADE5 DD           |           *ILLEGAL*
ADE6 11 44 88     |           LD DE,8844h
ADE9 DD 77 FD     |           LD (IX+FDh),A
ADEC 10 88        |           DJNZ AD76h
ADEE 0C           |           INC C
ADEF 88           |           ADC A,B
ADF0 38 00        |           JR C,ADF2h
ADF2 00           |           NOP
ADF3 00           |           NOP
ADF4 00           |           NOP
ADF5 00           |           NOP
ADF6 00           |           NOP
ADF7 00           |           NOP
ADF8 00           |           NOP
ADF9 00           |           NOP
ADFA 00           |           NOP
ADFB 00           |           NOP
ADFC 00           |           NOP
ADFD 00           |           NOP
ADFE 00           |           NOP
ADFF 00           |           NOP
AE00 00           |           NOP
AE01 00           |           NOP
AE02 00           |           NOP
AE03 00           |           NOP
AE04 00           |           NOP
AE05 00           |           NOP
AE06 00           |           NOP
AE07 00           |           NOP
AE08 00           |           NOP
AE09 00           |           NOP
AE0A FF           |           RST $38
AE0B 28 00        |           JR Z,AE0Dh
AE0D 00           |           NOP
AE0E 00           |           NOP
AE0F 00           |           NOP
AE10 00           |           NOP
AE11 00           |           NOP
AE12 00           |           NOP
AE13 00           |           NOP
AE14 00           |           NOP
AE15 00           |           NOP
AE16 00           |           NOP
AE17 00           |           NOP
AE18 00           |           NOP
AE19 00           |           NOP
AE1A 05           |           DEC B
AE1B E7           |           RST $20
AE1C 05           |           DEC B
AE1D E5           |           PUSH HL
AE1E 52           |           LD D,D
AE1F 45           |           LD B,L
AE20 54           |           LD D,H
AE21 20 43        |           JR NZ,AE66h
AE23 43           |           LD B,E
AE24 00           |           NOP
AE25 FF           |           RST $38
AE26 ED 45        |           RETN
AE28 3F           |           CCF
AE29 00           |           NOP
AE2A 00           |           NOP
AE2B FF           |           RST $38
AE2C AA           |           XOR D
AE2D CC BB EE     |           CALL Z,EEBBh
AE30 DD           |           *ILLEGAL*
AE31 11 44 88     |           LD DE,8844h
AE34 DD 77 FD     |           LD (IX+FDh),A
AE37 10 88        |           DJNZ ADC1h
AE39 0C           |           INC C
AE3A 88           |           ADC A,B
AE3B 00           |           NOP
AE3C 00           |           NOP
AE3D 00           |           NOP
AE3E 00           |           NOP
AE3F 00           |           NOP
AE40 00           |           NOP
AE41 00           |           NOP
AE42 00           |           NOP
AE43 00           |           NOP
AE44 00           |           NOP
AE45 00           |           NOP
AE46 00           |           NOP
AE47 00           |           NOP
AE48 00           |           NOP
AE49 00           |           NOP
AE4A 00           |           NOP
AE4B 00           |           NOP
AE4C 00           |           NOP
AE4D 00           |           NOP
AE4E 00           |           NOP
AE4F 00           |           NOP
AE50 00           |           NOP
AE51 00           |           NOP
AE52 00           |           NOP
AE53 00           |           NOP
AE54 00           |           NOP
AE55 FF           |           RST $38
AE56 28 00        |           JR Z,AE58h
AE58 00           |           NOP
AE59 00           |           NOP
AE5A 00           |           NOP
AE5B 00           |           NOP
AE5C 00           |           NOP
AE5D 00           |           NOP
AE5E 00           |           NOP
AE5F 00           |           NOP
AE60 00           |           NOP
AE61 00           |           NOP
AE62 00           |           NOP
AE63 00           |           NOP
AE64 00           |           NOP
AE65 C3 F6 46     |           JP 46F6h
AE68 0B           |           DEC BC
AE69 52           |           LD D,D
AE6A 45           |           LD B,L
AE6B 54           |           LD D,H
AE6C 4E           |           LD C,(HL)
AE6D 00           |           NOP
AE6E FF           |           RST $38
AE6F ED 4D        |           RETI
AE71 3F           |           CCF
AE72 00           |           NOP
AE73 00           |           NOP
AE74 FF           |           RST $38
AE75 AA           |           XOR D
AE76 CC BB EE     |           CALL Z,EEBBh
AE79 DD           |           *ILLEGAL*
AE7A 11 44 88     |           LD DE,8844h
AE7D DD 77 FD     |           LD (IX+FDh),A
AE80 10 88        |           DJNZ AE0Ah
AE82 0C           |           INC C
AE83 88           |           ADC A,B
AE84 00           |           NOP
AE85 00           |           NOP
AE86 00           |           NOP
AE87 00           |           NOP
AE88 00           |           NOP
AE89 00           |           NOP
AE8A 00           |           NOP
AE8B 00           |           NOP
AE8C 00           |           NOP
AE8D 00           |           NOP
AE8E 00           |           NOP
AE8F 00           |           NOP
AE90 00           |           NOP
AE91 00           |           NOP
AE92 00           |           NOP
AE93 00           |           NOP
AE94 00           |           NOP
AE95 00           |           NOP
AE96 00           |           NOP
AE97 00           |           NOP
AE98 00           |           NOP
AE99 00           |           NOP
AE9A 00           |           NOP
AE9B 00           |           NOP
AE9C 00           |           NOP
AE9D 00           |           NOP
AE9E FF           |           RST $38
AE9F 28 00        |           JR Z,AEA1h
AEA1 00           |           NOP
AEA2 00           |           NOP
AEA3 00           |           NOP
AEA4 00           |           NOP
AEA5 00           |           NOP
AEA6 00           |           NOP
AEA7 00           |           NOP
AEA8 00           |           NOP
AEA9 00           |           NOP
AEAA 00           |           NOP
AEAB 00           |           NOP
AEAC 00           |           NOP
AEAD 00           |           NOP
AEAE C3 F6 46     |           JP 46F6h
AEB1 0B           |           DEC BC
AEB2 52           |           LD D,D
AEB3 45           |           LD B,L
AEB4 54           |           LD D,H
AEB5 49           |           LD C,C
AEB6 00           |           NOP
AEB7 FF           |           RST $38
AEB8 ED 45        |           RETN
AEBA 3F           |           CCF
AEBB 00           |           NOP
AEBC 00           |           NOP
AEBD FF           |           RST $38
AEBE AA           |           XOR D
AEBF CC BB EE     |           CALL Z,EEBBh
AEC2 DD           |           *ILLEGAL*
AEC3 11 44 88     |           LD DE,8844h
AEC6 DD 77 FD     |           LD (IX+FDh),A
AEC9 10 88        |           DJNZ AE53h
AECB 0C           |           INC C
AECC 88           |           ADC A,B
AECD 00           |           NOP
AECE 38 00        |           JR C,AED0h
AED0 00           |           NOP
AED1 00           |           NOP
AED2 00           |           NOP
AED3 00           |           NOP
AED4 00           |           NOP
AED5 00           |           NOP
AED6 00           |           NOP
AED7 00           |           NOP
AED8 00           |           NOP
AED9 00           |           NOP
AEDA 00           |           NOP
AEDB 00           |           NOP
AEDC 00           |           NOP
AEDD 00           |           NOP
AEDE 00           |           NOP
AEDF 00           |           NOP
AEE0 00           |           NOP
AEE1 00           |           NOP
AEE2 00           |           NOP
AEE3 00           |           NOP
AEE4 00           |           NOP
AEE5 00           |           NOP
AEE6 00           |           NOP
AEE7 FF           |           RST $38
AEE8 28 00        |           JR Z,AEEAh
AEEA 00           |           NOP
AEEB 00           |           NOP
AEEC 00           |           NOP
AEED 00           |           NOP
AEEE 00           |           NOP
AEEF 00           |           NOP
AEF0 00           |           NOP
AEF1 00           |           NOP
AEF2 00           |           NOP
AEF3 00           |           NOP
AEF4 00           |           NOP
AEF5 00           |           NOP
AEF6 00           |           NOP
AEF7 05           |           DEC B
AEF8 E7           |           RST $20
AEF9 05           |           DEC B
AEFA E5           |           PUSH HL
AEFB 52           |           LD D,D
AEFC 45           |           LD B,L
AEFD 54           |           LD D,H
AEFE 49           |           LD C,C
AEFF 2F           |           CPL
AF00 52           |           LD D,D
AF01 45           |           LD B,L
AF02 54           |           LD D,H
AF03 4E           |           LD C,(HL)
AF04 00           |           NOP
AF05 FF           |           RST $38
AF06 C5           |           PUSH BC
AF07 C1           |           POP BC
AF08 3F           |           CCF
AF09 00           |           NOP
AF0A 00           |           NOP
AF0B FF           |           RST $38
AF0C AA           |           XOR D
AF0D CC BB EE     |           CALL Z,EEBBh
AF10 DD           |           *ILLEGAL*
AF11 11 44 88     |           LD DE,8844h
AF14 DD 77 FD     |           LD (IX+FDh),A
AF17 34           |           INC (HL)
AF18 12           |           LD (DE),A
AF19 0E 88        |           LD C,88h
AF1B 30 30        |           JR NC,AF4Dh
AF1D 00           |           NOP
AF1E 00           |           NOP
AF1F 00           |           NOP
AF20 00           |           NOP
AF21 00           |           NOP
AF22 00           |           NOP
AF23 00           |           NOP
AF24 00           |           NOP
AF25 00           |           NOP
AF26 00           |           NOP
AF27 00           |           NOP
AF28 00           |           NOP
AF29 00           |           NOP
AF2A 00           |           NOP
AF2B 00           |           NOP
AF2C 00           |           NOP
AF2D 00           |           NOP
AF2E 00           |           NOP
AF2F 00           |           NOP
AF30 00           |           NOP
AF31 00           |           NOP
AF32 00           |           NOP
AF33 00           |           NOP
AF34 00           |           NOP
AF35 FF           |           RST $38
AF36 A8           |           XOR B
AF37 01 80 01     |           LD BC,0180h
AF3A 80           |           ADD A,B
AF3B 01 80 00     |           LD BC,0080h
AF3E 00           |           NOP
AF3F 00           |           NOP
AF40 00           |           NOP
AF41 00           |           NOP
AF42 00           |           NOP
AF43 00           |           NOP
AF44 00           |           NOP
AF45 15           |           DEC D
AF46 C4 C1 21     |           CALL NZ,21C1h
AF49 50           |           LD D,B
AF4A 55           |           LD D,L
AF4B 53           |           LD D,E
AF4C 48           |           LD C,B
AF4D 2B           |           DEC HL
AF4E 50           |           LD D,B
AF4F 4F           |           LD C,A
AF50 50           |           LD D,B
AF51 20 52        |           JR NZ,AFA5h
AF53 52           |           LD D,D
AF54 00           |           NOP
AF55 FF           |           RST $38
AF56 F1           |           POP AF
AF57 F5           |           PUSH AF
AF58 3F           |           CCF
AF59 00           |           NOP
AF5A 00           |           NOP
AF5B FF           |           RST $38
AF5C AA           |           XOR D
AF5D CC BB EE     |           CALL Z,EEBBh
AF60 DD           |           *ILLEGAL*
AF61 11 44 88     |           LD DE,8844h
AF64 DD 77 FD     |           LD (IX+FDh),A
AF67 00           |           NOP
AF68 00           |           NOP
AF69 0C           |           INC C
AF6A 88           |           ADC A,B
AF6B 00           |           NOP
AF6C 00           |           NOP
AF6D 00           |           NOP
AF6E 00           |           NOP
AF6F 00           |           NOP
AF70 00           |           NOP
AF71 00           |           NOP
AF72 00           |           NOP
AF73 00           |           NOP
AF74 00           |           NOP
AF75 00           |           NOP
AF76 00           |           NOP
AF77 00           |           NOP
AF78 00           |           NOP
AF79 00           |           NOP
AF7A 00           |           NOP
AF7B 00           |           NOP
AF7C FF           |           RST $38
AF7D 00           |           NOP
AF7E 00           |           NOP
AF7F 00           |           NOP
AF80 00           |           NOP
AF81 00           |           NOP
AF82 00           |           NOP
AF83 00           |           NOP
AF84 00           |           NOP
AF85 00           |           NOP
AF86 28 00        |           JR Z,AF88h
AF88 00           |           NOP
AF89 00           |           NOP
AF8A 00           |           NOP
AF8B 00           |           NOP
AF8C 00           |           NOP
AF8D 00           |           NOP
AF8E 00           |           NOP
AF8F 00           |           NOP
AF90 00           |           NOP
AF91 00           |           NOP
AF92 81           |           ADD A,C
AF93 00           |           NOP
AF94 00           |           NOP
AF95 4D           |           LD C,L
AF96 06 61        |           LD B,61h
AF98 7F           |           LD A,A
AF99 50           |           LD D,B
AF9A 4F           |           LD C,A
AF9B 50           |           LD D,B
AF9C 2B           |           DEC HL
AF9D 50           |           LD D,B
AF9E 55           |           LD D,L
AF9F 53           |           LD D,E
AFA0 48           |           LD C,B
AFA1 20 41        |           JR NZ,AFE4h
AFA3 46           |           LD B,(HL)
AFA4 00           |           NOP
AFA5 FF           |           RST $38
AFA6 DD E5        |           PUSH IX
AFA8 DD E1        |           POP IX
AFAA 3F           |           CCF
AFAB FF           |           RST $38
AFAC AA           |           XOR D
AFAD CC BB EE     |           CALL Z,EEBBh
AFB0 DD           |           *ILLEGAL*
AFB1 11 44 88     |           LD DE,8844h
AFB4 DD 77 FD     |           LD (IX+FDh),A
AFB7 34           |           INC (HL)
AFB8 12           |           LD (DE),A
AFB9 0E 88        |           LD C,88h
AFBB 20 00        |           JR NZ,AFBDh
AFBD 20 00        |           JR NZ,AFBFh
AFBF 00           |           NOP
AFC0 00           |           NOP
AFC1 00           |           NOP
AFC2 00           |           NOP
AFC3 00           |           NOP
AFC4 00           |           NOP
AFC5 00           |           NOP
AFC6 00           |           NOP
AFC7 00           |           NOP
AFC8 00           |           NOP
AFC9 00           |           NOP
AFCA 00           |           NOP
AFCB 00           |           NOP
AFCC 00           |           NOP
AFCD 00           |           NOP
AFCE 00           |           NOP
AFCF 00           |           NOP
AFD0 00           |           NOP
AFD1 00           |           NOP
AFD2 00           |           NOP
AFD3 00           |           NOP
AFD4 00           |           NOP
AFD5 FF           |           RST $38
AFD6 28 00        |           JR Z,AFD8h
AFD8 00           |           NOP
AFD9 00           |           NOP
AFDA 00           |           NOP
AFDB 00           |           NOP
AFDC 00           |           NOP
AFDD 01 80 01     |           LD BC,0180h
AFE0 80           |           ADD A,B
AFE1 00           |           NOP
AFE2 00           |           NOP
AFE3 00           |           NOP
AFE4 00           |           NOP
AFE5 C0           |           RET NZ
AFE6 D0           |           RET NC
AFE7 22 59 50     |           LD (5059h),HL
AFEA 55           |           LD D,L
AFEB 53           |           LD D,E
AFEC 48           |           LD C,B
AFED 2B           |           DEC HL
AFEE 50           |           LD D,B
AFEF 4F           |           LD C,A
AFF0 50           |           LD D,B
AFF1 20 58        |           JR NZ,B04Bh
AFF3 59           |           LD E,C
AFF4 00           |           NOP
AFF5 FF           |           RST $38
AFF6 EB           |           EX DE,HL
AFF7 3F           |           CCF
AFF8 00           |           NOP
AFF9 00           |           NOP
AFFA 00           |           NOP
AFFB FF           |           RST $38
AFFC AA           |           XOR D
AFFD CC BB EE     |           CALL Z,EEBBh
B000 DD           |           *ILLEGAL*
B001 11 44 88     |           LD DE,8844h
B004 DD 77 FD     |           LD (IX+FDh),A
B007 34           |           INC (HL)
B008 12           |           LD (DE),A
B009 00           |           NOP
B00A C0           |           RET NZ
B00B 00           |           NOP
B00C 00           |           NOP
B00D 00           |           NOP
B00E 00           |           NOP
B00F 00           |           NOP
B010 00           |           NOP
B011 00           |           NOP
B012 00           |           NOP
B013 00           |           NOP
B014 00           |           NOP
B015 00           |           NOP
B016 00           |           NOP
B017 00           |           NOP
B018 00           |           NOP
B019 00           |           NOP
B01A 00           |           NOP
B01B 00           |           NOP
B01C 00           |           NOP
B01D 00           |           NOP
B01E 00           |           NOP
B01F 00           |           NOP
B020 00           |           NOP
B021 00           |           NOP
B022 00           |           NOP
B023 00           |           NOP
B024 00           |           NOP
B025 FF           |           RST $38
B026 28 00        |           JR Z,B028h
B028 00           |           NOP
B029 01 80 01     |           LD BC,0180h
B02C 80           |           ADD A,B
B02D 00           |           NOP
B02E 00           |           NOP
B02F 00           |           NOP
B030 00           |           NOP
B031 00           |           NOP
B032 00           |           NOP
B033 00           |           NOP
B034 00           |           NOP
B035 9F           |           SBC A,A
B036 F1           |           POP AF
B037 90           |           SUB A,B
B038 6F           |           LD L,A
B039 45           |           LD B,L
B03A 58           |           LD E,B
B03B 20 44        |           JR NZ,B081h
B03D 45           |           LD B,L
B03E 2C           |           INC L
B03F 48           |           LD C,B
B040 4C           |           LD C,H
B041 00           |           NOP
B042 FF           |           RST $38
B043 08           |           EX AF,AF'
B044 F1           |           POP AF
B045 C5           |           PUSH BC
B046 08           |           EX AF,AF'
B047 3F           |           CCF
B048 FF           |           RST $38
B049 AA           |           XOR D
B04A CC BB EE     |           CALL Z,EEBBh
B04D DD           |           *ILLEGAL*
B04E 11 44 88     |           LD DE,8844h
B051 DD 77 FD     |           LD (IX+FDh),A
B054 34           |           INC (HL)
B055 12           |           LD (DE),A
B056 0C           |           INC C
B057 88           |           ADC A,B
B058 00           |           NOP
B059 00           |           NOP
B05A 30 00        |           JR NC,B05Ch
B05C 00           |           NOP
B05D 00           |           NOP
B05E 00           |           NOP
B05F 00           |           NOP
B060 00           |           NOP
B061 00           |           NOP
B062 00           |           NOP
B063 00           |           NOP
B064 00           |           NOP
B065 00           |           NOP
B066 00           |           NOP
B067 00           |           NOP
B068 00           |           NOP
B069 00           |           NOP
B06A 00           |           NOP
B06B 00           |           NOP
B06C 00           |           NOP
B06D 00           |           NOP
B06E 00           |           NOP
B06F 00           |           NOP
B070 00           |           NOP
B071 00           |           NOP
B072 FF           |           RST $38
B073 A9           |           XOR C
B074 01 80 01     |           LD BC,0180h
B077 80           |           ADD A,B
B078 01 80 00     |           LD BC,0080h
B07B 00           |           NOP
B07C 00           |           NOP
B07D 00           |           NOP
B07E FF           |           RST $38
B07F 81           |           ADD A,C
B080 00           |           NOP
B081 00           |           NOP
B082 4C           |           LD C,H
B083 FA 32 A0     |           JP M,A032h
B086 45           |           LD B,L
B087 58           |           LD E,B
B088 20 41        |           JR NZ,B0CBh
B08A 46           |           LD B,(HL)
B08B 2C           |           INC L
B08C 41           |           LD B,C
B08D 46           |           LD B,(HL)
B08E 27           |           DAA
B08F 00           |           NOP
B090 FF           |           RST $38
B091 D9           |           EXX
B092 E1           |           POP HL
B093 C5           |           PUSH BC
B094 D9           |           EXX
B095 3F           |           CCF
B096 FF           |           RST $38
B097 AA           |           XOR D
B098 CC BB EE     |           CALL Z,EEBBh
B09B DD           |           *ILLEGAL*
B09C 11 44 88     |           LD DE,8844h
B09F DD 77 FD     |           LD (IX+FDh),A
B0A2 34           |           INC (HL)
B0A3 12           |           LD (DE),A
B0A4 0C           |           INC C
B0A5 88           |           ADC A,B
B0A6 00           |           NOP
B0A7 00           |           NOP
B0A8 30 00        |           JR NC,B0AAh
B0AA 00           |           NOP
B0AB 00           |           NOP
B0AC 00           |           NOP
B0AD 00           |           NOP
B0AE 00           |           NOP
B0AF 00           |           NOP
B0B0 00           |           NOP
B0B1 00           |           NOP
B0B2 00           |           NOP
B0B3 00           |           NOP
B0B4 00           |           NOP
B0B5 00           |           NOP
B0B6 00           |           NOP
B0B7 00           |           NOP
B0B8 00           |           NOP
B0B9 00           |           NOP
B0BA 00           |           NOP
B0BB 00           |           NOP
B0BC 00           |           NOP
B0BD 00           |           NOP
B0BE 00           |           NOP
B0BF 00           |           NOP
B0C0 FF           |           RST $38
B0C1 A9           |           XOR C
B0C2 01 80 01     |           LD BC,0180h
B0C5 80           |           ADD A,B
B0C6 01 80 00     |           LD BC,0080h
B0C9 00           |           NOP
B0CA 00           |           NOP
B0CB 00           |           NOP
B0CC 01 80 00     |           LD BC,0080h
B0CF 00           |           NOP
B0D0 B0           |           OR B
B0D1 D4 77 CD     |           CALL NC,CD77h
B0D4 45           |           LD B,L
B0D5 58           |           LD E,B
B0D6 58           |           LD E,B
B0D7 00           |           NOP
B0D8 FF           |           RST $38
B0D9 E3           |           EX (SP),HL
B0DA 3F           |           CCF
B0DB 00           |           NOP
B0DC 00           |           NOP
B0DD 00           |           NOP
B0DE FF           |           RST $38
B0DF AA           |           XOR D
B0E0 CC BB EE     |           CALL Z,EEBBh
B0E3 DD           |           *ILLEGAL*
B0E4 11 44 88     |           LD DE,8844h
B0E7 DD 77 FD     |           LD (IX+FDh),A
B0EA 34           |           INC (HL)
B0EB 12           |           LD (DE),A
B0EC 0C           |           INC C
B0ED 88           |           ADC A,B
B0EE 00           |           NOP
B0EF 00           |           NOP
B0F0 00           |           NOP
B0F1 00           |           NOP
B0F2 00           |           NOP
B0F3 00           |           NOP
B0F4 00           |           NOP
B0F5 00           |           NOP
B0F6 00           |           NOP
B0F7 00           |           NOP
B0F8 00           |           NOP
B0F9 00           |           NOP
B0FA 00           |           NOP
B0FB 00           |           NOP
B0FC 00           |           NOP
B0FD 00           |           NOP
B0FE 00           |           NOP
B0FF 00           |           NOP
B100 00           |           NOP
B101 00           |           NOP
B102 00           |           NOP
B103 00           |           NOP
B104 00           |           NOP
B105 00           |           NOP
B106 00           |           NOP
B107 00           |           NOP
B108 FF           |           RST $38
B109 28 00        |           JR Z,B10Bh
B10B 00           |           NOP
B10C 00           |           NOP
B10D 00           |           NOP
B10E 01 80 00     |           LD BC,0080h
B111 00           |           NOP
B112 00           |           NOP
B113 00           |           NOP
B114 01 80 00     |           LD BC,0080h
B117 00           |           NOP
B118 9F           |           SBC A,A
B119 F1           |           POP AF
B11A 90           |           SUB A,B
B11B 6F           |           LD L,A
B11C 45           |           LD B,L
B11D 58           |           LD E,B
B11E 20 28        |           JR NZ,B148h
B120 53           |           LD D,E
B121 50           |           LD D,B
B122 29           |           ADD HL,HL
B123 2C           |           INC L
B124 48           |           LD C,B
B125 4C           |           LD C,H
B126 00           |           NOP
B127 FF           |           RST $38
B128 DD E3        |           EX (SP),IX
B12A 3F           |           CCF
B12B 00           |           NOP
B12C 00           |           NOP
B12D FF           |           RST $38
B12E AA           |           XOR D
B12F CC BB EE     |           CALL Z,EEBBh
B132 DD           |           *ILLEGAL*
B133 11 44 88     |           LD DE,8844h
B136 DD 77 FD     |           LD (IX+FDh),A
B139 34           |           INC (HL)
B13A 12           |           LD (DE),A
B13B 0C           |           INC C
B13C 88           |           ADC A,B
B13D 20 00        |           JR NZ,B13Fh
B13F 00           |           NOP
B140 00           |           NOP
B141 00           |           NOP
B142 00           |           NOP
B143 00           |           NOP
B144 00           |           NOP
B145 00           |           NOP
B146 00           |           NOP
B147 00           |           NOP
B148 00           |           NOP
B149 00           |           NOP
B14A 00           |           NOP
B14B 00           |           NOP
B14C 00           |           NOP
B14D 00           |           NOP
B14E 00           |           NOP
B14F 00           |           NOP
B150 00           |           NOP
B151 00           |           NOP
B152 00           |           NOP
B153 00           |           NOP
B154 00           |           NOP
B155 00           |           NOP
B156 00           |           NOP
B157 FF           |           RST $38
B158 28 00        |           JR Z,B15Ah
B15A 00           |           NOP
B15B 00           |           NOP
B15C 00           |           NOP
B15D 00           |           NOP
B15E 00           |           NOP
B15F 01 80 01     |           LD BC,0180h
B162 80           |           ADD A,B
B163 01 80 00     |           LD BC,0080h
B166 00           |           NOP
B167 1E B6        |           LD E,B6h
B169 4F           |           LD C,A
B16A 30 45        |           JR NC,B1B1h
B16C 58           |           LD E,B
B16D 20 28        |           JR NZ,B197h
B16F 53           |           LD D,E
B170 50           |           LD D,B
B171 29           |           ADD HL,HL
B172 2C           |           INC L
B173 58           |           LD E,B
B174 59           |           LD E,C
B175 00           |           NOP
B176 FF           |           RST $38
B177 40           |           LD B,B
B178 3F           |           CCF
B179 00           |           NOP
B17A 00           |           NOP
B17B 00           |           NOP
B17C FF           |           RST $38
B17D AA           |           XOR D
B17E CC BB EE     |           CALL Z,EEBBh
B181 DD           |           *ILLEGAL*
B182 0C           |           INC C
B183 88           |           ADC A,B
B184 88           |           ADC A,B
B185 DD 77 FD     |           LD (IX+FDh),A
B188 34           |           INC (HL)
B189 12           |           LD (DE),A
B18A 00           |           NOP
B18B C0           |           RET NZ
B18C 3F           |           CCF
B18D 00           |           NOP
B18E 00           |           NOP
B18F 00           |           NOP
B190 00           |           NOP
B191 00           |           NOP
B192 00           |           NOP
B193 00           |           NOP
B194 00           |           NOP
B195 00           |           NOP
B196 00           |           NOP
B197 00           |           NOP
B198 00           |           NOP
B199 00           |           NOP
B19A 00           |           NOP
B19B 00           |           NOP
B19C 00           |           NOP
B19D 00           |           NOP
B19E 00           |           NOP
B19F 00           |           NOP
B1A0 00           |           NOP
B1A1 00           |           NOP
B1A2 00           |           NOP
B1A3 00           |           NOP
B1A4 00           |           NOP
B1A5 00           |           NOP
B1A6 FF           |           RST $38
B1A7 29           |           ADD HL,HL
B1A8 01 80 01     |           LD BC,0180h
B1AB 80           |           ADD A,B
B1AC 01 00 00     |           LD BC,0000h
B1AF 00           |           NOP
B1B0 00           |           NOP
B1B1 00           |           NOP
B1B2 01 80 00     |           LD BC,0080h
B1B5 00           |           NOP
B1B6 BC           |           CP H
B1B7 21 EB 04     |           LD HL,04EBh
B1BA 4C           |           LD C,H
B1BB 44           |           LD B,H
B1BC 20 5B        |           JR NZ,B219h
B1BE 52           |           LD D,D
B1BF 2C           |           INC L
B1C0 28 48        |           JR Z,B20Ah
B1C2 4C           |           LD C,H
B1C3 29           |           ADD HL,HL
B1C4 5D           |           LD E,L
B1C5 2C           |           INC L
B1C6 5B           |           LD E,E
B1C7 52           |           LD D,D
B1C8 2C           |           INC L
B1C9 28 48        |           JR Z,B213h
B1CB 4C           |           LD C,H
B1CC 29           |           ADD HL,HL
B1CD 5D           |           LD E,L
B1CE 00           |           NOP
B1CF FF           |           RST $38
B1D0 DD           |           *ILLEGAL*
B1D1 40           |           LD B,B
B1D2 3F           |           CCF
B1D3 00           |           NOP
B1D4 00           |           NOP
B1D5 FF           |           RST $38
B1D6 AA           |           XOR D
B1D7 CC BB EE     |           CALL Z,EEBBh
B1DA DD           |           *ILLEGAL*
B1DB 11 44 CD     |           LD DE,CD44h
B1DE 87           |           ADD A,A
B1DF CD 87 34     |           CALL 3487h
B1E2 12           |           LD (DE),A
B1E3 00           |           NOP
B1E4 C0           |           RET NZ
B1E5 20 3F        |           JR NZ,B226h
B1E7 00           |           NOP
B1E8 00           |           NOP
B1E9 00           |           NOP
B1EA 00           |           NOP
B1EB 00           |           NOP
B1EC 00           |           NOP
B1ED 00           |           NOP
B1EE 00           |           NOP
B1EF 00           |           NOP
B1F0 00           |           NOP
B1F1 00           |           NOP
B1F2 00           |           NOP
B1F3 00           |           NOP
B1F4 00           |           NOP
B1F5 00           |           NOP
B1F6 00           |           NOP
B1F7 00           |           NOP
B1F8 00           |           NOP
B1F9 00           |           NOP
B1FA 00           |           NOP
B1FB 00           |           NOP
B1FC 00           |           NOP
B1FD 00           |           NOP
B1FE 00           |           NOP
B1FF FF           |           RST $38
B200 29           |           ADD HL,HL
B201 01 80 01     |           LD BC,0180h
B204 80           |           ADD A,B
B205 01 80 01     |           LD BC,0180h
B208 00           |           NOP
B209 01 00 01     |           LD BC,0100h
B20C 80           |           ADD A,B
B20D 00           |           NOP
B20E 00           |           NOP
B20F 88           |           ADC A,B
B210 9A           |           SBC A,D
B211 70           |           LD (HL),B
B212 F6 4C        |           OR 4Ch
B214 44           |           LD B,H
B215 20 5B        |           JR NZ,B272h
B217 58           |           LD E,B
B218 2C           |           INC L
B219 28 58        |           JR Z,B273h
B21B 59           |           LD E,C
B21C 29           |           ADD HL,HL
B21D 5D           |           LD E,L
B21E 2C           |           INC L
B21F 5B           |           LD E,E
B220 58           |           LD E,B
B221 2C           |           INC L
B222 28 58        |           JR Z,B27Ch
B224 59           |           LD E,C
B225 29           |           ADD HL,HL
B226 5D           |           LD E,L
B227 00           |           NOP
B228 FF           |           RST $38
B229 DD 46 80     |           LD B,(IX+80h)
B22C 3F           |           CCF
B22D 00           |           NOP
B22E FF           |           RST $38
B22F AA           |           XOR D
B230 CC BB EE     |           CALL Z,EEBBh
B233 DD           |           *ILLEGAL*
B234 11 44 8C     |           LD DE,8C44h
B237 88           |           ADC A,B
B238 8C           |           ADC A,H
B239 88           |           ADC A,B
B23A 34           |           INC (HL)
B23B 12           |           LD (DE),A
B23C 00           |           NOP
B23D C0           |           RET NZ
B23E 20 38        |           JR NZ,B278h
B240 00           |           NOP
B241 00           |           NOP
B242 00           |           NOP
B243 00           |           NOP
B244 00           |           NOP
B245 00           |           NOP
B246 00           |           NOP
B247 00           |           NOP
B248 00           |           NOP
B249 00           |           NOP
B24A 00           |           NOP
B24B 00           |           NOP
B24C 00           |           NOP
B24D 00           |           NOP
B24E 00           |           NOP
B24F 00           |           NOP
B250 00           |           NOP
B251 00           |           NOP
B252 00           |           NOP
B253 00           |           NOP
B254 00           |           NOP
B255 01 00 00     |           LD BC,0000h
B258 FF           |           RST $38
B259 29           |           ADD HL,HL
B25A 01 80 01     |           LD BC,0180h
B25D 80           |           ADD A,B
B25E 01 80 01     |           LD BC,0180h
B261 00           |           NOP
B262 01 00 01     |           LD BC,0100h
B265 80           |           ADD A,B
B266 00           |           NOP
B267 00           |           NOP
B268 A2           |           AND D
B269 93           |           SUB A,E
B26A 18 C8        |           JR B234h
B26C 4C           |           LD C,H
B26D 44           |           LD B,H
B26E 20 52        |           JR NZ,B2C2h
B270 2C           |           INC L
B271 28 58        |           JR Z,B2CBh
B273 59           |           LD E,C
B274 29           |           ADD HL,HL
B275 00           |           NOP
B276 FF           |           RST $38
B277 DD 70 7E     |           LD (IX+7Eh),B
B27A 3F           |           CCF
B27B 00           |           NOP
B27C FF           |           RST $38
B27D AA           |           XOR D
B27E CC BB EE     |           CALL Z,EEBBh
B281 DD           |           *ILLEGAL*
B282 11 44 8E     |           LD DE,8E44h
B285 87           |           ADD A,A
B286 8E           |           ADC A,(HL)
B287 87           |           ADD A,A
B288 34           |           INC (HL)
B289 12           |           LD (DE),A
B28A 00           |           NOP
B28B C0           |           RET NZ
B28C 20 07        |           JR NZ,B295h
B28E 00           |           NOP
B28F 00           |           NOP
B290 00           |           NOP
B291 00           |           NOP
B292 00           |           NOP
B293 00           |           NOP
B294 00           |           NOP
B295 00           |           NOP
B296 00           |           NOP
B297 00           |           NOP
B298 00           |           NOP
B299 00           |           NOP
B29A 00           |           NOP
B29B 00           |           NOP
B29C 00           |           NOP
B29D 00           |           NOP
B29E 00           |           NOP
B29F 00           |           NOP
B2A0 00           |           NOP
B2A1 00           |           NOP
B2A2 00           |           NOP
B2A3 01 00 00     |           LD BC,0000h
B2A6 FF           |           RST $38
B2A7 29           |           ADD HL,HL
B2A8 01 80 01     |           LD BC,0180h
B2AB 80           |           ADD A,B
B2AC 01 80 01     |           LD BC,0180h
B2AF 00           |           NOP
B2B0 01 00 01     |           LD BC,0100h
B2B3 80           |           ADD A,B
B2B4 00           |           NOP
B2B5 00           |           NOP
B2B6 A8           |           XOR B
B2B7 1C           |           INC E
B2B8 AD           |           XOR L
B2B9 03           |           INC BC
B2BA 4C           |           LD C,H
B2BB 44           |           LD B,H
B2BC 20 28        |           JR NZ,B2E6h
B2BE 58           |           LD E,B
B2BF 59           |           LD E,C
B2C0 29           |           ADD HL,HL
B2C1 2C           |           INC L
B2C2 52           |           LD D,D
B2C3 00           |           NOP
B2C4 FF           |           RST $38
B2C5 06 00        |           LD B,00h
B2C7 3F           |           CCF
B2C8 00           |           NOP
B2C9 00           |           NOP
B2CA FF           |           RST $38
B2CB AA           |           XOR D
B2CC CC BB EE     |           CALL Z,EEBBh
B2CF DD           |           *ILLEGAL*
B2D0 0C           |           INC C
B2D1 88           |           ADC A,B
B2D2 88           |           ADC A,B
B2D3 DD 77 FD     |           LD (IX+FDh),A
B2D6 34           |           INC (HL)
B2D7 12           |           LD (DE),A
B2D8 00           |           NOP
B2D9 C0           |           RET NZ
B2DA 38 00        |           JR C,B2DCh
B2DC 00           |           NOP
B2DD 00           |           NOP
B2DE 00           |           NOP
B2DF 00           |           NOP
B2E0 00           |           NOP
B2E1 00           |           NOP
B2E2 00           |           NOP
B2E3 00           |           NOP
B2E4 00           |           NOP
B2E5 00           |           NOP
B2E6 00           |           NOP
B2E7 00           |           NOP
B2E8 00           |           NOP
B2E9 00           |           NOP
B2EA 00           |           NOP
B2EB 00           |           NOP
B2EC 00           |           NOP
B2ED 00           |           NOP
B2EE 00           |           NOP
B2EF 00           |           NOP
B2F0 FF           |           RST $38
B2F1 00           |           NOP
B2F2 00           |           NOP
B2F3 00           |           NOP
B2F4 FF           |           RST $38
B2F5 28 00        |           JR Z,B2F7h
B2F7 00           |           NOP
B2F8 00           |           NOP
B2F9 00           |           NOP
B2FA 00           |           NOP
B2FB 00           |           NOP
B2FC 00           |           NOP
B2FD 00           |           NOP
B2FE 00           |           NOP
B2FF 00           |           NOP
B300 00           |           NOP
B301 00           |           NOP
B302 00           |           NOP
B303 00           |           NOP
B304 8B           |           ADC A,E
B305 D6 D3        |           SUB A,D3h
B307 CD 4C 44     |           CALL 444Ch
B30A 20 5B        |           JR NZ,B367h
B30C 52           |           LD D,D
B30D 2C           |           INC L
B30E 28 48        |           JR Z,B358h
B310 4C           |           LD C,H
B311 29           |           ADD HL,HL
B312 5D           |           LD E,L
B313 2C           |           INC L
B314 4E           |           LD C,(HL)
B315 00           |           NOP
B316 FF           |           RST $38
B317 DD 26 00     |           LD IXH,00h
B31A 3F           |           CCF
B31B 00           |           NOP
B31C FF           |           RST $38
B31D AA           |           XOR D
B31E CC BB EE     |           CALL Z,EEBBh
B321 DD           |           *ILLEGAL*
B322 11 44 88     |           LD DE,8844h
B325 DD 77 FD     |           LD (IX+FDh),A
B328 34           |           INC (HL)
B329 12           |           LD (DE),A
B32A 00           |           NOP
B32B C0           |           RET NZ
B32C 20 08        |           JR NZ,B336h
B32E 00           |           NOP
B32F 00           |           NOP
B330 00           |           NOP
B331 00           |           NOP
B332 00           |           NOP
B333 00           |           NOP
B334 00           |           NOP
B335 00           |           NOP
B336 00           |           NOP
B337 00           |           NOP
B338 00           |           NOP
B339 00           |           NOP
B33A 00           |           NOP
B33B 00           |           NOP
B33C 00           |           NOP
B33D 00           |           NOP
B33E 00           |           NOP
B33F 00           |           NOP
B340 00           |           NOP
B341 00           |           NOP
B342 00           |           NOP
B343 FF           |           RST $38
B344 00           |           NOP
B345 00           |           NOP
B346 FF           |           RST $38
B347 28 00        |           JR Z,B349h
B349 00           |           NOP
B34A 00           |           NOP
B34B 00           |           NOP
B34C 00           |           NOP
B34D 00           |           NOP
B34E 00           |           NOP
B34F 00           |           NOP
B350 00           |           NOP
B351 00           |           NOP
B352 00           |           NOP
B353 00           |           NOP
B354 00           |           NOP
B355 00           |           NOP
B356 6F           |           LD L,A
B357 CF           |           RST $08
B358 31 E3 4C     |           LD SP,4CE3h
B35B 44           |           LD B,H
B35C 20 58        |           JR NZ,B3B6h
B35E 2C           |           INC L
B35F 4E           |           LD C,(HL)
B360 00           |           NOP
B361 FF           |           RST $38
B362 DD           |           *ILLEGAL*
B363 36 00        |           LD (HL),00h
B365 00           |           NOP
B366 3F           |           CCF
B367 FF           |           RST $38
B368 AA           |           XOR D
B369 CC BB EE     |           CALL Z,EEBBh
B36C DD           |           *ILLEGAL*
B36D 11 44 0C     |           LD DE,0C44h
B370 88           |           ADC A,B
B371 0C           |           INC C
B372 88           |           ADC A,B
B373 34           |           INC (HL)
B374 12           |           LD (DE),A
B375 00           |           NOP
B376 C0           |           RET NZ
B377 20 00        |           JR NZ,B379h
B379 00           |           NOP
B37A 00           |           NOP
B37B 00           |           NOP
B37C 00           |           NOP
B37D 00           |           NOP
B37E 00           |           NOP
B37F 00           |           NOP
B380 00           |           NOP
B381 00           |           NOP
B382 00           |           NOP
B383 00           |           NOP
B384 00           |           NOP
B385 00           |           NOP
B386 00           |           NOP
B387 00           |           NOP
B388 00           |           NOP
B389 00           |           NOP
B38A 00           |           NOP
B38B 00           |           NOP
B38C 00           |           NOP
B38D 00           |           NOP
B38E 01 FF 00     |           LD BC,00FFh
B391 FF           |           RST $38
B392 28 00        |           JR Z,B394h
B394 00           |           NOP
B395 00           |           NOP
B396 00           |           NOP
B397 00           |           NOP
B398 00           |           NOP
B399 01 00 01     |           LD BC,0100h
B39C 00           |           NOP
B39D 00           |           NOP
B39E 00           |           NOP
B39F 00           |           NOP
B3A0 00           |           NOP
B3A1 16 F3        |           LD D,F3h
B3A3 E3           |           EX (SP),HL
B3A4 AF           |           XOR A
B3A5 4C           |           LD C,H
B3A6 44           |           LD B,H
B3A7 20 28        |           JR NZ,B3D1h
B3A9 58           |           LD E,B
B3AA 59           |           LD E,C
B3AB 29           |           ADD HL,HL
B3AC 2C           |           INC L
B3AD 4E           |           LD C,(HL)
B3AE 00           |           NOP
B3AF FF           |           RST $38
B3B0 0A           |           LD A,(BC)
B3B1 3F           |           CCF
B3B2 00           |           NOP
B3B3 00           |           NOP
B3B4 00           |           NOP
B3B5 FF           |           RST $38
B3B6 AA           |           XOR D
B3B7 0C           |           INC C
B3B8 88           |           ADC A,B
B3B9 0C           |           INC C
B3BA 88           |           ADC A,B
B3BB 11 44 88     |           LD DE,8844h
B3BE DD 77 FD     |           LD (IX+FDh),A
B3C1 34           |           INC (HL)
B3C2 12           |           LD (DE),A
B3C3 00           |           NOP
B3C4 C0           |           RET NZ
B3C5 10 00        |           DJNZ B3C7h
B3C7 00           |           NOP
B3C8 00           |           NOP
B3C9 00           |           NOP
B3CA 00           |           NOP
B3CB 00           |           NOP
B3CC 01 00 01     |           LD BC,0100h
B3CF 00           |           NOP
B3D0 00           |           NOP
B3D1 00           |           NOP
B3D2 00           |           NOP
B3D3 00           |           NOP
B3D4 00           |           NOP
B3D5 00           |           NOP
B3D6 00           |           NOP
B3D7 00           |           NOP
B3D8 00           |           NOP
B3D9 00           |           NOP
B3DA 00           |           NOP
B3DB 00           |           NOP
B3DC 00           |           NOP
B3DD 00           |           NOP
B3DE 00           |           NOP
B3DF FF           |           RST $38
B3E0 28 00        |           JR Z,B3E2h
B3E2 00           |           NOP
B3E3 00           |           NOP
B3E4 00           |           NOP
B3E5 00           |           NOP
B3E6 00           |           NOP
B3E7 00           |           NOP
B3E8 00           |           NOP
B3E9 00           |           NOP
B3EA 00           |           NOP
B3EB 00           |           NOP
B3EC 00           |           NOP
B3ED 00           |           NOP
B3EE 00           |           NOP
B3EF 51           |           LD D,C
B3F0 95           |           SUB A,L
B3F1 29           |           ADD HL,HL
B3F2 1D           |           DEC E
B3F3 4C           |           LD C,H
B3F4 44           |           LD B,H
B3F5 20 41        |           JR NZ,B438h
B3F7 2C           |           INC L
B3F8 28 5B        |           JR Z,B455h
B3FA 42           |           LD B,D
B3FB 43           |           LD B,E
B3FC 2C           |           INC L
B3FD 44           |           LD B,H
B3FE 45           |           LD B,L
B3FF 5D           |           LD E,L
B400 29           |           ADD HL,HL
B401 00           |           NOP
B402 FF           |           RST $38
B403 02           |           LD (BC),A
B404 3F           |           CCF
B405 00           |           NOP
B406 00           |           NOP
B407 00           |           NOP
B408 FF           |           RST $38
B409 AA           |           XOR D
B40A 0C           |           INC C
B40B 88           |           ADC A,B
B40C 0C           |           INC C
B40D 88           |           ADC A,B
B40E 11 44 88     |           LD DE,8844h
B411 DD 77 FD     |           LD (IX+FDh),A
B414 34           |           INC (HL)
B415 12           |           LD (DE),A
B416 00           |           NOP
B417 C0           |           RET NZ
B418 10 00        |           DJNZ B41Ah
B41A 00           |           NOP
B41B 00           |           NOP
B41C 00           |           NOP
B41D 00           |           NOP
B41E 01 01 00     |           LD BC,0001h
B421 01 00 00     |           LD BC,0000h
B424 00           |           NOP
B425 00           |           NOP
B426 00           |           NOP
B427 00           |           NOP
B428 00           |           NOP
B429 00           |           NOP
B42A 00           |           NOP
B42B 00           |           NOP
B42C 00           |           NOP
B42D 00           |           NOP
B42E 00           |           NOP
B42F 00           |           NOP
B430 00           |           NOP
B431 00           |           NOP
B432 FF           |           RST $38
B433 28 00        |           JR Z,B435h
B435 00           |           NOP
B436 00           |           NOP
B437 00           |           NOP
B438 00           |           NOP
B439 00           |           NOP
B43A 00           |           NOP
B43B 00           |           NOP
B43C 00           |           NOP
B43D 00           |           NOP
B43E 00           |           NOP
B43F 00           |           NOP
B440 00           |           NOP
B441 00           |           NOP
B442 FB           |           EI
B443 8C           |           ADC A,H
B444 6D           |           LD L,L
B445 82           |           ADD A,D
B446 4C           |           LD C,H
B447 44           |           LD B,H
B448 20 28        |           JR NZ,B472h
B44A 5B           |           LD E,E
B44B 42           |           LD B,D
B44C 43           |           LD B,E
B44D 2C           |           INC L
B44E 44           |           LD B,H
B44F 45           |           LD B,L
B450 5D           |           LD E,L
B451 29           |           ADD HL,HL
B452 2C           |           INC L
B453 41           |           LD B,C
B454 00           |           NOP
B455 FF           |           RST $38
B456 3A 0C 88     |           LD A,(880Ch)
B459 3F           |           CCF
B45A 00           |           NOP
B45B FF           |           RST $38
B45C AA           |           XOR D
B45D CC BB EE     |           CALL Z,EEBBh
B460 DD           |           *ILLEGAL*
B461 11 44 88     |           LD DE,8844h
B464 DD 77 FD     |           LD (IX+FDh),A
B467 34           |           INC (HL)
B468 12           |           LD (DE),A
B469 00           |           NOP
B46A C0           |           RET NZ
B46B 00           |           NOP
B46C 01 00 00     |           LD BC,0000h
B46F 00           |           NOP
B470 00           |           NOP
B471 00           |           NOP
B472 00           |           NOP
B473 00           |           NOP
B474 00           |           NOP
B475 00           |           NOP
B476 00           |           NOP
B477 00           |           NOP
B478 00           |           NOP
B479 00           |           NOP
B47A 00           |           NOP
B47B 00           |           NOP
B47C 00           |           NOP
B47D 00           |           NOP
B47E 00           |           NOP
B47F 00           |           NOP
B480 00           |           NOP
B481 00           |           NOP
B482 00           |           NOP
B483 00           |           NOP
B484 00           |           NOP
B485 FF           |           RST $38
B486 28 00        |           JR Z,B488h
B488 00           |           NOP
B489 00           |           NOP
B48A 00           |           NOP
B48B 00           |           NOP
B48C 00           |           NOP
B48D 00           |           NOP
B48E 00           |           NOP
B48F 00           |           NOP
B490 00           |           NOP
B491 00           |           NOP
B492 00           |           NOP
B493 00           |           NOP
B494 00           |           NOP
B495 4F           |           LD C,A
B496 9C           |           SBC A,H
B497 72           |           LD (HL),D
B498 61           |           LD H,C
B499 4C           |           LD C,H
B49A 44           |           LD B,H
B49B 20 41        |           JR NZ,B4DEh
B49D 2C           |           INC L
B49E 28 4E        |           JR Z,B4EEh
B4A0 4E           |           LD C,(HL)
B4A1 29           |           ADD HL,HL
B4A2 00           |           NOP
B4A3 FF           |           RST $38
B4A4 32 0C 88     |           LD (880Ch),A
B4A7 3F           |           CCF
B4A8 00           |           NOP
B4A9 FF           |           RST $38
B4AA AA           |           XOR D
B4AB CC BB EE     |           CALL Z,EEBBh
B4AE DD           |           *ILLEGAL*
B4AF 11 44 88     |           LD DE,8844h
B4B2 DD 77 FD     |           LD (IX+FDh),A
B4B5 34           |           INC (HL)
B4B6 12           |           LD (DE),A
B4B7 00           |           NOP
B4B8 C0           |           RET NZ
B4B9 00           |           NOP
B4BA 01 00 00     |           LD BC,0000h
B4BD 00           |           NOP
B4BE 00           |           NOP
B4BF 01 00 00     |           LD BC,0000h
B4C2 00           |           NOP
B4C3 00           |           NOP
B4C4 00           |           NOP
B4C5 00           |           NOP
B4C6 00           |           NOP
B4C7 00           |           NOP
B4C8 00           |           NOP
B4C9 00           |           NOP
B4CA 00           |           NOP
B4CB 00           |           NOP
B4CC 00           |           NOP
B4CD 00           |           NOP
B4CE 00           |           NOP
B4CF 00           |           NOP
B4D0 00           |           NOP
B4D1 00           |           NOP
B4D2 00           |           NOP
B4D3 FF           |           RST $38
B4D4 28 00        |           JR Z,B4D6h
B4D6 00           |           NOP
B4D7 00           |           NOP
B4D8 00           |           NOP
B4D9 00           |           NOP
B4DA 00           |           NOP
B4DB 00           |           NOP
B4DC 00           |           NOP
B4DD 00           |           NOP
B4DE 00           |           NOP
B4DF 00           |           NOP
B4E0 00           |           NOP
B4E1 00           |           NOP
B4E2 00           |           NOP
B4E3 2C           |           INC L
B4E4 17           |           RLA
B4E5 4B           |           LD C,E
B4E6 9F           |           SBC A,A
B4E7 4C           |           LD C,H
B4E8 44           |           LD B,H
B4E9 20 28        |           JR NZ,B513h
B4EB 4E           |           LD C,(HL)
B4EC 4E           |           LD C,(HL)
B4ED 29           |           ADD HL,HL
B4EE 2C           |           INC L
B4EF 41           |           LD B,C
B4F0 00           |           NOP
B4F1 FF           |           RST $38
B4F2 01 00 00     |           LD BC,0000h
B4F5 3F           |           CCF
B4F6 00           |           NOP
B4F7 FF           |           RST $38
B4F8 AA           |           XOR D
B4F9 CC BB EE     |           CALL Z,EEBBh
B4FC DD           |           *ILLEGAL*
B4FD 11 44 88     |           LD DE,8844h
B500 DD 77 FD     |           LD (IX+FDh),A
B503 34           |           INC (HL)
B504 12           |           LD (DE),A
B505 00           |           NOP
B506 C0           |           RET NZ
B507 30 00        |           JR NC,B509h
B509 00           |           NOP
B50A 00           |           NOP
B50B 00           |           NOP
B50C 00           |           NOP
B50D 00           |           NOP
B50E 00           |           NOP
B50F 00           |           NOP
B510 00           |           NOP
B511 00           |           NOP
B512 00           |           NOP
B513 00           |           NOP
B514 00           |           NOP
B515 00           |           NOP
B516 00           |           NOP
B517 00           |           NOP
B518 00           |           NOP
B519 00           |           NOP
B51A 00           |           NOP
B51B 00           |           NOP
B51C 00           |           NOP
B51D FF           |           RST $38
B51E FF           |           RST $38
B51F 00           |           NOP
B520 00           |           NOP
B521 FF           |           RST $38
B522 28 00        |           JR Z,B524h
B524 00           |           NOP
B525 00           |           NOP
B526 00           |           NOP
B527 00           |           NOP
B528 00           |           NOP
B529 00           |           NOP
B52A 00           |           NOP
B52B 00           |           NOP
B52C 00           |           NOP
B52D 00           |           NOP
B52E 00           |           NOP
B52F 00           |           NOP
B530 00           |           NOP
B531 91           |           SUB A,C
B532 A4           |           AND H
B533 44           |           LD B,H
B534 F8           |           RET M
B535 4C           |           LD C,H
B536 44           |           LD B,H
B537 20 52        |           JR NZ,B58Bh
B539 52           |           LD D,D
B53A 2C           |           INC L
B53B 4E           |           LD C,(HL)
B53C 4E           |           LD C,(HL)
B53D 00           |           NOP
B53E FF           |           RST $38
B53F DD 21 00 00  |           LD IX,0000h
B543 3F           |           CCF
B544 FF           |           RST $38
B545 AA           |           XOR D
B546 CC BB EE     |           CALL Z,EEBBh
B549 DD           |           *ILLEGAL*
B54A 11 44 88     |           LD DE,8844h
B54D DD 77 FD     |           LD (IX+FDh),A
B550 34           |           INC (HL)
B551 12           |           LD (DE),A
B552 00           |           NOP
B553 C0           |           RET NZ
B554 20 00        |           JR NZ,B556h
B556 00           |           NOP
B557 00           |           NOP
B558 00           |           NOP
B559 00           |           NOP
B55A 00           |           NOP
B55B 00           |           NOP
B55C 00           |           NOP
B55D 00           |           NOP
B55E 00           |           NOP
B55F 00           |           NOP
B560 00           |           NOP
B561 00           |           NOP
B562 00           |           NOP
B563 00           |           NOP
B564 00           |           NOP
B565 00           |           NOP
B566 00           |           NOP
B567 00           |           NOP
B568 00           |           NOP
B569 00           |           NOP
B56A 00           |           NOP
B56B FF           |           RST $38
B56C FF           |           RST $38
B56D 00           |           NOP
B56E FF           |           RST $38
B56F 28 00        |           JR Z,B571h
B571 00           |           NOP
B572 00           |           NOP
B573 00           |           NOP
B574 00           |           NOP
B575 00           |           NOP
B576 00           |           NOP
B577 00           |           NOP
B578 00           |           NOP
B579 00           |           NOP
B57A 00           |           NOP
B57B 00           |           NOP
B57C 00           |           NOP
B57D 00           |           NOP
B57E 96           |           SUB A,(HL)
B57F 71           |           LD (HL),C
B580 DE 69        |           SBC A,69h
B582 4C           |           LD C,H
B583 44           |           LD B,H
B584 20 58        |           JR NZ,B5DEh
B586 59           |           LD E,C
B587 2C           |           INC L
B588 4E           |           LD C,(HL)
B589 4E           |           LD C,(HL)
B58A 00           |           NOP
B58B FF           |           RST $38
B58C 2A 0C 88     |           LD HL,(880Ch)
B58F 3F           |           CCF
B590 00           |           NOP
B591 FF           |           RST $38
B592 AA           |           XOR D
B593 CC BB EE     |           CALL Z,EEBBh
B596 DD           |           *ILLEGAL*
B597 11 44 88     |           LD DE,8844h
B59A DD 77 FD     |           LD (IX+FDh),A
B59D 34           |           INC (HL)
B59E 12           |           LD (DE),A
B59F 00           |           NOP
B5A0 C0           |           RET NZ
B5A1 00           |           NOP
B5A2 00           |           NOP
B5A3 00           |           NOP
B5A4 00           |           NOP
B5A5 00           |           NOP
B5A6 00           |           NOP
B5A7 00           |           NOP
B5A8 00           |           NOP
B5A9 00           |           NOP
B5AA 00           |           NOP
B5AB 00           |           NOP
B5AC 00           |           NOP
B5AD 00           |           NOP
B5AE 00           |           NOP
B5AF 00           |           NOP
B5B0 00           |           NOP
B5B1 00           |           NOP
B5B2 00           |           NOP
B5B3 00           |           NOP
B5B4 00           |           NOP
B5B5 00           |           NOP
B5B6 00           |           NOP
B5B7 00           |           NOP
B5B8 00           |           NOP
B5B9 00           |           NOP
B5BA 00           |           NOP
B5BB FF           |           RST $38
B5BC 28 00        |           JR Z,B5BEh
B5BE 00           |           NOP
B5BF 00           |           NOP
B5C0 00           |           NOP
B5C1 00           |           NOP
B5C2 00           |           NOP
B5C3 00           |           NOP
B5C4 00           |           NOP
B5C5 00           |           NOP
B5C6 00           |           NOP
B5C7 01 80 00     |           LD BC,0080h
B5CA 00           |           NOP
B5CB 70           |           LD (HL),B
B5CC 49           |           LD C,C
B5CD EE 1E        |           XOR 1Eh
B5CF 4C           |           LD C,H
B5D0 44           |           LD B,H
B5D1 20 48        |           JR NZ,B61Bh
B5D3 4C           |           LD C,H
B5D4 2C           |           INC L
B5D5 28 4E        |           JR Z,B625h
B5D7 4E           |           LD C,(HL)
B5D8 29           |           ADD HL,HL
B5D9 00           |           NOP
B5DA FF           |           RST $38
B5DB DD 2A 0C 88  |           LD IX,(880Ch)
B5DF 3F           |           CCF
B5E0 FF           |           RST $38
B5E1 AA           |           XOR D
B5E2 CC BB EE     |           CALL Z,EEBBh
B5E5 DD           |           *ILLEGAL*
B5E6 11 44 88     |           LD DE,8844h
B5E9 DD 77 FD     |           LD (IX+FDh),A
B5EC 34           |           INC (HL)
B5ED 12           |           LD (DE),A
B5EE 00           |           NOP
B5EF C0           |           RET NZ
B5F0 20 00        |           JR NZ,B5F2h
B5F2 00           |           NOP
B5F3 00           |           NOP
B5F4 00           |           NOP
B5F5 00           |           NOP
B5F6 00           |           NOP
B5F7 00           |           NOP
B5F8 00           |           NOP
B5F9 00           |           NOP
B5FA 00           |           NOP
B5FB 00           |           NOP
B5FC 00           |           NOP
B5FD 00           |           NOP
B5FE 00           |           NOP
B5FF 00           |           NOP
B600 00           |           NOP
B601 00           |           NOP
B602 00           |           NOP
B603 00           |           NOP
B604 00           |           NOP
B605 00           |           NOP
B606 00           |           NOP
B607 00           |           NOP
B608 00           |           NOP
B609 00           |           NOP
B60A FF           |           RST $38
B60B 28 00        |           JR Z,B60Dh
B60D 00           |           NOP
B60E 00           |           NOP
B60F 00           |           NOP
B610 00           |           NOP
B611 00           |           NOP
B612 00           |           NOP
B613 00           |           NOP
B614 00           |           NOP
B615 00           |           NOP
B616 01 80 00     |           LD BC,0080h
B619 00           |           NOP
B61A AF           |           XOR A
B61B 31 1F 28     |           LD SP,281Fh
B61E 4C           |           LD C,H
B61F 44           |           LD B,H
B620 20 58        |           JR NZ,B67Ah
B622 59           |           LD E,C
B623 2C           |           INC L
B624 28 4E        |           JR Z,B674h
B626 4E           |           LD C,(HL)
B627 29           |           ADD HL,HL
B628 00           |           NOP
B629 FF           |           RST $38
B62A ED 4B 0C 88  |           LD BC,(880Ch)
B62E 3F           |           CCF
B62F FF           |           RST $38
B630 AA           |           XOR D
B631 CC BB EE     |           CALL Z,EEBBh
B634 DD           |           *ILLEGAL*
B635 11 44 88     |           LD DE,8844h
B638 DD 77 FD     |           LD (IX+FDh),A
B63B 34           |           INC (HL)
B63C 12           |           LD (DE),A
B63D 00           |           NOP
B63E C0           |           RET NZ
B63F 00           |           NOP
B640 30 00        |           JR NC,B642h
B642 00           |           NOP
B643 00           |           NOP
B644 00           |           NOP
B645 00           |           NOP
B646 00           |           NOP
B647 00           |           NOP
B648 00           |           NOP
B649 00           |           NOP
B64A 00           |           NOP
B64B 00           |           NOP
B64C 00           |           NOP
B64D 00           |           NOP
B64E 00           |           NOP
B64F 00           |           NOP
B650 00           |           NOP
B651 00           |           NOP
B652 00           |           NOP
B653 00           |           NOP
B654 00           |           NOP
B655 00           |           NOP
B656 00           |           NOP
B657 00           |           NOP
B658 00           |           NOP
B659 FF           |           RST $38
B65A 28 00        |           JR Z,B65Ch
B65C 00           |           NOP
B65D 00           |           NOP
B65E 00           |           NOP
B65F 00           |           NOP
B660 00           |           NOP
B661 00           |           NOP
B662 00           |           NOP
B663 00           |           NOP
B664 00           |           NOP
B665 01 80 00     |           LD BC,0080h
B668 00           |           NOP
B669 32 AC 71     |           LD (71ACh),A
B66C 43           |           LD B,E
B66D 4C           |           LD C,H
B66E 44           |           LD B,H
B66F 20 52        |           JR NZ,B6C3h
B671 52           |           LD D,D
B672 2C           |           INC L
B673 28 4E        |           JR Z,B6C3h
B675 4E           |           LD C,(HL)
B676 29           |           ADD HL,HL
B677 00           |           NOP
B678 FF           |           RST $38
B679 22 0C 88     |           LD (880Ch),HL
B67C 3F           |           CCF
B67D 00           |           NOP
B67E FF           |           RST $38
B67F AA           |           XOR D
B680 CC BB EE     |           CALL Z,EEBBh
B683 DD           |           *ILLEGAL*
B684 11 44 88     |           LD DE,8844h
B687 DD 77 FD     |           LD (IX+FDh),A
B68A 34           |           INC (HL)
B68B 12           |           LD (DE),A
B68C 00           |           NOP
B68D C0           |           RET NZ
B68E 00           |           NOP
B68F 00           |           NOP
B690 00           |           NOP
B691 00           |           NOP
B692 00           |           NOP
B693 00           |           NOP
B694 00           |           NOP
B695 00           |           NOP
B696 00           |           NOP
B697 00           |           NOP
B698 00           |           NOP
B699 00           |           NOP
B69A 00           |           NOP
B69B 00           |           NOP
B69C 00           |           NOP
B69D 00           |           NOP
B69E 00           |           NOP
B69F 00           |           NOP
B6A0 00           |           NOP
B6A1 00           |           NOP
B6A2 00           |           NOP
B6A3 00           |           NOP
B6A4 00           |           NOP
B6A5 00           |           NOP
B6A6 00           |           NOP
B6A7 00           |           NOP
B6A8 FF           |           RST $38
B6A9 28 00        |           JR Z,B6ABh
B6AB 00           |           NOP
B6AC 00           |           NOP
B6AD 00           |           NOP
B6AE 01 80 00     |           LD BC,0080h
B6B1 00           |           NOP
B6B2 00           |           NOP
B6B3 00           |           NOP
B6B4 00           |           NOP
B6B5 00           |           NOP
B6B6 00           |           NOP
B6B7 00           |           NOP
B6B8 70           |           LD (HL),B
B6B9 49           |           LD C,C
B6BA EE 1E        |           XOR 1Eh
B6BC 4C           |           LD C,H
B6BD 44           |           LD B,H
B6BE 20 28        |           JR NZ,B6E8h
B6C0 4E           |           LD C,(HL)
B6C1 4E           |           LD C,(HL)
B6C2 29           |           ADD HL,HL
B6C3 2C           |           INC L
B6C4 48           |           LD C,B
B6C5 4C           |           LD C,H
B6C6 00           |           NOP
B6C7 FF           |           RST $38
B6C8 DD 22 0C 88  |           LD (880Ch),IX
B6CC 3F           |           CCF
B6CD FF           |           RST $38
B6CE AA           |           XOR D
B6CF CC BB EE     |           CALL Z,EEBBh
B6D2 DD           |           *ILLEGAL*
B6D3 11 44 88     |           LD DE,8844h
B6D6 DD 77 FD     |           LD (IX+FDh),A
B6D9 34           |           INC (HL)
B6DA 12           |           LD (DE),A
B6DB 00           |           NOP
B6DC C0           |           RET NZ
B6DD 20 00        |           JR NZ,B6DFh
B6DF 00           |           NOP
B6E0 00           |           NOP
B6E1 00           |           NOP
B6E2 00           |           NOP
B6E3 00           |           NOP
B6E4 00           |           NOP
B6E5 00           |           NOP
B6E6 00           |           NOP
B6E7 00           |           NOP
B6E8 00           |           NOP
B6E9 00           |           NOP
B6EA 00           |           NOP
B6EB 00           |           NOP
B6EC 00           |           NOP
B6ED 00           |           NOP
B6EE 00           |           NOP
B6EF 00           |           NOP
B6F0 00           |           NOP
B6F1 00           |           NOP
B6F2 00           |           NOP
B6F3 00           |           NOP
B6F4 00           |           NOP
B6F5 00           |           NOP
B6F6 00           |           NOP
B6F7 FF           |           RST $38
B6F8 28 00        |           JR Z,B6FAh
B6FA 00           |           NOP
B6FB 00           |           NOP
B6FC 00           |           NOP
B6FD 00           |           NOP
B6FE 00           |           NOP
B6FF 01 80 01     |           LD BC,0180h
B702 80           |           ADD A,B
B703 00           |           NOP
B704 00           |           NOP
B705 00           |           NOP
B706 00           |           NOP
B707 8E           |           ADC A,(HL)
B708 A4           |           AND H
B709 E9           |           JP (HL)
B70A 7A           |           LD A,D
B70B 4C           |           LD C,H
B70C 44           |           LD B,H
B70D 20 28        |           JR NZ,B737h
B70F 4E           |           LD C,(HL)
B710 4E           |           LD C,(HL)
B711 29           |           ADD HL,HL
B712 2C           |           INC L
B713 58           |           LD E,B
B714 59           |           LD E,C
B715 00           |           NOP
B716 FF           |           RST $38
B717 ED 43 0C 88  |           LD (880Ch),BC
B71B 3F           |           CCF
B71C FF           |           RST $38
B71D AA           |           XOR D
B71E CC BB EE     |           CALL Z,EEBBh
B721 DD           |           *ILLEGAL*
B722 11 44 88     |           LD DE,8844h
B725 DD 77 FD     |           LD (IX+FDh),A
B728 34           |           INC (HL)
B729 12           |           LD (DE),A
B72A 00           |           NOP
B72B C0           |           RET NZ
B72C 00           |           NOP
B72D 30 00        |           JR NC,B72Fh
B72F 00           |           NOP
B730 00           |           NOP
B731 00           |           NOP
B732 00           |           NOP
B733 00           |           NOP
B734 00           |           NOP
B735 00           |           NOP
B736 00           |           NOP
B737 00           |           NOP
B738 00           |           NOP
B739 00           |           NOP
B73A 00           |           NOP
B73B 00           |           NOP
B73C 00           |           NOP
B73D 00           |           NOP
B73E 00           |           NOP
B73F 00           |           NOP
B740 00           |           NOP
B741 00           |           NOP
B742 00           |           NOP
B743 00           |           NOP
B744 00           |           NOP
B745 00           |           NOP
B746 FF           |           RST $38
B747 28 01        |           JR Z,B74Ah
B749 80           |           ADD A,B
B74A 01 80 01     |           LD BC,0180h
B74D 80           |           ADD A,B
B74E 00           |           NOP
B74F 00           |           NOP
B750 00           |           NOP
B751 00           |           NOP
B752 00           |           NOP
B753 00           |           NOP
B754 01 80 46     |           LD BC,4680h
B757 AA           |           XOR D
B758 F6 5E        |           OR 5Eh
B75A 4C           |           LD C,H
B75B 44           |           LD B,H
B75C 20 28        |           JR NZ,B786h
B75E 4E           |           LD C,(HL)
B75F 4E           |           LD C,(HL)
B760 29           |           ADD HL,HL
B761 2C           |           INC L
B762 52           |           LD D,D
B763 52           |           LD D,D
B764 00           |           NOP
B765 FF           |           RST $38
B766 F9           |           LD SP,HL
B767 3F           |           CCF
B768 00           |           NOP
B769 00           |           NOP
B76A 00           |           NOP
B76B FF           |           RST $38
B76C AA           |           XOR D
B76D CC BB EE     |           CALL Z,EEBBh
B770 DD           |           *ILLEGAL*
B771 11 44 88     |           LD DE,8844h
B774 DD 77 FD     |           LD (IX+FDh),A
B777 34           |           INC (HL)
B778 12           |           LD (DE),A
B779 00           |           NOP
B77A C0           |           RET NZ
B77B 00           |           NOP
B77C 00           |           NOP
B77D 00           |           NOP
B77E 00           |           NOP
B77F 00           |           NOP
B780 00           |           NOP
B781 00           |           NOP
B782 00           |           NOP
B783 00           |           NOP
B784 00           |           NOP
B785 00           |           NOP
B786 00           |           NOP
B787 00           |           NOP
B788 00           |           NOP
B789 00           |           NOP
B78A 00           |           NOP
B78B 00           |           NOP
B78C 00           |           NOP
B78D 00           |           NOP
B78E 00           |           NOP
B78F 00           |           NOP
B790 00           |           NOP
B791 00           |           NOP
B792 00           |           NOP
B793 00           |           NOP
B794 00           |           NOP
B795 FF           |           RST $38
B796 28 00        |           JR Z,B798h
B798 00           |           NOP
B799 00           |           NOP
B79A 00           |           NOP
B79B 01 80 00     |           LD BC,0080h
B79E 00           |           NOP
B79F 00           |           NOP
B7A0 00           |           NOP
B7A1 00           |           NOP
B7A2 00           |           NOP
B7A3 00           |           NOP
B7A4 00           |           NOP
B7A5 70           |           LD (HL),B
B7A6 49           |           LD C,C
B7A7 EE 1E        |           XOR 1Eh
B7A9 4C           |           LD C,H
B7AA 44           |           LD B,H
B7AB 20 53        |           JR NZ,B800h
B7AD 50           |           LD D,B
B7AE 2C           |           INC L
B7AF 48           |           LD C,B
B7B0 4C           |           LD C,H
B7B1 00           |           NOP
B7B2 FF           |           RST $38
B7B3 DD           |           *ILLEGAL*
B7B4 F9           |           LD SP,HL
B7B5 3F           |           CCF
B7B6 00           |           NOP
B7B7 00           |           NOP
B7B8 FF           |           RST $38
B7B9 AA           |           XOR D
B7BA CC BB EE     |           CALL Z,EEBBh
B7BD DD           |           *ILLEGAL*
B7BE 11 44 88     |           LD DE,8844h
B7C1 DD 77 FD     |           LD (IX+FDh),A
B7C4 34           |           INC (HL)
B7C5 12           |           LD (DE),A
B7C6 00           |           NOP
B7C7 C0           |           RET NZ
B7C8 20 00        |           JR NZ,B7CAh
B7CA 00           |           NOP
B7CB 00           |           NOP
B7CC 00           |           NOP
B7CD 00           |           NOP
B7CE 00           |           NOP
B7CF 00           |           NOP
B7D0 00           |           NOP
B7D1 00           |           NOP
B7D2 00           |           NOP
B7D3 00           |           NOP
B7D4 00           |           NOP
B7D5 00           |           NOP
B7D6 00           |           NOP
B7D7 00           |           NOP
B7D8 00           |           NOP
B7D9 00           |           NOP
B7DA 00           |           NOP
B7DB 00           |           NOP
B7DC 00           |           NOP
B7DD 00           |           NOP
B7DE 00           |           NOP
B7DF 00           |           NOP
B7E0 00           |           NOP
B7E1 00           |           NOP
B7E2 FF           |           RST $38
B7E3 28 00        |           JR Z,B7E5h
B7E5 00           |           NOP
B7E6 00           |           NOP
B7E7 00           |           NOP
B7E8 00           |           NOP
B7E9 00           |           NOP
B7EA 01 80 01     |           LD BC,0180h
B7ED 80           |           ADD A,B
B7EE 00           |           NOP
B7EF 00           |           NOP
B7F0 00           |           NOP
B7F1 00           |           NOP
B7F2 8E           |           ADC A,(HL)
B7F3 A4           |           AND H
B7F4 E9           |           JP (HL)
B7F5 7A           |           LD A,D
B7F6 4C           |           LD C,H
B7F7 44           |           LD B,H
B7F8 20 53        |           JR NZ,B84Dh
B7FA 50           |           LD D,B
B7FB 2C           |           INC L
B7FC 58           |           LD E,B
B7FD 59           |           LD E,C
B7FE 00           |           NOP
B7FF FF           |           RST $38
B800 ED 47        |           LD I,A
B802 3F           |           CCF
B803 00           |           NOP
B804 00           |           NOP
B805 FF           |           RST $38
B806 AA           |           XOR D
B807 CC BB EE     |           CALL Z,EEBBh
B80A DD           |           *ILLEGAL*
B80B 11 44 88     |           LD DE,8844h
B80E DD 77 FD     |           LD (IX+FDh),A
B811 34           |           INC (HL)
B812 12           |           LD (DE),A
B813 00           |           NOP
B814 C0           |           RET NZ
B815 00           |           NOP
B816 00           |           NOP
B817 00           |           NOP
B818 00           |           NOP
B819 00           |           NOP
B81A 00           |           NOP
B81B FF           |           RST $38
B81C 00           |           NOP
B81D 00           |           NOP
B81E 00           |           NOP
B81F 00           |           NOP
B820 00           |           NOP
B821 00           |           NOP
B822 00           |           NOP
B823 00           |           NOP
B824 00           |           NOP
B825 00           |           NOP
B826 00           |           NOP
B827 00           |           NOP
B828 00           |           NOP
B829 00           |           NOP
B82A 00           |           NOP
B82B 00           |           NOP
B82C 00           |           NOP
B82D 00           |           NOP
B82E 00           |           NOP
B82F FF           |           RST $38
B830 00           |           NOP
B831 00           |           NOP
B832 00           |           NOP
B833 00           |           NOP
B834 00           |           NOP
B835 00           |           NOP
B836 00           |           NOP
B837 00           |           NOP
B838 00           |           NOP
B839 00           |           NOP
B83A 00           |           NOP
B83B 00           |           NOP
B83C 00           |           NOP
B83D 00           |           NOP
B83E 00           |           NOP
B83F 04           |           INC B
B840 27           |           DAA
B841 0B           |           DEC BC
B842 9E           |           SBC A,(HL)
B843 4C           |           LD C,H
B844 44           |           LD B,H
B845 20 49        |           JR NZ,B890h
B847 2C           |           INC L
B848 41           |           LD B,C
B849 00           |           NOP
B84A FF           |           RST $38
B84B ED 4F        |           LD R,A
B84D 3F           |           CCF
B84E 00           |           NOP
B84F 00           |           NOP
B850 FF           |           RST $38
B851 AA           |           XOR D
B852 CC BB EE     |           CALL Z,EEBBh
B855 DD           |           *ILLEGAL*
B856 11 44 88     |           LD DE,8844h
B859 DD 77 FD     |           LD (IX+FDh),A
B85C 34           |           INC (HL)
B85D 12           |           LD (DE),A
B85E 00           |           NOP
B85F C0           |           RET NZ
B860 00           |           NOP
B861 00           |           NOP
B862 00           |           NOP
B863 00           |           NOP
B864 00           |           NOP
B865 00           |           NOP
B866 FF           |           RST $38
B867 00           |           NOP
B868 00           |           NOP
B869 00           |           NOP
B86A 00           |           NOP
B86B 00           |           NOP
B86C 00           |           NOP
B86D 00           |           NOP
B86E 00           |           NOP
B86F 00           |           NOP
B870 00           |           NOP
B871 00           |           NOP
B872 00           |           NOP
B873 00           |           NOP
B874 00           |           NOP
B875 00           |           NOP
B876 00           |           NOP
B877 00           |           NOP
B878 00           |           NOP
B879 00           |           NOP
B87A FF           |           RST $38
B87B 00           |           NOP
B87C 00           |           NOP
B87D 00           |           NOP
B87E 00           |           NOP
B87F 00           |           NOP
B880 00           |           NOP
B881 00           |           NOP
B882 00           |           NOP
B883 00           |           NOP
B884 00           |           NOP
B885 00           |           NOP
B886 00           |           NOP
B887 00           |           NOP
B888 00           |           NOP
B889 00           |           NOP
B88A 04           |           INC B
B88B 27           |           DAA
B88C 0B           |           DEC BC
B88D 9E           |           SBC A,(HL)
B88E 4C           |           LD C,H
B88F 44           |           LD B,H
B890 20 52        |           JR NZ,B8E4h
B892 2C           |           INC L
B893 41           |           LD B,C
B894 00           |           NOP
B895 FF           |           RST $38
B896 ED 47        |           LD I,A
B898 ED 57        |           LD A,I
B89A 3F           |           CCF
B89B FF           |           RST $38
B89C AA           |           XOR D
B89D CC BB EE     |           CALL Z,EEBBh
B8A0 DD           |           *ILLEGAL*
B8A1 11 44 88     |           LD DE,8844h
B8A4 DD 77 FD     |           LD (IX+FDh),A
B8A7 34           |           INC (HL)
B8A8 12           |           LD (DE),A
B8A9 00           |           NOP
B8AA C0           |           RET NZ
B8AB 00           |           NOP
B8AC 00           |           NOP
B8AD 00           |           NOP
B8AE 00           |           NOP
B8AF 00           |           NOP
B8B0 00           |           NOP
B8B1 FF           |           RST $38
B8B2 00           |           NOP
B8B3 00           |           NOP
B8B4 00           |           NOP
B8B5 00           |           NOP
B8B6 00           |           NOP
B8B7 00           |           NOP
B8B8 00           |           NOP
B8B9 00           |           NOP
B8BA 00           |           NOP
B8BB 00           |           NOP
B8BC 00           |           NOP
B8BD 00           |           NOP
B8BE 00           |           NOP
B8BF 00           |           NOP
B8C0 00           |           NOP
B8C1 00           |           NOP
B8C2 00           |           NOP
B8C3 00           |           NOP
B8C4 00           |           NOP
B8C5 FF           |           RST $38
B8C6 00           |           NOP
B8C7 00           |           NOP
B8C8 00           |           NOP
B8C9 00           |           NOP
B8CA 00           |           NOP
B8CB 00           |           NOP
B8CC 00           |           NOP
B8CD 00           |           NOP
B8CE 00           |           NOP
B8CF 00           |           NOP
B8D0 00           |           NOP
B8D1 00           |           NOP
B8D2 00           |           NOP
B8D3 00           |           NOP
B8D4 00           |           NOP
B8D5 C7           |           RST $00
B8D6 7D           |           LD A,L
B8D7 47           |           LD B,A
B8D8 F5           |           PUSH AF
B8D9 4C           |           LD C,H
B8DA 44           |           LD B,H
B8DB 20 41        |           JR NZ,B91Eh
B8DD 2C           |           INC L
B8DE 49           |           LD C,C
B8DF 00           |           NOP
B8E0 FF           |           RST $38
B8E1 ED 4F        |           LD R,A
B8E3 ED 5F        |           LD A,R
B8E5 3F           |           CCF
B8E6 FF           |           RST $38
B8E7 AA           |           XOR D
B8E8 CC BB EE     |           CALL Z,EEBBh
B8EB DD           |           *ILLEGAL*
B8EC 11 44 88     |           LD DE,8844h
B8EF DD 77 FD     |           LD (IX+FDh),A
B8F2 34           |           INC (HL)
B8F3 12           |           LD (DE),A
B8F4 00           |           NOP
B8F5 C0           |           RET NZ
B8F6 00           |           NOP
B8F7 00           |           NOP
B8F8 00           |           NOP
B8F9 00           |           NOP
B8FA 00           |           NOP
B8FB 00           |           NOP
B8FC FF           |           RST $38
B8FD 00           |           NOP
B8FE 00           |           NOP
B8FF 00           |           NOP
B900 00           |           NOP
B901 00           |           NOP
B902 00           |           NOP
B903 00           |           NOP
B904 00           |           NOP
B905 00           |           NOP
B906 00           |           NOP
B907 00           |           NOP
B908 00           |           NOP
B909 00           |           NOP
B90A 00           |           NOP
B90B 00           |           NOP
B90C 00           |           NOP
B90D 00           |           NOP
B90E 00           |           NOP
B90F 00           |           NOP
B910 FF           |           RST $38
B911 00           |           NOP
B912 00           |           NOP
B913 00           |           NOP
B914 00           |           NOP
B915 00           |           NOP
B916 00           |           NOP
B917 00           |           NOP
B918 00           |           NOP
B919 00           |           NOP
B91A 00           |           NOP
B91B 00           |           NOP
B91C 00           |           NOP
B91D 00           |           NOP
B91E 00           |           NOP
B91F 00           |           NOP
B920 63           |           LD H,E
B921 91           |           SUB A,C
B922 D3 54        |           OUT (54h),A
B924 4C           |           LD C,H
B925 44           |           LD B,H
B926 20 41        |           JR NZ,B969h
B928 2C           |           INC L
B929 52           |           LD D,D
B92A 00           |           NOP
B92B FF           |           RST $38
B92C FB           |           EI
B92D F3           |           DI
B92E 3F           |           CCF
B92F 00           |           NOP
B930 00           |           NOP
B931 FF           |           RST $38
B932 AA           |           XOR D
B933 CC BB EE     |           CALL Z,EEBBh
B936 DD           |           *ILLEGAL*
B937 11 44 88     |           LD DE,8844h
B93A DD 77 FD     |           LD (IX+FDh),A
B93D 34           |           INC (HL)
B93E 12           |           LD (DE),A
B93F 00           |           NOP
B940 C0           |           RET NZ
B941 00           |           NOP
B942 00           |           NOP
B943 00           |           NOP
B944 00           |           NOP
B945 00           |           NOP
B946 00           |           NOP
B947 00           |           NOP
B948 00           |           NOP
B949 00           |           NOP
B94A 00           |           NOP
B94B 00           |           NOP
B94C 00           |           NOP
B94D 00           |           NOP
B94E 00           |           NOP
B94F 00           |           NOP
B950 00           |           NOP
B951 00           |           NOP
B952 00           |           NOP
B953 00           |           NOP
B954 00           |           NOP
B955 00           |           NOP
B956 00           |           NOP
B957 00           |           NOP
B958 00           |           NOP
B959 00           |           NOP
B95A 00           |           NOP
B95B FF           |           RST $38
B95C 28 00        |           JR Z,B95Eh
B95E 00           |           NOP
B95F 00           |           NOP
B960 00           |           NOP
B961 00           |           NOP
B962 00           |           NOP
B963 00           |           NOP
B964 00           |           NOP
B965 00           |           NOP
B966 00           |           NOP
B967 00           |           NOP
B968 00           |           NOP
B969 00           |           NOP
B96A 00           |           NOP
B96B C3 F6 46     |           JP 46F6h
B96E 0B           |           DEC BC
B96F 45           |           LD B,L
B970 49           |           LD C,C
B971 2B           |           DEC HL
B972 44           |           LD B,H
B973 49           |           LD C,C
B974 00           |           NOP
B975 FF           |           RST $38
B976 ED 46        |           IM 0
B978 3F           |           CCF
B979 00           |           NOP
B97A 00           |           NOP
B97B FF           |           RST $38
B97C AA           |           XOR D
B97D CC BB EE     |           CALL Z,EEBBh
B980 DD           |           *ILLEGAL*
B981 11 44 88     |           LD DE,8844h
B984 DD 77 FD     |           LD (IX+FDh),A
B987 34           |           INC (HL)
B988 12           |           LD (DE),A
B989 00           |           NOP
B98A C0           |           RET NZ
B98B 00           |           NOP
B98C 38 00        |           JR C,B98Eh
B98E 00           |           NOP
B98F 00           |           NOP
B990 00           |           NOP
B991 00           |           NOP
B992 00           |           NOP
B993 00           |           NOP
B994 00           |           NOP
B995 00           |           NOP
B996 00           |           NOP
B997 00           |           NOP
B998 00           |           NOP
B999 00           |           NOP
B99A 00           |           NOP
B99B 00           |           NOP
B99C 00           |           NOP
B99D 00           |           NOP
B99E 00           |           NOP
B99F 00           |           NOP
B9A0 00           |           NOP
B9A1 00           |           NOP
B9A2 00           |           NOP
B9A3 00           |           NOP
B9A4 00           |           NOP
B9A5 FF           |           RST $38
B9A6 28 00        |           JR Z,B9A8h
B9A8 00           |           NOP
B9A9 00           |           NOP
B9AA 00           |           NOP
B9AB 00           |           NOP
B9AC 00           |           NOP
B9AD 00           |           NOP
B9AE 00           |           NOP
B9AF 00           |           NOP
B9B0 00           |           NOP
B9B1 00           |           NOP
B9B2 00           |           NOP
B9B3 00           |           NOP
B9B4 00           |           NOP
B9B5 05           |           DEC B
B9B6 E7           |           RST $20
B9B7 05           |           DEC B
B9B8 E5           |           PUSH HL
B9B9 49           |           LD C,C
B9BA 4D           |           LD C,L
B9BB 20 4E        |           JR NZ,BA0Bh
B9BD 00           |           NOP
B9BE FF           |           RST $38
