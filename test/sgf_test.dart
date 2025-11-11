import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/game_client/game_record.dart';
import 'package:wqhub/parse/sgf/sgf.dart';
import 'package:wqhub/wq/wq.dart' as wq;

void main() {
  test('parse', () {
    const sgfData =
        '(;GM[1]FF[4]\r\nSZ[9]\r\nGN[]\r\nDT[2025-02-23]\r\nPB[openfoxwq]\r\nPW[V144692779]\r\nBR[10级]\r\nWR[10级]\r\nKM[375]HA[0]RU[Chinese]AP[GNU Go:3.8]RN[12]RE[W+3.25]TM[60]TC[3]TT[20]AP[foxwq]RL[0]\r\n;B[ee];W[ce];B[ge];W[dg];B[dd];W[ff];B[ef];W[eg];B[fg];W[gg];B[fh];W[gf];B[gh];W[he];B[hg];W[hf];B[ih];W[fe];B[fd];W[gd];B[cd];W[be];B[hi];W[df];B[fc];W[gc];B[gb];W[bd];B[bc];W[eh];B[hb];W[hc];B[ac];W[de];B[ed];W[fi];B[ic];W[id];B[ib];W[cc];B[cb];W[ei];B[gi];W[fb];B[eb];W[if];B[ig];W[dc];B[fa];W[ad];B[bb];W[ec];B[db];W[bh];W[cf])';
    final sgf = Sgf.parse(sgfData);
    expect(sgf.trees.length, 1);

    final t = sgf.trees.first;
    expect(t.nodes.length, 56);
    expect(t.children.length, 0);

    final root = t.nodes[0];
    expect(root['GM'], ['1']);
    expect(root['FF'], ['4']);
    expect(root['SZ'], ['9']);
    expect(root['DT'], ['2025-02-23']);
    expect(root['PB'], ['openfoxwq']);
    expect(root['BR'], ['10级']);

    expect(t.nodes[1]['B'], ['ee']);
    expect(t.nodes[2]['W'], ['ce']);
  });

  test('fromSgf', () {
    const sgfData =
        '(;GM[1]FF[4]\r\nSZ[19]\r\nGN[]\r\nDT[2025-03-29]\r\nPB[openfoxwq]\r\nPW[才学2天]\r\nBR[11级]\r\nWR[11级]\r\nKM[375]HA[0]RU[Chinese]AP[GNU Go:3.8]RN[3]RE[B+R]TM[60]TC[3]TT[20]AP[foxwq]RL[0]\r\n;B[pd];W[cp];B[pp];W[dc];B[eq];W[iq];B[do];W[co];B[dn];W[cn];B[dm];W[io];B[de];W[ce];B[cf];W[cd];B[df];W[fd];B[cm];W[dj];B[cr];W[dr];B[dq];W[br];B[cq];W[bq];B[bm];W[bn];B[ap];W[ao];B[bp];W[bs];B[am];W[aq];B[ci];W[cj];B[bj];W[bk];B[bh];W[fj];B[ck];W[dk];B[cl];W[eh];B[nc];W[rd];B[qd];W[rc];B[re];W[pb];B[qc];W[qb];B[qf];W[qn];B[qo];W[pn];B[nq];W[qk];B[qi];W[lq];B[hc];W[qq];B[no];W[ro];B[qp];W[rp];B[pq];W[qr];B[pr];W[kc];B[ec];W[fc];B[eb];W[ed];B[dd];W[db];B[cc];W[cb];B[bc];W[bb];B[be];W[hd];B[ic];W[id];B[jc];W[jd];B[kb];W[jb];B[lb];W[mb];B[mc];W[nb];B[kd];W[gb];B[ab];W[ke];B[lc];W[ld];B[kc];W[le];B[ba];W[ea];B[oc];W[ob];B[ma];W[na];B[rb];W[sb];B[ra];W[qa];B[sd];W[sa];B[rb];W[ff];B[se];W[ki];B[gm];W[hk];B[im];W[kk];B[rr];W[rq];B[lr];W[kr];B[mr];W[mp];B[jr];W[ks];B[ir];W[jq];B[hr];W[hq];B[gq];W[gp];B[fp];W[go];B[fn];W[np];B[op];W[oo];B[mq];W[lp];B[or];W[ln];B[km];W[lm];B[pk];W[pl];B[ok];W[rj];B[qj];W[rk];B[ol];W[pm];B[ng];W[lg];B[on];W[po];B[om];W[oi];B[mi];W[nf];B[og];W[mh];B[nh];W[ri];B[rh];W[qh];B[ph];W[rg];B[qg];W[sh];B[qh];W[mg];B[lj];W[kj];B[jn];W[jo];B[ik];W[ij];B[jk];W[jj];B[kl];W[ll];B[lk];W[mk];B[mj];W[kn];B[jl];W[li];B[ml];W[hl];B[hm];W[il];B[jm];W[nn];B[gk];W[gj];B[gl];W[hj];B[sg];W[sf];B[rf];W[si];B[sg];W[el];B[eg];W[fg];B[dh];W[ei];B[oe];W[ne];B[of];W[hb];B[ib];W[nl];B[nk];W[nm];B[gc];W[gd];B[ca];W[fb];B[qs];W[sr];B[rs];W[js];B[gr];W[cs];B[er];W[ds];B[me];W[md];B[nd];W[mf];B[sq];W[sp];B[ps];W[rm];B[ee];W[da];B[fe];W[ge];B[di];W[fo];B[eo];W[gn];B[em];W[fl];B[fk];W[fm];B[ek];W[en];B[dl];W[fn];B[ej];W[hn];B[ni];W[mm];B[in];W[is];B[hs];W[ls];B[kq];W[kp];B[ms];W[kq];B[ef];W[aa];B[ba];W[ca];B[ac];W[aa];B[fh];W[fi];B[gh];W[gf];B[ba];W[dj];B[dk];W[aa];B[ss];W[sq];B[ba];W[ra];B[sc];W[aa];B[rn];W[sn];B[ba];W[la];B[aa])';
    final rec = GameRecord.fromSgf(sgfData);
    expect(rec.type, GameRecordType.sgf);
    expect(rec.moves.length, 291);
  });

  test('fromSgf with variations', () {
    // Test SGF with a simple variation - should follow main line
    const sgfData =
        '(;GM[1]FF[4]SZ[9];B[fe];W[de](;B[ec];W[dc];B[db])(;B[ee];W[dd]))';
    final sgf = Sgf.parse(sgfData);

    expect(sgf.trees.length, 1);

    final tree = sgf.trees.first;
    // Main line nodes: root + B[fe] + W[de]
    expect(tree.nodes.length, 3);
    expect(tree.nodes[0]['GM'], ['1']);
    expect(tree.nodes[1]['B'], ['fe']);
    expect(tree.nodes[2]['W'], ['de']);

    // There are two variations (children)
    expect(tree.children.length, 2);

    // First variation
    final var1 = tree.children[0];
    expect(var1.nodes.length, 3);
    expect(var1.nodes[0]['B'], ['ec']);
    expect(var1.nodes[1]['W'], ['dc']);
    expect(var1.nodes[2]['B'], ['db']);

    // Second variation
    final var2 = tree.children[1];
    expect(var2.nodes.length, 2);
    expect(var2.nodes[0]['B'], ['ee']);
    expect(var2.nodes[1]['W'], ['dd']);

    final rec = GameRecord.fromSgf(sgfData);
    // We assume the actual game follows the first variation
    // at each branch point.  Therefore, we have
    // 2 moves at the top level + 3 moves in the first variation.
    expect(rec.moves.length, 5);
  });

  test('SGF with escaped bracket', () {
    // Test that escaped characters in comments are handled correctly
    const sgfWithEscape = '(;GM[1]FF[4]SZ[9]C[Comment with \\] bracket];B[aa])';
    final sgf = Sgf.parse(sgfWithEscape);
    expect(sgf.trees.length, 1);

    final comment = sgf.trees.first.nodes.first['C']?.first;
    expect(comment, 'Comment with ] bracket');

    final rec = GameRecord.fromSgf(sgfWithEscape);
    expect(rec.moves.length, 1);
    expect(rec.moves[0].col, wq.Color.black);
  });

  test('parse with variations... and a space', () {
    const sgfWithSpaceAroundVariation =
        '(;GM[1]FF[4]SZ[9];B[fe];W[de] (;B[ec];W[dc];B[db])(;B[ee];W[dd]))';
    final sgf = Sgf.parse(sgfWithSpaceAroundVariation);
    expect(sgf.trees.length, 1);

    final tree = sgf.trees.first;
    // Main line nodes: root + B[fe] + W[de]
    expect(tree.nodes.length, 3);
    expect(tree.nodes[0]['GM'], ['1']);
    expect(tree.nodes[1]['B'], ['fe']);
    expect(tree.nodes[2]['W'], ['de']);

    // There are two variations (children)
    expect(tree.children.length, 2);

    // First variation
    final var1 = tree.children[0];
    expect(var1.nodes.length, 3);
    expect(var1.nodes[0]['B'], ['ec']);
    expect(var1.nodes[1]['W'], ['dc']);
    expect(var1.nodes[2]['B'], ['db']);

    // Second variation
    final var2 = tree.children[1];
    expect(var2.nodes.length, 2);
    expect(var2.nodes[0]['B'], ['ee']);
    expect(var2.nodes[1]['W'], ['dd']);
  });


  test('fromSgf', () {
    const sgfData =
        '(;GM[1]EV[Internet Go Server game: sugadintas vs Hurakami]US[Brought to you by IGS PANDANET]CoPyright[  Copyright (c) PANDANET Inc. 2025  Permission to reproduce this game is given, provided proper credit is given.  No warrantee, implied or explicit, is understood.  Use of this game is an understanding and agreement of this notice.]GN[sugadintas-Hurakami(B) IGS]RE[B+Time]PW[sugadintas]WR[3d?]NW[31]PB[Hurakami]BR[1k+]NB[28]PC[IGS:  igs.joyjoy.net 6969]DT[2025-11-07]SZ[19]TM[60]KM[0.500000]LT[]RR[Normal]HA[3]AB[dd][pd][dp]C[ Hurakami 1k+: Hi!];W[pp]WL[52];B[dj]BL[57];W[pj]WL[52];B[jd]BL[54];W[jp]WL[51];B[jj]BL[53];W[kk]WL[50];B[kj]BL[52];W[lk]WL[50];B[jk]BL[51];W[jl]WL[49];B[il]BL[50];W[im]WL[49];B[hm]BL[47];W[jm]WL[48];B[hl]BL[45];W[lj]WL[47];B[li]BL[44];W[mi]WL[47];B[mh]BL[43];W[nh]WL[46];B[lh]BL[42];W[ni]WL[45];B[hn]BL[39];W[ng]WL[44];B[qq]BL[35];W[qp]WL[43];B[pq]BL[33];W[or]WL[42];B[hp]BL[29];W[jq]WL[41];B[qf]BL[25];W[cc]WL[40];B[cd]BL[22];W[dc]WL[39];B[ec]BL[20];W[eb]WL[38];B[fc]BL[19];W[fb]WL[37];B[gc]BL[18];W[gb]WL[36];B[hc]BL[17];W[cq]WL[35];B[cp]BL[14];W[dq]WL[35];B[eq]BL[12];W[er]WL[35];B[fr]BL[9];W[fq]WL[34];B[ep]BL[7];W[gr]WL[33];B[dr]BL[6];W[fs]WL[32];B[cr]BL[5];W[bq]WL[31];B[br]BL[4];W[nd]WL[21];B[nc]BL[2];W[mc]WL[20];B[oc]BL[1];W[md]WL[19];B[le]BL[298];W[mf]WL[18];B[lf]BL[297];W[qh]WL[17];B[of]BL[294];W[nf]WL[16];B[bd]BL[289];W[bc]WL[16];B[ac]BL[287];W[ab]WL[15];B[ad]BL[286];W[ba]WL[14];B[rg]BL[268];W[rh]WL[13];B[sh]BL[267];OS[xysu123456])';
    final rec = GameRecord.fromSgf(sgfData);
    expect(rec.type, GameRecordType.sgf);
    expect(rec.moves.length, 76);
  });
}
