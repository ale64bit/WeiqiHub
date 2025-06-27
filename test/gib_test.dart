import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/parse/gib/gib.dart';

void main() {
  test('parse', () {
    const gibData = r'''\HS
      \[GAMEINFOMAIN=GBKIND:0,GTYPE:0,GCDT:0,GTIME:300-15-3,GRLT:0,ZIPSU:785,DUM:0,GONGJE:65,TCNT:208,LINE:19,AUSZ:0\]
      \[GAMEINFOSUB=GNAMEF:0,GPLCF:0,GNAME:rank game,GDATE:2025-02-15-21-01-24,GPLC:www.tygem.com,GCMT:\]
      \[WUSERINFO=WID:osun,WLV:5,WNICK:osun,WNCD:3,WAID:121,WIMG:\]
      \[BUSERINFO=BID:someid,BLV:5,BNICK:*e2523jeg*,BNCD:0,BAID:0,BIMG:http://www.tygem.com/wuser/105/492/722/photo/thumbs/tu000_105492722.jpg\]
      \[GAMETAG=S0,R0,D0,G65,W0,Z785,T15-3-300,C2025-02-15-21-01-24,I:osun,L:5,M:someid,N:5,A:osun,B:*e2523jeg*,J:3,K:0\]
      \HE
      \GS
      2 1 0
      213 0 &4
      INI 0 1 0 &4
      STO 0 2 1 15 3
      STO 0 3 2 3 15
      STO 0 4 1 15 15
      STO 0 5 2 2 2
      STO 0 6 1 2 16
      STO 0 7 2 3 16
      STO 0 8 1 2 15
      STO 0 9 2 3 14
      STO 0 10 1 2 14
      STO 0 11 2 2 13
      STO 0 12 1 1 13
      STO 0 13 2 13 16
      STO 0 14 1 14 16
      STO 0 15 2 13 15
      STO 0 16 1 16 13
      STO 0 17 2 9 15
      STO 0 18 1 7 16
      STO 0 19 2 8 16
      STO 0 20 1 7 15
      STO 0 21 2 9 13
      STO 0 22 1 10 16
      STO 0 23 2 9 16
      STO 0 24 1 11 14
      STO 0 25 2 10 15
      STO 0 26 1 11 15
      STO 0 27 2 11 16
      STO 0 28 1 12 16
      STO 0 29 2 11 17
      STO 0 30 1 12 17
      STO 0 31 2 12 15
      STO 0 32 1 10 17
      STO 0 33 2 9 17
      STO 0 34 1 11 18
      STO 0 35 2 6 14
      STO 0 36 1 2 12
      STO 0 37 2 3 13
      STO 0 38 1 1 11
      STO 0 39 2 2 17
      STO 0 40 1 2 4
      STO 0 41 2 1 16
      STO 0 42 1 1 14
      STO 0 43 2 4 3
      STO 0 44 1 4 5
      STO 0 45 2 7 14
      STO 0 46 1 4 1
      STO 0 47 2 5 2
      STO 0 48 1 5 1
      STO 0 49 2 6 2
      STO 0 50 1 3 3
      STO 0 51 2 3 2
      STO 0 52 1 4 2
      STO 0 53 2 5 3
      STO 0 54 1 6 1
      STO 0 55 2 7 1
      STO 0 56 1 7 2
      STO 0 57 2 8 2
      STO 0 58 1 7 3
      STO 0 59 2 8 1
      STO 0 60 1 5 4
      STO 0 61 2 2 3
      STO 0 62 1 3 4
      STO 0 63 2 1 4
      STO 0 64 1 1 5
      STO 0 65 2 1 3
      STO 0 66 1 1 1
      STO 0 67 2 3 1
      STO 0 68 1 2 1
      STO 0 69 2 0 1
      STO 0 70 1 0 2
      STO 0 71 2 1 2
      STO 0 72 1 0 0
      STO 0 73 2 2 0
      STO 0 74 1 6 3
      STO 0 75 2 3 0
      STO 0 76 1 0 4
      STO 0 77 2 1 0
      STO 0 78 1 0 3
      STO 0 79 2 0 1
      STO 0 80 1 0 5
      STO 0 81 2 16 2
      STO 0 82 1 16 3
      STO 0 83 2 15 2
      STO 0 84 1 14 2
      STO 0 85 2 14 1
      STO 0 86 1 13 2
      STO 0 87 2 13 1
      STO 0 88 1 12 2
      STO 0 89 2 12 1
      STO 0 90 1 11 2
      STO 0 91 2 11 1
      STO 0 92 1 15 9
      STO 0 93 2 17 2
      STO 0 94 1 17 3
      STO 0 95 2 10 2
      STO 0 96 1 10 3
      STO 0 97 2 9 3
      STO 0 98 1 10 4
      STO 0 99 2 4 11
      STO 0 100 1 3 11
      STO 0 101 2 4 10
      STO 0 102 1 9 9
      STO 0 103 2 9 11
      STO 0 104 1 10 12
      STO 0 105 2 10 11
      STO 0 106 1 11 11
      STO 0 107 2 9 12
      STO 0 108 1 11 10
      STO 0 109 2 10 13
      STO 0 110 1 11 13
      STO 0 111 2 7 10
      STO 0 112 1 7 8
      STO 0 113 2 2 10
      STO 0 114 1 3 10
      STO 0 115 2 3 9
      STO 0 116 1 2 9
      STO 0 117 2 1 9
      STO 0 118 1 2 8
      STO 0 119 2 1 10
      STO 0 120 1 2 11
      STO 0 121 2 3 8
      STO 0 122 1 2 7
      STO 0 123 2 3 7
      STO 0 124 1 2 6
      STO 0 125 2 5 8
      STO 0 126 1 6 9
      STO 0 127 2 5 9
      STO 0 128 1 6 10
      STO 0 129 2 6 11
      STO 0 130 1 7 11
      STO 0 131 2 7 12
      STO 0 132 1 5 11
      STO 0 133 2 8 11
      STO 0 134 1 6 12
      STO 0 135 2 7 11
      STO 0 136 1 4 12
      STO 0 137 2 5 10
      STO 0 138 1 5 12
      STO 0 139 2 3 12
      STO 0 140 1 6 8
      STO 0 141 2 6 13
      STO 0 142 1 5 7
      STO 0 143 2 4 8
      STO 0 144 1 3 6
      STO 0 145 2 5 13
      STO 0 146 1 0 12
      STO 0 147 2 11 12
      STO 0 148 1 12 12
      STO 0 149 2 10 10
      STO 0 150 1 10 9
      STO 0 151 2 8 9
      STO 0 152 1 8 8
      STO 0 153 2 9 8
      STO 0 154 1 10 8
      STO 0 155 2 9 7
      STO 0 156 1 9 4
      STO 0 157 2 9 10
      STO 0 158 1 12 9
      STO 0 159 2 6 7
      STO 0 160 1 7 7
      STO 0 161 2 6 6
      STO 0 162 1 7 6
      STO 0 163 2 5 6
      STO 0 164 1 6 5
      STO 0 165 2 4 6
      STO 0 166 1 5 5
      STO 0 167 2 4 7
      STO 0 168 1 16 7
      STO 0 169 2 8 3
      STO 0 170 1 8 4
      STO 0 171 2 18 3
      STO 0 172 1 18 4
      STO 0 173 2 18 2
      STO 0 174 1 17 4
      STO 0 175 2 9 18
      STO 0 176 1 7 0
      STO 0 177 2 9 1
      STO 0 178 1 1 15
      STO 0 179 2 1 17
      STO 0 180 1 10 14
      STO 0 181 2 0 15
      STO 0 182 1 0 14
      STO 0 183 2 0 16
      STO 0 184 1 4 17
      STO 0 185 2 3 17
      STO 0 186 1 9 14
      STO 0 187 2 8 14
      STO 0 188 1 8 15
      STO 0 189 2 7 17
      STO 0 190 1 6 16
      STO 0 191 2 6 17
      STO 0 192 1 5 16
      STO 0 193 2 5 17
      STO 0 194 1 10 18
      STO 0 195 2 4 16
      STO 0 196 1 8 18
      STO 0 197 2 8 17
      STO 0 198 1 13 17
      SKI 0 199 
      STO 0 200 1 10 12
      STO 0 201 2 0 11
      STO 0 202 1 0 10
      STO 0 203 2 11 12
      STO 0 204 1 4 0
      STO 0 205 2 10 12
      STO 0 206 1 6 0
      STO 0 207 2 8 0
      STO 0 208 1 4 4
      STO 0 209 2 7 9
      STO 0 210 1 10 7
      SKI 0 211 
      REM 0 212 -1 -1 0 1 
      \GE''';
    final gib = Gib.parse(gibData.codeUnits);
    expect(gib.game.length, 214);
    expect(gib.headers.containsKey('GAMEINFOMAIN'), true);
  });
}
