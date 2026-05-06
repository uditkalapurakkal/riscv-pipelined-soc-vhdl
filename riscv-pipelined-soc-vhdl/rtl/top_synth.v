module alu_decoder
  (input  [2:0] funct3,
   input  funct7_5,
   input  op5,
   input  [1:0] alu_op,
   output [2:0] alu_cont);
  wire n2262_o;
  wire n2264_o;
  wire n2265_o;
  wire [2:0] n2268_o;
  wire n2270_o;
  wire n2272_o;
  wire n2274_o;
  wire n2276_o;
  wire [3:0] n2277_o;
  reg [2:0] n2282_o;
  wire n2284_o;
  wire [2:0] n2285_o;
  reg [2:0] n2289_o;
  assign alu_cont = n2289_o; //(module output)
  /* ALU_DECODER.vhd:21:7  */
  assign n2262_o = alu_op == 2'b00;
  /* ALU_DECODER.vhd:23:7  */
  assign n2264_o = alu_op == 2'b01;
  /* ALU_DECODER.vhd:28:26  */
  assign n2265_o = funct7_5 & op5;
  /* ALU_DECODER.vhd:28:13  */
  assign n2268_o = n2265_o ? 3'b110 : 3'b010;
  /* ALU_DECODER.vhd:27:11  */
  assign n2270_o = funct3 == 3'b000;
  /* ALU_DECODER.vhd:33:11  */
  assign n2272_o = funct3 == 3'b010;
  /* ALU_DECODER.vhd:35:11  */
  assign n2274_o = funct3 == 3'b110;
  /* ALU_DECODER.vhd:37:11  */
  assign n2276_o = funct3 == 3'b111;
  assign n2277_o = {n2276_o, n2274_o, n2272_o, n2270_o};
  /* ALU_DECODER.vhd:26:9  */
  always @*
    case (n2277_o)
      4'b1000: n2282_o = 3'b000;
      4'b0100: n2282_o = 3'b001;
      4'b0010: n2282_o = 3'b111;
      4'b0001: n2282_o = n2268_o;
      default: n2282_o = 3'b010;
    endcase
  /* ALU_DECODER.vhd:25:7  */
  assign n2284_o = alu_op == 2'b10;
  assign n2285_o = {n2284_o, n2264_o, n2262_o};
  /* ALU_DECODER.vhd:20:5  */
  always @*
    case (n2285_o)
      3'b100: n2289_o = n2282_o;
      3'b010: n2289_o = 3'b110;
      3'b001: n2289_o = 3'b010;
      default: n2289_o = 3'b010;
    endcase
endmodule

module main_decoder
  (input  [6:0] op,
   output [2:0] imm_src,
   output reg_write,
   output [1:0] res_src,
   output alu_src,
   output branch,
   output jump,
   output mem_write,
   output [1:0] alu_op);
  wire n2162_o;
  wire n2164_o;
  wire n2166_o;
  wire n2168_o;
  wire n2170_o;
  wire n2172_o;
  wire n2174_o;
  wire n2176_o;
  wire [7:0] n2177_o;
  reg [2:0] n2187_o;
  reg n2197_o;
  reg [1:0] n2207_o;
  reg n2217_o;
  reg n2227_o;
  reg n2237_o;
  reg n2247_o;
  reg [1:0] n2257_o;
  assign imm_src = n2187_o; //(module output)
  assign reg_write = n2197_o; //(module output)
  assign res_src = n2207_o; //(module output)
  assign alu_src = n2217_o; //(module output)
  assign branch = n2227_o; //(module output)
  assign jump = n2237_o; //(module output)
  assign mem_write = n2247_o; //(module output)
  assign alu_op = n2257_o; //(module output)
  /* MAIN_DECODER.vhd:25:7  */
  assign n2162_o = op == 7'b0110011;
  /* MAIN_DECODER.vhd:34:7  */
  assign n2164_o = op == 7'b0000011;
  /* MAIN_DECODER.vhd:43:7  */
  assign n2166_o = op == 7'b0100011;
  /* MAIN_DECODER.vhd:52:7  */
  assign n2168_o = op == 7'b1100011;
  /* MAIN_DECODER.vhd:61:7  */
  assign n2170_o = op == 7'b0010011;
  /* MAIN_DECODER.vhd:70:7  */
  assign n2172_o = op == 7'b1101111;
  /* MAIN_DECODER.vhd:79:7  */
  assign n2174_o = op == 7'b0110111;
  /* MAIN_DECODER.vhd:88:7  */
  assign n2176_o = op == 7'b0010111;
  assign n2177_o = {n2176_o, n2174_o, n2172_o, n2170_o, n2168_o, n2166_o, n2164_o, n2162_o};
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2187_o = 3'b100;
      8'b01000000: n2187_o = 3'b100;
      8'b00100000: n2187_o = 3'b011;
      8'b00010000: n2187_o = 3'b000;
      8'b00001000: n2187_o = 3'b010;
      8'b00000100: n2187_o = 3'b001;
      8'b00000010: n2187_o = 3'b000;
      8'b00000001: n2187_o = 3'b000;
      default: n2187_o = 3'b000;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2197_o = 1'b1;
      8'b01000000: n2197_o = 1'b1;
      8'b00100000: n2197_o = 1'b1;
      8'b00010000: n2197_o = 1'b1;
      8'b00001000: n2197_o = 1'b0;
      8'b00000100: n2197_o = 1'b0;
      8'b00000010: n2197_o = 1'b1;
      8'b00000001: n2197_o = 1'b1;
      default: n2197_o = 1'b0;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2207_o = 2'b00;
      8'b01000000: n2207_o = 2'b00;
      8'b00100000: n2207_o = 2'b10;
      8'b00010000: n2207_o = 2'b00;
      8'b00001000: n2207_o = 2'b00;
      8'b00000100: n2207_o = 2'b00;
      8'b00000010: n2207_o = 2'b01;
      8'b00000001: n2207_o = 2'b00;
      default: n2207_o = 2'b10;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2217_o = 1'b1;
      8'b01000000: n2217_o = 1'b1;
      8'b00100000: n2217_o = 1'b0;
      8'b00010000: n2217_o = 1'b1;
      8'b00001000: n2217_o = 1'b0;
      8'b00000100: n2217_o = 1'b1;
      8'b00000010: n2217_o = 1'b1;
      8'b00000001: n2217_o = 1'b0;
      default: n2217_o = 1'b0;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2227_o = 1'b0;
      8'b01000000: n2227_o = 1'b0;
      8'b00100000: n2227_o = 1'b0;
      8'b00010000: n2227_o = 1'b0;
      8'b00001000: n2227_o = 1'b1;
      8'b00000100: n2227_o = 1'b0;
      8'b00000010: n2227_o = 1'b0;
      8'b00000001: n2227_o = 1'b0;
      default: n2227_o = 1'b0;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2237_o = 1'b0;
      8'b01000000: n2237_o = 1'b0;
      8'b00100000: n2237_o = 1'b1;
      8'b00010000: n2237_o = 1'b0;
      8'b00001000: n2237_o = 1'b0;
      8'b00000100: n2237_o = 1'b0;
      8'b00000010: n2237_o = 1'b0;
      8'b00000001: n2237_o = 1'b0;
      default: n2237_o = 1'b0;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2247_o = 1'b0;
      8'b01000000: n2247_o = 1'b0;
      8'b00100000: n2247_o = 1'b0;
      8'b00010000: n2247_o = 1'b0;
      8'b00001000: n2247_o = 1'b0;
      8'b00000100: n2247_o = 1'b1;
      8'b00000010: n2247_o = 1'b0;
      8'b00000001: n2247_o = 1'b0;
      default: n2247_o = 1'b0;
    endcase
  /* MAIN_DECODER.vhd:24:5  */
  always @*
    case (n2177_o)
      8'b10000000: n2257_o = 2'b00;
      8'b01000000: n2257_o = 2'b00;
      8'b00100000: n2257_o = 2'b00;
      8'b00010000: n2257_o = 2'b10;
      8'b00001000: n2257_o = 2'b01;
      8'b00000100: n2257_o = 2'b00;
      8'b00000010: n2257_o = 2'b00;
      8'b00000001: n2257_o = 2'b10;
      default: n2257_o = 2'b00;
    endcase
endmodule

module bus_m
  (input  clk,
   input  rst,
   input  mem_we,
   input  [31:0] addr,
   input  [31:0] write_data,
   output dmem_we,
   output [7:0] gpio_out);
  reg [7:0] gpio_reg;
  wire gpio_sel;
  wire gpio_we;
  wire n2136_o;
  wire n2137_o;
  wire n2139_o;
  wire n2140_o;
  wire n2141_o;
  wire [7:0] n2145_o;
  wire [7:0] n2146_o;
  wire [7:0] n2148_o;
  reg [7:0] n2151_q;
  assign dmem_we = n2141_o; //(module output)
  assign gpio_out = gpio_reg; //(module output)
  /* BUS.vhd:25:8  */
  always @*
    gpio_reg = n2151_q; // (isignal)
  initial
    gpio_reg = 8'b00000000;
  /* BUS.vhd:27:8  */
  assign gpio_sel = n2137_o; // (signal)
  /* BUS.vhd:28:8  */
  assign gpio_we = n2139_o; // (signal)
  /* BUS.vhd:34:27  */
  assign n2136_o = addr == 32'b00000000000000000000000001000000;
  /* BUS.vhd:34:17  */
  assign n2137_o = n2136_o ? 1'b1 : 1'b0;
  /* BUS.vhd:37:19  */
  assign n2139_o = mem_we & gpio_sel;
  /* BUS.vhd:38:23  */
  assign n2140_o = ~gpio_sel;
  /* BUS.vhd:38:19  */
  assign n2141_o = mem_we & n2140_o;
  /* BUS.vhd:48:29  */
  assign n2145_o = write_data[7:0]; // extract
  /* BUS.vhd:47:5  */
  assign n2146_o = gpio_we ? n2145_o : gpio_reg;
  /* BUS.vhd:44:5  */
  assign n2148_o = rst ? 8'b00000000 : n2146_o;
  /* BUS.vhd:43:3  */
  always @(posedge clk)
    n2151_q <= n2148_o;
  initial
    n2151_q = 8'b00000000;
endmodule

module branch_pred
  (input  clk,
   input  rst,
   input  [31:0] pc_f,
   input  [31:0] pc_e,
   input  actual_taken_e,
   input  update_en_e,
   input  [31:0] actual_target_e,
   output predict_taken_f,
   output [1:0] debug_counter_f,
   output [31:0] predicted_target_f,
   output btb_valid_f);
  reg [31:0] bht;
  wire [3:0] index_f;
  wire [3:0] index_e;
  reg [511:0] btb;
  reg [15:0] btb_valid;
  reg [511:0] btb_tag;
  wire btb_hit_f;
  wire [3:0] n906_o;
  wire [3:0] n908_o;
  wire [3:0] n911_o;
  wire [3:0] n918_o;
  wire n921_o;
  wire n922_o;
  wire n923_o;
  wire [3:0] n926_o;
  wire n929_o;
  wire [3:0] n931_o;
  wire [3:0] n937_o;
  wire [3:0] n941_o;
  wire n946_o;
  wire [3:0] n948_o;
  wire n953_o;
  wire [3:0] n955_o;
  wire n960_o;
  wire [3:0] n962_o;
  wire n967_o;
  wire [3:0] n969_o;
  wire [3:0] n973_o;
  reg [31:0] n974_o;
  wire [3:0] n976_o;
  wire [3:0] n980_o;
  wire n986_o;
  wire [3:0] n988_o;
  wire [3:0] n992_o;
  wire n997_o;
  wire [3:0] n999_o;
  wire n1004_o;
  wire [3:0] n1006_o;
  wire n1011_o;
  wire [3:0] n1013_o;
  wire n1018_o;
  wire [3:0] n1020_o;
  wire [3:0] n1024_o;
  reg [31:0] n1025_o;
  wire [31:0] n1026_o;
  wire [31:0] n1027_o;
  wire [511:0] n1028_o;
  wire [15:0] n1029_o;
  wire [511:0] n1030_o;
  wire [31:0] n1031_o;
  wire n1032_o;
  wire n1033_o;
  wire n1034_o;
  wire [31:0] n1036_o;
  wire [511:0] n1038_o;
  wire [15:0] n1040_o;
  wire [511:0] n1042_o;
  reg [31:0] n1048_q;
  reg [511:0] n1049_q;
  reg [15:0] n1050_q;
  reg [511:0] n1051_q;
  wire [1:0] n1052_o;
  wire [1:0] n1053_o;
  wire [1:0] n1054_o;
  wire [1:0] n1055_o;
  wire [1:0] n1056_o;
  wire [1:0] n1057_o;
  wire [1:0] n1058_o;
  wire [1:0] n1059_o;
  wire [1:0] n1060_o;
  wire [1:0] n1061_o;
  wire [1:0] n1062_o;
  wire [1:0] n1063_o;
  wire [1:0] n1064_o;
  wire [1:0] n1065_o;
  wire [1:0] n1066_o;
  wire [1:0] n1067_o;
  wire [1:0] n1068_o;
  reg [1:0] n1069_o;
  wire [1:0] n1070_o;
  reg [1:0] n1071_o;
  wire [1:0] n1072_o;
  reg [1:0] n1073_o;
  wire [1:0] n1074_o;
  reg [1:0] n1075_o;
  wire [1:0] n1076_o;
  reg [1:0] n1077_o;
  wire n1078_o;
  wire n1079_o;
  wire n1080_o;
  wire n1081_o;
  wire n1082_o;
  wire n1083_o;
  wire n1084_o;
  wire n1085_o;
  wire n1086_o;
  wire n1087_o;
  wire n1088_o;
  wire n1089_o;
  wire n1090_o;
  wire n1091_o;
  wire n1092_o;
  wire n1093_o;
  wire [1:0] n1094_o;
  reg n1095_o;
  wire [1:0] n1096_o;
  reg n1097_o;
  wire [1:0] n1098_o;
  reg n1099_o;
  wire [1:0] n1100_o;
  reg n1101_o;
  wire [1:0] n1102_o;
  reg n1103_o;
  wire [31:0] n1104_o;
  wire [31:0] n1105_o;
  wire [31:0] n1106_o;
  wire [31:0] n1107_o;
  wire [31:0] n1108_o;
  wire [31:0] n1109_o;
  wire [31:0] n1110_o;
  wire [31:0] n1111_o;
  wire [31:0] n1112_o;
  wire [31:0] n1113_o;
  wire [31:0] n1114_o;
  wire [31:0] n1115_o;
  wire [31:0] n1116_o;
  wire [31:0] n1117_o;
  wire [31:0] n1118_o;
  wire [31:0] n1119_o;
  wire [1:0] n1120_o;
  reg [31:0] n1121_o;
  wire [1:0] n1122_o;
  reg [31:0] n1123_o;
  wire [1:0] n1124_o;
  reg [31:0] n1125_o;
  wire [1:0] n1126_o;
  reg [31:0] n1127_o;
  wire [1:0] n1128_o;
  reg [31:0] n1129_o;
  wire n1130_o;
  wire n1131_o;
  wire n1132_o;
  wire n1133_o;
  wire n1134_o;
  wire n1135_o;
  wire n1136_o;
  wire n1137_o;
  wire n1138_o;
  wire n1139_o;
  wire n1140_o;
  wire n1141_o;
  wire n1142_o;
  wire n1143_o;
  wire n1144_o;
  wire n1145_o;
  wire [1:0] n1146_o;
  reg n1147_o;
  wire [1:0] n1148_o;
  reg n1149_o;
  wire [1:0] n1150_o;
  reg n1151_o;
  wire [1:0] n1152_o;
  reg n1153_o;
  wire [1:0] n1154_o;
  reg n1155_o;
  wire [31:0] n1156_o;
  wire [31:0] n1157_o;
  wire [31:0] n1158_o;
  wire [31:0] n1159_o;
  wire [31:0] n1160_o;
  wire [31:0] n1161_o;
  wire [31:0] n1162_o;
  wire [31:0] n1163_o;
  wire [31:0] n1164_o;
  wire [31:0] n1165_o;
  wire [31:0] n1166_o;
  wire [31:0] n1167_o;
  wire [31:0] n1168_o;
  wire [31:0] n1169_o;
  wire [31:0] n1170_o;
  wire [31:0] n1171_o;
  wire [1:0] n1172_o;
  reg [31:0] n1173_o;
  wire [1:0] n1174_o;
  reg [31:0] n1175_o;
  wire [1:0] n1176_o;
  reg [31:0] n1177_o;
  wire [1:0] n1178_o;
  reg [31:0] n1179_o;
  wire [1:0] n1180_o;
  reg [31:0] n1181_o;
  wire [1:0] n1182_o;
  wire [1:0] n1183_o;
  wire [1:0] n1184_o;
  wire [1:0] n1185_o;
  wire [1:0] n1186_o;
  wire [1:0] n1187_o;
  wire [1:0] n1188_o;
  wire [1:0] n1189_o;
  wire [1:0] n1190_o;
  wire [1:0] n1191_o;
  wire [1:0] n1192_o;
  wire [1:0] n1193_o;
  wire [1:0] n1194_o;
  wire [1:0] n1195_o;
  wire [1:0] n1196_o;
  wire [1:0] n1197_o;
  wire [1:0] n1198_o;
  reg [1:0] n1199_o;
  wire [1:0] n1200_o;
  reg [1:0] n1201_o;
  wire [1:0] n1202_o;
  reg [1:0] n1203_o;
  wire [1:0] n1204_o;
  reg [1:0] n1205_o;
  wire [1:0] n1206_o;
  reg [1:0] n1207_o;
  wire n1208_o;
  wire n1209_o;
  wire n1210_o;
  wire n1211_o;
  wire n1212_o;
  wire n1213_o;
  wire n1214_o;
  wire n1215_o;
  wire n1216_o;
  wire n1217_o;
  wire n1218_o;
  wire n1219_o;
  wire n1220_o;
  wire n1221_o;
  wire n1222_o;
  wire n1223_o;
  wire n1224_o;
  wire n1225_o;
  wire n1226_o;
  wire n1227_o;
  wire n1228_o;
  wire n1229_o;
  wire n1230_o;
  wire n1231_o;
  wire n1232_o;
  wire n1233_o;
  wire n1234_o;
  wire n1235_o;
  wire n1236_o;
  wire n1237_o;
  wire n1238_o;
  wire n1239_o;
  wire n1240_o;
  wire n1241_o;
  wire n1242_o;
  wire n1243_o;
  wire [1:0] n1244_o;
  wire [1:0] n1245_o;
  wire [1:0] n1246_o;
  wire [1:0] n1247_o;
  wire [1:0] n1248_o;
  wire [1:0] n1249_o;
  wire [1:0] n1250_o;
  wire [1:0] n1251_o;
  wire [1:0] n1252_o;
  wire [1:0] n1253_o;
  wire [1:0] n1254_o;
  wire [1:0] n1255_o;
  wire [1:0] n1256_o;
  wire [1:0] n1257_o;
  wire [1:0] n1258_o;
  wire [1:0] n1259_o;
  wire [1:0] n1260_o;
  wire [1:0] n1261_o;
  wire [1:0] n1262_o;
  wire [1:0] n1263_o;
  wire [1:0] n1264_o;
  wire [1:0] n1265_o;
  wire [1:0] n1266_o;
  wire [1:0] n1267_o;
  wire [1:0] n1268_o;
  wire [1:0] n1269_o;
  wire [1:0] n1270_o;
  wire [1:0] n1271_o;
  wire [1:0] n1272_o;
  wire [1:0] n1273_o;
  wire [1:0] n1274_o;
  wire [1:0] n1275_o;
  wire [31:0] n1276_o;
  wire n1277_o;
  wire n1278_o;
  wire n1279_o;
  wire n1280_o;
  wire n1281_o;
  wire n1282_o;
  wire n1283_o;
  wire n1284_o;
  wire n1285_o;
  wire n1286_o;
  wire n1287_o;
  wire n1288_o;
  wire n1289_o;
  wire n1290_o;
  wire n1291_o;
  wire n1292_o;
  wire n1293_o;
  wire n1294_o;
  wire n1295_o;
  wire n1296_o;
  wire n1297_o;
  wire n1298_o;
  wire n1299_o;
  wire n1300_o;
  wire n1301_o;
  wire n1302_o;
  wire n1303_o;
  wire n1304_o;
  wire n1305_o;
  wire n1306_o;
  wire n1307_o;
  wire n1308_o;
  wire n1309_o;
  wire n1310_o;
  wire n1311_o;
  wire n1312_o;
  wire [1:0] n1313_o;
  wire [1:0] n1314_o;
  wire [1:0] n1315_o;
  wire [1:0] n1316_o;
  wire [1:0] n1317_o;
  wire [1:0] n1318_o;
  wire [1:0] n1319_o;
  wire [1:0] n1320_o;
  wire [1:0] n1321_o;
  wire [1:0] n1322_o;
  wire [1:0] n1323_o;
  wire [1:0] n1324_o;
  wire [1:0] n1325_o;
  wire [1:0] n1326_o;
  wire [1:0] n1327_o;
  wire [1:0] n1328_o;
  wire [1:0] n1329_o;
  wire [1:0] n1330_o;
  wire [1:0] n1331_o;
  wire [1:0] n1332_o;
  wire [1:0] n1333_o;
  wire [1:0] n1334_o;
  wire [1:0] n1335_o;
  wire [1:0] n1336_o;
  wire [1:0] n1337_o;
  wire [1:0] n1338_o;
  wire [1:0] n1339_o;
  wire [1:0] n1340_o;
  wire [1:0] n1341_o;
  wire [1:0] n1342_o;
  wire [1:0] n1343_o;
  wire [1:0] n1344_o;
  wire [31:0] n1345_o;
  wire n1346_o;
  wire n1347_o;
  wire n1348_o;
  wire n1349_o;
  wire n1350_o;
  wire n1351_o;
  wire n1352_o;
  wire n1353_o;
  wire n1354_o;
  wire n1355_o;
  wire n1356_o;
  wire n1357_o;
  wire n1358_o;
  wire n1359_o;
  wire n1360_o;
  wire n1361_o;
  wire n1362_o;
  wire n1363_o;
  wire n1364_o;
  wire n1365_o;
  wire n1366_o;
  wire n1367_o;
  wire n1368_o;
  wire n1369_o;
  wire n1370_o;
  wire n1371_o;
  wire n1372_o;
  wire n1373_o;
  wire n1374_o;
  wire n1375_o;
  wire n1376_o;
  wire n1377_o;
  wire n1378_o;
  wire n1379_o;
  wire n1380_o;
  wire n1381_o;
  wire [1:0] n1382_o;
  wire [1:0] n1383_o;
  wire [1:0] n1384_o;
  wire [1:0] n1385_o;
  wire [1:0] n1386_o;
  wire [1:0] n1387_o;
  wire [1:0] n1388_o;
  wire [1:0] n1389_o;
  wire [1:0] n1390_o;
  wire [1:0] n1391_o;
  wire [1:0] n1392_o;
  wire [1:0] n1393_o;
  wire [1:0] n1394_o;
  wire [1:0] n1395_o;
  wire [1:0] n1396_o;
  wire [1:0] n1397_o;
  wire [1:0] n1398_o;
  wire [1:0] n1399_o;
  wire [1:0] n1400_o;
  wire [1:0] n1401_o;
  wire [1:0] n1402_o;
  wire [1:0] n1403_o;
  wire [1:0] n1404_o;
  wire [1:0] n1405_o;
  wire [1:0] n1406_o;
  wire [1:0] n1407_o;
  wire [1:0] n1408_o;
  wire [1:0] n1409_o;
  wire [1:0] n1410_o;
  wire [1:0] n1411_o;
  wire [1:0] n1412_o;
  wire [1:0] n1413_o;
  wire [31:0] n1414_o;
  wire n1415_o;
  wire n1416_o;
  wire n1417_o;
  wire n1418_o;
  wire n1419_o;
  wire n1420_o;
  wire n1421_o;
  wire n1422_o;
  wire n1423_o;
  wire n1424_o;
  wire n1425_o;
  wire n1426_o;
  wire n1427_o;
  wire n1428_o;
  wire n1429_o;
  wire n1430_o;
  wire n1431_o;
  wire n1432_o;
  wire n1433_o;
  wire n1434_o;
  wire n1435_o;
  wire n1436_o;
  wire n1437_o;
  wire n1438_o;
  wire n1439_o;
  wire n1440_o;
  wire n1441_o;
  wire n1442_o;
  wire n1443_o;
  wire n1444_o;
  wire n1445_o;
  wire n1446_o;
  wire n1447_o;
  wire n1448_o;
  wire n1449_o;
  wire n1450_o;
  wire [1:0] n1451_o;
  wire [1:0] n1452_o;
  wire [1:0] n1453_o;
  wire [1:0] n1454_o;
  wire [1:0] n1455_o;
  wire [1:0] n1456_o;
  wire [1:0] n1457_o;
  wire [1:0] n1458_o;
  wire [1:0] n1459_o;
  wire [1:0] n1460_o;
  wire [1:0] n1461_o;
  wire [1:0] n1462_o;
  wire [1:0] n1463_o;
  wire [1:0] n1464_o;
  wire [1:0] n1465_o;
  wire [1:0] n1466_o;
  wire [1:0] n1467_o;
  wire [1:0] n1468_o;
  wire [1:0] n1469_o;
  wire [1:0] n1470_o;
  wire [1:0] n1471_o;
  wire [1:0] n1472_o;
  wire [1:0] n1473_o;
  wire [1:0] n1474_o;
  wire [1:0] n1475_o;
  wire [1:0] n1476_o;
  wire [1:0] n1477_o;
  wire [1:0] n1478_o;
  wire [1:0] n1479_o;
  wire [1:0] n1480_o;
  wire [1:0] n1481_o;
  wire [1:0] n1482_o;
  wire [31:0] n1483_o;
  wire n1484_o;
  wire n1485_o;
  wire n1486_o;
  wire n1487_o;
  wire n1488_o;
  wire n1489_o;
  wire n1490_o;
  wire n1491_o;
  wire n1492_o;
  wire n1493_o;
  wire n1494_o;
  wire n1495_o;
  wire n1496_o;
  wire n1497_o;
  wire n1498_o;
  wire n1499_o;
  wire n1500_o;
  wire n1501_o;
  wire n1502_o;
  wire n1503_o;
  wire n1504_o;
  wire n1505_o;
  wire n1506_o;
  wire n1507_o;
  wire n1508_o;
  wire n1509_o;
  wire n1510_o;
  wire n1511_o;
  wire n1512_o;
  wire n1513_o;
  wire n1514_o;
  wire n1515_o;
  wire n1516_o;
  wire n1517_o;
  wire n1518_o;
  wire n1519_o;
  wire [1:0] n1520_o;
  wire [1:0] n1521_o;
  wire [1:0] n1522_o;
  wire [1:0] n1523_o;
  wire [1:0] n1524_o;
  wire [1:0] n1525_o;
  wire [1:0] n1526_o;
  wire [1:0] n1527_o;
  wire [1:0] n1528_o;
  wire [1:0] n1529_o;
  wire [1:0] n1530_o;
  wire [1:0] n1531_o;
  wire [1:0] n1532_o;
  wire [1:0] n1533_o;
  wire [1:0] n1534_o;
  wire [1:0] n1535_o;
  wire [1:0] n1536_o;
  wire [1:0] n1537_o;
  wire [1:0] n1538_o;
  wire [1:0] n1539_o;
  wire [1:0] n1540_o;
  wire [1:0] n1541_o;
  wire [1:0] n1542_o;
  wire [1:0] n1543_o;
  wire [1:0] n1544_o;
  wire [1:0] n1545_o;
  wire [1:0] n1546_o;
  wire [1:0] n1547_o;
  wire [1:0] n1548_o;
  wire [1:0] n1549_o;
  wire [1:0] n1550_o;
  wire [1:0] n1551_o;
  wire [31:0] n1552_o;
  wire n1553_o;
  wire n1554_o;
  wire n1555_o;
  wire n1556_o;
  wire n1557_o;
  wire n1558_o;
  wire n1559_o;
  wire n1560_o;
  wire n1561_o;
  wire n1562_o;
  wire n1563_o;
  wire n1564_o;
  wire n1565_o;
  wire n1566_o;
  wire n1567_o;
  wire n1568_o;
  wire n1569_o;
  wire n1570_o;
  wire n1571_o;
  wire n1572_o;
  wire n1573_o;
  wire n1574_o;
  wire n1575_o;
  wire n1576_o;
  wire n1577_o;
  wire n1578_o;
  wire n1579_o;
  wire n1580_o;
  wire n1581_o;
  wire n1582_o;
  wire n1583_o;
  wire n1584_o;
  wire n1585_o;
  wire n1586_o;
  wire n1587_o;
  wire n1588_o;
  wire [31:0] n1589_o;
  wire [31:0] n1590_o;
  wire [31:0] n1591_o;
  wire [31:0] n1592_o;
  wire [31:0] n1593_o;
  wire [31:0] n1594_o;
  wire [31:0] n1595_o;
  wire [31:0] n1596_o;
  wire [31:0] n1597_o;
  wire [31:0] n1598_o;
  wire [31:0] n1599_o;
  wire [31:0] n1600_o;
  wire [31:0] n1601_o;
  wire [31:0] n1602_o;
  wire [31:0] n1603_o;
  wire [31:0] n1604_o;
  wire [31:0] n1605_o;
  wire [31:0] n1606_o;
  wire [31:0] n1607_o;
  wire [31:0] n1608_o;
  wire [31:0] n1609_o;
  wire [31:0] n1610_o;
  wire [31:0] n1611_o;
  wire [31:0] n1612_o;
  wire [31:0] n1613_o;
  wire [31:0] n1614_o;
  wire [31:0] n1615_o;
  wire [31:0] n1616_o;
  wire [31:0] n1617_o;
  wire [31:0] n1618_o;
  wire [31:0] n1619_o;
  wire [31:0] n1620_o;
  wire [511:0] n1621_o;
  wire n1622_o;
  wire n1623_o;
  wire n1624_o;
  wire n1625_o;
  wire n1626_o;
  wire n1627_o;
  wire n1628_o;
  wire n1629_o;
  wire n1630_o;
  wire n1631_o;
  wire n1632_o;
  wire n1633_o;
  wire n1634_o;
  wire n1635_o;
  wire n1636_o;
  wire n1637_o;
  wire n1638_o;
  wire n1639_o;
  wire n1640_o;
  wire n1641_o;
  wire n1642_o;
  wire n1643_o;
  wire n1644_o;
  wire n1645_o;
  wire n1646_o;
  wire n1647_o;
  wire n1648_o;
  wire n1649_o;
  wire n1650_o;
  wire n1651_o;
  wire n1652_o;
  wire n1653_o;
  wire n1654_o;
  wire n1655_o;
  wire n1656_o;
  wire n1657_o;
  wire [31:0] n1658_o;
  wire [31:0] n1659_o;
  wire [31:0] n1660_o;
  wire [31:0] n1661_o;
  wire [31:0] n1662_o;
  wire [31:0] n1663_o;
  wire [31:0] n1664_o;
  wire [31:0] n1665_o;
  wire [31:0] n1666_o;
  wire [31:0] n1667_o;
  wire [31:0] n1668_o;
  wire [31:0] n1669_o;
  wire [31:0] n1670_o;
  wire [31:0] n1671_o;
  wire [31:0] n1672_o;
  wire [31:0] n1673_o;
  wire [31:0] n1674_o;
  wire [31:0] n1675_o;
  wire [31:0] n1676_o;
  wire [31:0] n1677_o;
  wire [31:0] n1678_o;
  wire [31:0] n1679_o;
  wire [31:0] n1680_o;
  wire [31:0] n1681_o;
  wire [31:0] n1682_o;
  wire [31:0] n1683_o;
  wire [31:0] n1684_o;
  wire [31:0] n1685_o;
  wire [31:0] n1686_o;
  wire [31:0] n1687_o;
  wire [31:0] n1688_o;
  wire [31:0] n1689_o;
  wire [511:0] n1690_o;
  wire n1691_o;
  wire n1692_o;
  wire n1693_o;
  wire n1694_o;
  wire n1695_o;
  wire n1696_o;
  wire n1697_o;
  wire n1698_o;
  wire n1699_o;
  wire n1700_o;
  wire n1701_o;
  wire n1702_o;
  wire n1703_o;
  wire n1704_o;
  wire n1705_o;
  wire n1706_o;
  wire n1707_o;
  wire n1708_o;
  wire n1709_o;
  wire n1710_o;
  wire n1711_o;
  wire n1712_o;
  wire n1713_o;
  wire n1714_o;
  wire n1715_o;
  wire n1716_o;
  wire n1717_o;
  wire n1718_o;
  wire n1719_o;
  wire n1720_o;
  wire n1721_o;
  wire n1722_o;
  wire n1723_o;
  wire n1724_o;
  wire n1725_o;
  wire n1726_o;
  wire n1727_o;
  wire n1728_o;
  wire n1729_o;
  wire n1730_o;
  wire n1731_o;
  wire n1732_o;
  wire n1733_o;
  wire n1734_o;
  wire n1735_o;
  wire n1736_o;
  wire n1737_o;
  wire n1738_o;
  wire n1739_o;
  wire n1740_o;
  wire n1741_o;
  wire n1742_o;
  wire n1743_o;
  wire n1744_o;
  wire n1745_o;
  wire n1746_o;
  wire n1747_o;
  wire n1748_o;
  wire n1749_o;
  wire n1750_o;
  wire n1751_o;
  wire n1752_o;
  wire n1753_o;
  wire n1754_o;
  wire n1755_o;
  wire n1756_o;
  wire n1757_o;
  wire n1758_o;
  wire [15:0] n1759_o;
  wire [1:0] n1760_o;
  wire [1:0] n1761_o;
  wire [1:0] n1762_o;
  wire [1:0] n1763_o;
  wire [1:0] n1764_o;
  wire [1:0] n1765_o;
  wire [1:0] n1766_o;
  wire [1:0] n1767_o;
  wire [1:0] n1768_o;
  wire [1:0] n1769_o;
  wire [1:0] n1770_o;
  wire [1:0] n1771_o;
  wire [1:0] n1772_o;
  wire [1:0] n1773_o;
  wire [1:0] n1774_o;
  wire [1:0] n1775_o;
  wire [1:0] n1776_o;
  reg [1:0] n1777_o;
  wire [1:0] n1778_o;
  reg [1:0] n1779_o;
  wire [1:0] n1780_o;
  reg [1:0] n1781_o;
  wire [1:0] n1782_o;
  reg [1:0] n1783_o;
  wire [1:0] n1784_o;
  reg [1:0] n1785_o;
  wire n1786_o;
  wire n1787_o;
  wire n1788_o;
  wire n1789_o;
  wire n1790_o;
  wire n1791_o;
  wire n1792_o;
  wire n1793_o;
  wire n1794_o;
  wire n1795_o;
  wire n1796_o;
  wire n1797_o;
  wire n1798_o;
  wire n1799_o;
  wire n1800_o;
  wire n1801_o;
  wire n1802_o;
  wire n1803_o;
  wire n1804_o;
  wire n1805_o;
  wire n1806_o;
  wire n1807_o;
  wire n1808_o;
  wire n1809_o;
  wire n1810_o;
  wire n1811_o;
  wire n1812_o;
  wire n1813_o;
  wire n1814_o;
  wire n1815_o;
  wire n1816_o;
  wire n1817_o;
  wire n1818_o;
  wire n1819_o;
  wire n1820_o;
  wire n1821_o;
  wire [1:0] n1822_o;
  wire [1:0] n1823_o;
  wire [1:0] n1824_o;
  wire [1:0] n1825_o;
  wire [1:0] n1826_o;
  wire [1:0] n1827_o;
  wire [1:0] n1828_o;
  wire [1:0] n1829_o;
  wire [1:0] n1830_o;
  wire [1:0] n1831_o;
  wire [1:0] n1832_o;
  wire [1:0] n1833_o;
  wire [1:0] n1834_o;
  wire [1:0] n1835_o;
  wire [1:0] n1836_o;
  wire [1:0] n1837_o;
  wire [1:0] n1838_o;
  wire [1:0] n1839_o;
  wire [1:0] n1840_o;
  wire [1:0] n1841_o;
  wire [1:0] n1842_o;
  wire [1:0] n1843_o;
  wire [1:0] n1844_o;
  wire [1:0] n1845_o;
  wire [1:0] n1846_o;
  wire [1:0] n1847_o;
  wire [1:0] n1848_o;
  wire [1:0] n1849_o;
  wire [1:0] n1850_o;
  wire [1:0] n1851_o;
  wire [1:0] n1852_o;
  wire [1:0] n1853_o;
  wire [31:0] n1854_o;
  wire n1855_o;
  wire n1856_o;
  wire n1857_o;
  wire n1858_o;
  wire n1859_o;
  wire n1860_o;
  wire n1861_o;
  wire n1862_o;
  wire n1863_o;
  wire n1864_o;
  wire n1865_o;
  wire n1866_o;
  wire n1867_o;
  wire n1868_o;
  wire n1869_o;
  wire n1870_o;
  wire n1871_o;
  wire n1872_o;
  wire n1873_o;
  wire n1874_o;
  wire n1875_o;
  wire n1876_o;
  wire n1877_o;
  wire n1878_o;
  wire n1879_o;
  wire n1880_o;
  wire n1881_o;
  wire n1882_o;
  wire n1883_o;
  wire n1884_o;
  wire n1885_o;
  wire n1886_o;
  wire n1887_o;
  wire n1888_o;
  wire n1889_o;
  wire n1890_o;
  wire [1:0] n1891_o;
  wire [1:0] n1892_o;
  wire [1:0] n1893_o;
  wire [1:0] n1894_o;
  wire [1:0] n1895_o;
  wire [1:0] n1896_o;
  wire [1:0] n1897_o;
  wire [1:0] n1898_o;
  wire [1:0] n1899_o;
  wire [1:0] n1900_o;
  wire [1:0] n1901_o;
  wire [1:0] n1902_o;
  wire [1:0] n1903_o;
  wire [1:0] n1904_o;
  wire [1:0] n1905_o;
  wire [1:0] n1906_o;
  wire [1:0] n1907_o;
  wire [1:0] n1908_o;
  wire [1:0] n1909_o;
  wire [1:0] n1910_o;
  wire [1:0] n1911_o;
  wire [1:0] n1912_o;
  wire [1:0] n1913_o;
  wire [1:0] n1914_o;
  wire [1:0] n1915_o;
  wire [1:0] n1916_o;
  wire [1:0] n1917_o;
  wire [1:0] n1918_o;
  wire [1:0] n1919_o;
  wire [1:0] n1920_o;
  wire [1:0] n1921_o;
  wire [1:0] n1922_o;
  wire [31:0] n1923_o;
  wire n1924_o;
  wire n1925_o;
  wire n1926_o;
  wire n1927_o;
  wire n1928_o;
  wire n1929_o;
  wire n1930_o;
  wire n1931_o;
  wire n1932_o;
  wire n1933_o;
  wire n1934_o;
  wire n1935_o;
  wire n1936_o;
  wire n1937_o;
  wire n1938_o;
  wire n1939_o;
  wire n1940_o;
  wire n1941_o;
  wire n1942_o;
  wire n1943_o;
  wire n1944_o;
  wire n1945_o;
  wire n1946_o;
  wire n1947_o;
  wire n1948_o;
  wire n1949_o;
  wire n1950_o;
  wire n1951_o;
  wire n1952_o;
  wire n1953_o;
  wire n1954_o;
  wire n1955_o;
  wire n1956_o;
  wire n1957_o;
  wire n1958_o;
  wire n1959_o;
  wire [1:0] n1960_o;
  wire [1:0] n1961_o;
  wire [1:0] n1962_o;
  wire [1:0] n1963_o;
  wire [1:0] n1964_o;
  wire [1:0] n1965_o;
  wire [1:0] n1966_o;
  wire [1:0] n1967_o;
  wire [1:0] n1968_o;
  wire [1:0] n1969_o;
  wire [1:0] n1970_o;
  wire [1:0] n1971_o;
  wire [1:0] n1972_o;
  wire [1:0] n1973_o;
  wire [1:0] n1974_o;
  wire [1:0] n1975_o;
  wire [1:0] n1976_o;
  wire [1:0] n1977_o;
  wire [1:0] n1978_o;
  wire [1:0] n1979_o;
  wire [1:0] n1980_o;
  wire [1:0] n1981_o;
  wire [1:0] n1982_o;
  wire [1:0] n1983_o;
  wire [1:0] n1984_o;
  wire [1:0] n1985_o;
  wire [1:0] n1986_o;
  wire [1:0] n1987_o;
  wire [1:0] n1988_o;
  wire [1:0] n1989_o;
  wire [1:0] n1990_o;
  wire [1:0] n1991_o;
  wire [31:0] n1992_o;
  wire n1993_o;
  wire n1994_o;
  wire n1995_o;
  wire n1996_o;
  wire n1997_o;
  wire n1998_o;
  wire n1999_o;
  wire n2000_o;
  wire n2001_o;
  wire n2002_o;
  wire n2003_o;
  wire n2004_o;
  wire n2005_o;
  wire n2006_o;
  wire n2007_o;
  wire n2008_o;
  wire n2009_o;
  wire n2010_o;
  wire n2011_o;
  wire n2012_o;
  wire n2013_o;
  wire n2014_o;
  wire n2015_o;
  wire n2016_o;
  wire n2017_o;
  wire n2018_o;
  wire n2019_o;
  wire n2020_o;
  wire n2021_o;
  wire n2022_o;
  wire n2023_o;
  wire n2024_o;
  wire n2025_o;
  wire n2026_o;
  wire n2027_o;
  wire n2028_o;
  wire [1:0] n2029_o;
  wire [1:0] n2030_o;
  wire [1:0] n2031_o;
  wire [1:0] n2032_o;
  wire [1:0] n2033_o;
  wire [1:0] n2034_o;
  wire [1:0] n2035_o;
  wire [1:0] n2036_o;
  wire [1:0] n2037_o;
  wire [1:0] n2038_o;
  wire [1:0] n2039_o;
  wire [1:0] n2040_o;
  wire [1:0] n2041_o;
  wire [1:0] n2042_o;
  wire [1:0] n2043_o;
  wire [1:0] n2044_o;
  wire [1:0] n2045_o;
  wire [1:0] n2046_o;
  wire [1:0] n2047_o;
  wire [1:0] n2048_o;
  wire [1:0] n2049_o;
  wire [1:0] n2050_o;
  wire [1:0] n2051_o;
  wire [1:0] n2052_o;
  wire [1:0] n2053_o;
  wire [1:0] n2054_o;
  wire [1:0] n2055_o;
  wire [1:0] n2056_o;
  wire [1:0] n2057_o;
  wire [1:0] n2058_o;
  wire [1:0] n2059_o;
  wire [1:0] n2060_o;
  wire [31:0] n2061_o;
  wire n2062_o;
  wire n2063_o;
  wire n2064_o;
  wire n2065_o;
  wire n2066_o;
  wire n2067_o;
  wire n2068_o;
  wire n2069_o;
  wire n2070_o;
  wire n2071_o;
  wire n2072_o;
  wire n2073_o;
  wire n2074_o;
  wire n2075_o;
  wire n2076_o;
  wire n2077_o;
  wire n2078_o;
  wire n2079_o;
  wire n2080_o;
  wire n2081_o;
  wire n2082_o;
  wire n2083_o;
  wire n2084_o;
  wire n2085_o;
  wire n2086_o;
  wire n2087_o;
  wire n2088_o;
  wire n2089_o;
  wire n2090_o;
  wire n2091_o;
  wire n2092_o;
  wire n2093_o;
  wire n2094_o;
  wire n2095_o;
  wire n2096_o;
  wire n2097_o;
  wire [1:0] n2098_o;
  wire [1:0] n2099_o;
  wire [1:0] n2100_o;
  wire [1:0] n2101_o;
  wire [1:0] n2102_o;
  wire [1:0] n2103_o;
  wire [1:0] n2104_o;
  wire [1:0] n2105_o;
  wire [1:0] n2106_o;
  wire [1:0] n2107_o;
  wire [1:0] n2108_o;
  wire [1:0] n2109_o;
  wire [1:0] n2110_o;
  wire [1:0] n2111_o;
  wire [1:0] n2112_o;
  wire [1:0] n2113_o;
  wire [1:0] n2114_o;
  wire [1:0] n2115_o;
  wire [1:0] n2116_o;
  wire [1:0] n2117_o;
  wire [1:0] n2118_o;
  wire [1:0] n2119_o;
  wire [1:0] n2120_o;
  wire [1:0] n2121_o;
  wire [1:0] n2122_o;
  wire [1:0] n2123_o;
  wire [1:0] n2124_o;
  wire [1:0] n2125_o;
  wire [1:0] n2126_o;
  wire [1:0] n2127_o;
  wire [1:0] n2128_o;
  wire [1:0] n2129_o;
  wire [31:0] n2130_o;
  assign predict_taken_f = n929_o; //(module output)
  assign debug_counter_f = n1077_o; //(module output)
  assign predicted_target_f = n1181_o; //(module output)
  assign btb_valid_f = btb_hit_f; //(module output)
  /* BRANCH_PRED.vhd:23:8  */
  always @*
    bht = n1048_q; // (isignal)
  initial
    bht = 32'b01010101010101010101010101010101;
  /* BRANCH_PRED.vhd:24:8  */
  assign index_f = n906_o; // (signal)
  /* BRANCH_PRED.vhd:25:8  */
  assign index_e = n908_o; // (signal)
  /* BRANCH_PRED.vhd:28:8  */
  always @*
    btb = n1049_q; // (isignal)
  initial
    btb = 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* BRANCH_PRED.vhd:30:8  */
  always @*
    btb_valid = n1050_q; // (isignal)
  initial
    btb_valid = 16'b0000000000000000;
  /* BRANCH_PRED.vhd:33:8  */
  always @*
    btb_tag = n1051_q; // (isignal)
  initial
    btb_tag = 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* BRANCH_PRED.vhd:35:8  */
  assign btb_hit_f = n923_o; // (signal)
  /* BRANCH_PRED.vhd:39:36  */
  assign n906_o = pc_f[5:2]; // extract
  /* BRANCH_PRED.vhd:40:36  */
  assign n908_o = pc_e[5:2]; // extract
  /* BRANCH_PRED.vhd:43:24  */
  assign n911_o = 4'b1111 - index_f;
  /* BRANCH_PRED.vhd:45:60  */
  assign n918_o = 4'b1111 - index_f;
  /* BRANCH_PRED.vhd:45:69  */
  assign n921_o = n1129_o == pc_f;
  /* BRANCH_PRED.vhd:45:48  */
  assign n922_o = n921_o & n1103_o;
  /* BRANCH_PRED.vhd:45:18  */
  assign n923_o = n922_o ? 1'b1 : 1'b0;
  /* BRANCH_PRED.vhd:46:27  */
  assign n926_o = 4'b1111 - index_f;
  /* BRANCH_PRED.vhd:46:39  */
  assign n929_o = n1155_o & btb_hit_f;
  /* BRANCH_PRED.vhd:47:27  */
  assign n931_o = 4'b1111 - index_f;
  /* BRANCH_PRED.vhd:62:15  */
  assign n937_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:64:10  */
  assign n941_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:63:6  */
  assign n946_o = n1207_o == 2'b00;
  /* BRANCH_PRED.vhd:66:10  */
  assign n948_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:65:6  */
  assign n953_o = n1207_o == 2'b01;
  /* BRANCH_PRED.vhd:68:10  */
  assign n955_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:67:6  */
  assign n960_o = n1207_o == 2'b10;
  /* BRANCH_PRED.vhd:70:10  */
  assign n962_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:69:6  */
  assign n967_o = n1207_o == 2'b11;
  /* BRANCH_PRED.vhd:72:10  */
  assign n969_o = 4'b1111 - index_e;
  assign n973_o = {n967_o, n960_o, n953_o, n946_o};
  /* BRANCH_PRED.vhd:62:6  */
  always @*
    case (n973_o)
      4'b1000: n974_o = n1483_o;
      4'b0100: n974_o = n1414_o;
      4'b0010: n974_o = n1345_o;
      4'b0001: n974_o = n1276_o;
      default: n974_o = n1552_o;
    endcase
  /* BRANCH_PRED.vhd:75:9  */
  assign n976_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:76:13  */
  assign n980_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:79:26  */
  assign n986_o = ~actual_taken_e;
  /* BRANCH_PRED.vhd:80:15  */
  assign n988_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:82:10  */
  assign n992_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:81:6  */
  assign n997_o = n1785_o == 2'b11;
  /* BRANCH_PRED.vhd:84:10  */
  assign n999_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:83:6  */
  assign n1004_o = n1785_o == 2'b10;
  /* BRANCH_PRED.vhd:86:10  */
  assign n1006_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:85:6  */
  assign n1011_o = n1785_o == 2'b01;
  /* BRANCH_PRED.vhd:88:10  */
  assign n1013_o = 4'b1111 - index_e;
  /* BRANCH_PRED.vhd:87:6  */
  assign n1018_o = n1785_o == 2'b00;
  /* BRANCH_PRED.vhd:90:10  */
  assign n1020_o = 4'b1111 - index_e;
  assign n1024_o = {n1018_o, n1011_o, n1004_o, n997_o};
  /* BRANCH_PRED.vhd:80:6  */
  always @*
    case (n1024_o)
      4'b1000: n1025_o = n2061_o;
      4'b0100: n1025_o = n1992_o;
      4'b0010: n1025_o = n1923_o;
      4'b0001: n1025_o = n1854_o;
      default: n1025_o = n2130_o;
    endcase
  /* BRANCH_PRED.vhd:79:5  */
  assign n1026_o = n986_o ? n1025_o : bht;
  /* BRANCH_PRED.vhd:61:4  */
  assign n1027_o = actual_taken_e ? n974_o : n1026_o;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1028_o = n1032_o ? n1621_o : btb;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1029_o = n1033_o ? n1759_o : btb_valid;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1030_o = n1034_o ? n1690_o : btb_tag;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1031_o = update_en_e ? n1027_o : bht;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1032_o = actual_taken_e & update_en_e;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1033_o = actual_taken_e & update_en_e;
  /* BRANCH_PRED.vhd:60:2  */
  assign n1034_o = actual_taken_e & update_en_e;
  /* BRANCH_PRED.vhd:54:2  */
  assign n1036_o = rst ? 32'b01010101010101010101010101010101 : n1031_o;
  /* BRANCH_PRED.vhd:54:2  */
  assign n1038_o = rst ? 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1028_o;
  /* BRANCH_PRED.vhd:54:2  */
  assign n1040_o = rst ? 16'b0000000000000000 : n1029_o;
  /* BRANCH_PRED.vhd:54:2  */
  assign n1042_o = rst ? 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : n1030_o;
  /* BRANCH_PRED.vhd:53:2  */
  always @(posedge clk)
    n1048_q <= n1036_o;
  initial
    n1048_q = 32'b01010101010101010101010101010101;
  /* BRANCH_PRED.vhd:53:2  */
  always @(posedge clk)
    n1049_q <= n1038_o;
  initial
    n1049_q = 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* BRANCH_PRED.vhd:53:2  */
  always @(posedge clk)
    n1050_q <= n1040_o;
  initial
    n1050_q = 16'b0000000000000000;
  /* BRANCH_PRED.vhd:53:2  */
  always @(posedge clk)
    n1051_q <= n1042_o;
  initial
    n1051_q = 512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /* BRANCH_PRED.vhd:15:5  */
  assign n1052_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:14:5  */
  assign n1053_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:12:6  */
  assign n1054_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:11:6  */
  assign n1055_o = bht[7:6]; // extract
  assign n1056_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:50:1  */
  assign n1057_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:40:12  */
  assign n1058_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:39:12  */
  assign n1059_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:53:2  */
  assign n1060_o = bht[17:16]; // extract
  assign n1061_o = bht[19:18]; // extract
  assign n1062_o = bht[21:20]; // extract
  assign n1063_o = bht[23:22]; // extract
  assign n1064_o = bht[25:24]; // extract
  assign n1065_o = bht[27:26]; // extract
  assign n1066_o = bht[29:28]; // extract
  assign n1067_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  assign n1068_o = n911_o[1:0]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  always @*
    case (n1068_o)
      2'b00: n1069_o = n1052_o;
      2'b01: n1069_o = n1053_o;
      2'b10: n1069_o = n1054_o;
      2'b11: n1069_o = n1055_o;
    endcase
  /* BRANCH_PRED.vhd:43:23  */
  assign n1070_o = n911_o[1:0]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  always @*
    case (n1070_o)
      2'b00: n1071_o = n1056_o;
      2'b01: n1071_o = n1057_o;
      2'b10: n1071_o = n1058_o;
      2'b11: n1071_o = n1059_o;
    endcase
  /* BRANCH_PRED.vhd:43:23  */
  assign n1072_o = n911_o[1:0]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  always @*
    case (n1072_o)
      2'b00: n1073_o = n1060_o;
      2'b01: n1073_o = n1061_o;
      2'b10: n1073_o = n1062_o;
      2'b11: n1073_o = n1063_o;
    endcase
  /* BRANCH_PRED.vhd:43:23  */
  assign n1074_o = n911_o[1:0]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  always @*
    case (n1074_o)
      2'b00: n1075_o = n1064_o;
      2'b01: n1075_o = n1065_o;
      2'b10: n1075_o = n1066_o;
      2'b11: n1075_o = n1067_o;
    endcase
  /* BRANCH_PRED.vhd:43:23  */
  assign n1076_o = n911_o[3:2]; // extract
  /* BRANCH_PRED.vhd:43:23  */
  always @*
    case (n1076_o)
      2'b00: n1077_o = n1069_o;
      2'b01: n1077_o = n1071_o;
      2'b10: n1077_o = n1073_o;
      2'b11: n1077_o = n1075_o;
    endcase
  /* BRANCH_PRED.vhd:43:23  */
  assign n1078_o = btb_valid[0]; // extract
  /* BRANCH_PRED.vhd:43:24  */
  assign n1079_o = btb_valid[1]; // extract
  assign n1080_o = btb_valid[2]; // extract
  assign n1081_o = btb_valid[3]; // extract
  assign n1082_o = btb_valid[4]; // extract
  assign n1083_o = btb_valid[5]; // extract
  assign n1084_o = btb_valid[6]; // extract
  assign n1085_o = btb_valid[7]; // extract
  assign n1086_o = btb_valid[8]; // extract
  assign n1087_o = btb_valid[9]; // extract
  assign n1088_o = btb_valid[10]; // extract
  assign n1089_o = btb_valid[11]; // extract
  assign n1090_o = btb_valid[12]; // extract
  assign n1091_o = btb_valid[13]; // extract
  assign n1092_o = btb_valid[14]; // extract
  assign n1093_o = btb_valid[15]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  assign n1094_o = index_f[1:0]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  always @*
    case (n1094_o)
      2'b00: n1095_o = n1078_o;
      2'b01: n1095_o = n1079_o;
      2'b10: n1095_o = n1080_o;
      2'b11: n1095_o = n1081_o;
    endcase
  /* BRANCH_PRED.vhd:45:32  */
  assign n1096_o = index_f[1:0]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  always @*
    case (n1096_o)
      2'b00: n1097_o = n1082_o;
      2'b01: n1097_o = n1083_o;
      2'b10: n1097_o = n1084_o;
      2'b11: n1097_o = n1085_o;
    endcase
  /* BRANCH_PRED.vhd:45:32  */
  assign n1098_o = index_f[1:0]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  always @*
    case (n1098_o)
      2'b00: n1099_o = n1086_o;
      2'b01: n1099_o = n1087_o;
      2'b10: n1099_o = n1088_o;
      2'b11: n1099_o = n1089_o;
    endcase
  /* BRANCH_PRED.vhd:45:32  */
  assign n1100_o = index_f[1:0]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  always @*
    case (n1100_o)
      2'b00: n1101_o = n1090_o;
      2'b01: n1101_o = n1091_o;
      2'b10: n1101_o = n1092_o;
      2'b11: n1101_o = n1093_o;
    endcase
  /* BRANCH_PRED.vhd:45:32  */
  assign n1102_o = index_f[3:2]; // extract
  /* BRANCH_PRED.vhd:45:32  */
  always @*
    case (n1102_o)
      2'b00: n1103_o = n1095_o;
      2'b01: n1103_o = n1097_o;
      2'b10: n1103_o = n1099_o;
      2'b11: n1103_o = n1101_o;
    endcase
  /* BRANCH_PRED.vhd:45:32  */
  assign n1104_o = btb_tag[31:0]; // extract
  /* BRANCH_PRED.vhd:45:33  */
  assign n1105_o = btb_tag[63:32]; // extract
  assign n1106_o = btb_tag[95:64]; // extract
  assign n1107_o = btb_tag[127:96]; // extract
  assign n1108_o = btb_tag[159:128]; // extract
  assign n1109_o = btb_tag[191:160]; // extract
  assign n1110_o = btb_tag[223:192]; // extract
  assign n1111_o = btb_tag[255:224]; // extract
  assign n1112_o = btb_tag[287:256]; // extract
  assign n1113_o = btb_tag[319:288]; // extract
  assign n1114_o = btb_tag[351:320]; // extract
  assign n1115_o = btb_tag[383:352]; // extract
  assign n1116_o = btb_tag[415:384]; // extract
  assign n1117_o = btb_tag[447:416]; // extract
  assign n1118_o = btb_tag[479:448]; // extract
  assign n1119_o = btb_tag[511:480]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  assign n1120_o = n918_o[1:0]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  always @*
    case (n1120_o)
      2'b00: n1121_o = n1104_o;
      2'b01: n1121_o = n1105_o;
      2'b10: n1121_o = n1106_o;
      2'b11: n1121_o = n1107_o;
    endcase
  /* BRANCH_PRED.vhd:45:59  */
  assign n1122_o = n918_o[1:0]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  always @*
    case (n1122_o)
      2'b00: n1123_o = n1108_o;
      2'b01: n1123_o = n1109_o;
      2'b10: n1123_o = n1110_o;
      2'b11: n1123_o = n1111_o;
    endcase
  /* BRANCH_PRED.vhd:45:59  */
  assign n1124_o = n918_o[1:0]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  always @*
    case (n1124_o)
      2'b00: n1125_o = n1112_o;
      2'b01: n1125_o = n1113_o;
      2'b10: n1125_o = n1114_o;
      2'b11: n1125_o = n1115_o;
    endcase
  /* BRANCH_PRED.vhd:45:59  */
  assign n1126_o = n918_o[1:0]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  always @*
    case (n1126_o)
      2'b00: n1127_o = n1116_o;
      2'b01: n1127_o = n1117_o;
      2'b10: n1127_o = n1118_o;
      2'b11: n1127_o = n1119_o;
    endcase
  /* BRANCH_PRED.vhd:45:59  */
  assign n1128_o = n918_o[3:2]; // extract
  /* BRANCH_PRED.vhd:45:59  */
  always @*
    case (n1128_o)
      2'b00: n1129_o = n1121_o;
      2'b01: n1129_o = n1123_o;
      2'b10: n1129_o = n1125_o;
      2'b11: n1129_o = n1127_o;
    endcase
  /* BRANCH_PRED.vhd:45:59  */
  assign n1130_o = bht[1]; // extract
  /* BRANCH_PRED.vhd:45:60  */
  assign n1131_o = bht[3]; // extract
  assign n1132_o = bht[5]; // extract
  assign n1133_o = bht[7]; // extract
  assign n1134_o = bht[9]; // extract
  assign n1135_o = bht[11]; // extract
  assign n1136_o = bht[13]; // extract
  assign n1137_o = bht[15]; // extract
  assign n1138_o = bht[17]; // extract
  assign n1139_o = bht[19]; // extract
  assign n1140_o = bht[21]; // extract
  assign n1141_o = bht[23]; // extract
  assign n1142_o = bht[25]; // extract
  assign n1143_o = bht[27]; // extract
  assign n1144_o = bht[29]; // extract
  assign n1145_o = bht[31]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  assign n1146_o = n926_o[1:0]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  always @*
    case (n1146_o)
      2'b00: n1147_o = n1130_o;
      2'b01: n1147_o = n1131_o;
      2'b10: n1147_o = n1132_o;
      2'b11: n1147_o = n1133_o;
    endcase
  /* BRANCH_PRED.vhd:46:35  */
  assign n1148_o = n926_o[1:0]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  always @*
    case (n1148_o)
      2'b00: n1149_o = n1134_o;
      2'b01: n1149_o = n1135_o;
      2'b10: n1149_o = n1136_o;
      2'b11: n1149_o = n1137_o;
    endcase
  /* BRANCH_PRED.vhd:46:35  */
  assign n1150_o = n926_o[1:0]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  always @*
    case (n1150_o)
      2'b00: n1151_o = n1138_o;
      2'b01: n1151_o = n1139_o;
      2'b10: n1151_o = n1140_o;
      2'b11: n1151_o = n1141_o;
    endcase
  /* BRANCH_PRED.vhd:46:35  */
  assign n1152_o = n926_o[1:0]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  always @*
    case (n1152_o)
      2'b00: n1153_o = n1142_o;
      2'b01: n1153_o = n1143_o;
      2'b10: n1153_o = n1144_o;
      2'b11: n1153_o = n1145_o;
    endcase
  /* BRANCH_PRED.vhd:46:35  */
  assign n1154_o = n926_o[3:2]; // extract
  /* BRANCH_PRED.vhd:46:35  */
  always @*
    case (n1154_o)
      2'b00: n1155_o = n1147_o;
      2'b01: n1155_o = n1149_o;
      2'b10: n1155_o = n1151_o;
      2'b11: n1155_o = n1153_o;
    endcase
  /* BRANCH_PRED.vhd:46:35  */
  assign n1156_o = btb[31:0]; // extract
  /* BRANCH_PRED.vhd:46:27  */
  assign n1157_o = btb[63:32]; // extract
  assign n1158_o = btb[95:64]; // extract
  assign n1159_o = btb[127:96]; // extract
  assign n1160_o = btb[159:128]; // extract
  assign n1161_o = btb[191:160]; // extract
  assign n1162_o = btb[223:192]; // extract
  assign n1163_o = btb[255:224]; // extract
  assign n1164_o = btb[287:256]; // extract
  assign n1165_o = btb[319:288]; // extract
  assign n1166_o = btb[351:320]; // extract
  assign n1167_o = btb[383:352]; // extract
  assign n1168_o = btb[415:384]; // extract
  assign n1169_o = btb[447:416]; // extract
  assign n1170_o = btb[479:448]; // extract
  assign n1171_o = btb[511:480]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  assign n1172_o = n931_o[1:0]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  always @*
    case (n1172_o)
      2'b00: n1173_o = n1156_o;
      2'b01: n1173_o = n1157_o;
      2'b10: n1173_o = n1158_o;
      2'b11: n1173_o = n1159_o;
    endcase
  /* BRANCH_PRED.vhd:47:26  */
  assign n1174_o = n931_o[1:0]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  always @*
    case (n1174_o)
      2'b00: n1175_o = n1160_o;
      2'b01: n1175_o = n1161_o;
      2'b10: n1175_o = n1162_o;
      2'b11: n1175_o = n1163_o;
    endcase
  /* BRANCH_PRED.vhd:47:26  */
  assign n1176_o = n931_o[1:0]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  always @*
    case (n1176_o)
      2'b00: n1177_o = n1164_o;
      2'b01: n1177_o = n1165_o;
      2'b10: n1177_o = n1166_o;
      2'b11: n1177_o = n1167_o;
    endcase
  /* BRANCH_PRED.vhd:47:26  */
  assign n1178_o = n931_o[1:0]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  always @*
    case (n1178_o)
      2'b00: n1179_o = n1168_o;
      2'b01: n1179_o = n1169_o;
      2'b10: n1179_o = n1170_o;
      2'b11: n1179_o = n1171_o;
    endcase
  /* BRANCH_PRED.vhd:47:26  */
  assign n1180_o = n931_o[3:2]; // extract
  /* BRANCH_PRED.vhd:47:26  */
  always @*
    case (n1180_o)
      2'b00: n1181_o = n1173_o;
      2'b01: n1181_o = n1175_o;
      2'b10: n1181_o = n1177_o;
      2'b11: n1181_o = n1179_o;
    endcase
  /* BRANCH_PRED.vhd:47:26  */
  assign n1182_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:47:27  */
  assign n1183_o = bht[3:2]; // extract
  assign n1184_o = bht[5:4]; // extract
  assign n1185_o = bht[7:6]; // extract
  assign n1186_o = bht[9:8]; // extract
  assign n1187_o = bht[11:10]; // extract
  assign n1188_o = bht[13:12]; // extract
  assign n1189_o = bht[15:14]; // extract
  assign n1190_o = bht[17:16]; // extract
  assign n1191_o = bht[19:18]; // extract
  assign n1192_o = bht[21:20]; // extract
  assign n1193_o = bht[23:22]; // extract
  assign n1194_o = bht[25:24]; // extract
  assign n1195_o = bht[27:26]; // extract
  assign n1196_o = bht[29:28]; // extract
  assign n1197_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  assign n1198_o = n937_o[1:0]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  always @*
    case (n1198_o)
      2'b00: n1199_o = n1182_o;
      2'b01: n1199_o = n1183_o;
      2'b10: n1199_o = n1184_o;
      2'b11: n1199_o = n1185_o;
    endcase
  /* BRANCH_PRED.vhd:62:14  */
  assign n1200_o = n937_o[1:0]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  always @*
    case (n1200_o)
      2'b00: n1201_o = n1186_o;
      2'b01: n1201_o = n1187_o;
      2'b10: n1201_o = n1188_o;
      2'b11: n1201_o = n1189_o;
    endcase
  /* BRANCH_PRED.vhd:62:14  */
  assign n1202_o = n937_o[1:0]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  always @*
    case (n1202_o)
      2'b00: n1203_o = n1190_o;
      2'b01: n1203_o = n1191_o;
      2'b10: n1203_o = n1192_o;
      2'b11: n1203_o = n1193_o;
    endcase
  /* BRANCH_PRED.vhd:62:14  */
  assign n1204_o = n937_o[1:0]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  always @*
    case (n1204_o)
      2'b00: n1205_o = n1194_o;
      2'b01: n1205_o = n1195_o;
      2'b10: n1205_o = n1196_o;
      2'b11: n1205_o = n1197_o;
    endcase
  /* BRANCH_PRED.vhd:62:14  */
  assign n1206_o = n937_o[3:2]; // extract
  /* BRANCH_PRED.vhd:62:14  */
  always @*
    case (n1206_o)
      2'b00: n1207_o = n1199_o;
      2'b01: n1207_o = n1201_o;
      2'b10: n1207_o = n1203_o;
      2'b11: n1207_o = n1205_o;
    endcase
  /* BRANCH_PRED.vhd:64:6  */
  assign n1208_o = n941_o[3]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1209_o = ~n1208_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1210_o = n941_o[2]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1211_o = ~n1210_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1212_o = n1209_o & n1211_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1213_o = n1209_o & n1210_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1214_o = n1208_o & n1211_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1215_o = n1208_o & n1210_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1216_o = n941_o[1]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1217_o = ~n1216_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1218_o = n1212_o & n1217_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1219_o = n1212_o & n1216_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1220_o = n1213_o & n1217_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1221_o = n1213_o & n1216_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1222_o = n1214_o & n1217_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1223_o = n1214_o & n1216_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1224_o = n1215_o & n1217_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1225_o = n1215_o & n1216_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1226_o = n941_o[0]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1227_o = ~n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1228_o = n1218_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1229_o = n1218_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1230_o = n1219_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1231_o = n1219_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1232_o = n1220_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1233_o = n1220_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1234_o = n1221_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1235_o = n1221_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1236_o = n1222_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1237_o = n1222_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1238_o = n1223_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1239_o = n1223_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1240_o = n1224_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1241_o = n1224_o & n1226_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1242_o = n1225_o & n1227_o;
  /* BRANCH_PRED.vhd:64:6  */
  assign n1243_o = n1225_o & n1226_o;
  assign n1244_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1245_o = n1228_o ? 2'b01 : n1244_o;
  assign n1246_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1247_o = n1229_o ? 2'b01 : n1246_o;
  assign n1248_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1249_o = n1230_o ? 2'b01 : n1248_o;
  assign n1250_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1251_o = n1231_o ? 2'b01 : n1250_o;
  assign n1252_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1253_o = n1232_o ? 2'b01 : n1252_o;
  assign n1254_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1255_o = n1233_o ? 2'b01 : n1254_o;
  assign n1256_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1257_o = n1234_o ? 2'b01 : n1256_o;
  assign n1258_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1259_o = n1235_o ? 2'b01 : n1258_o;
  assign n1260_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1261_o = n1236_o ? 2'b01 : n1260_o;
  assign n1262_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1263_o = n1237_o ? 2'b01 : n1262_o;
  assign n1264_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1265_o = n1238_o ? 2'b01 : n1264_o;
  assign n1266_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1267_o = n1239_o ? 2'b01 : n1266_o;
  assign n1268_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1269_o = n1240_o ? 2'b01 : n1268_o;
  assign n1270_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1271_o = n1241_o ? 2'b01 : n1270_o;
  assign n1272_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1273_o = n1242_o ? 2'b01 : n1272_o;
  assign n1274_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:64:6  */
  assign n1275_o = n1243_o ? 2'b01 : n1274_o;
  assign n1276_o = {n1275_o, n1273_o, n1271_o, n1269_o, n1267_o, n1265_o, n1263_o, n1261_o, n1259_o, n1257_o, n1255_o, n1253_o, n1251_o, n1249_o, n1247_o, n1245_o};
  /* BRANCH_PRED.vhd:66:6  */
  assign n1277_o = n948_o[3]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1278_o = ~n1277_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1279_o = n948_o[2]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1280_o = ~n1279_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1281_o = n1278_o & n1280_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1282_o = n1278_o & n1279_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1283_o = n1277_o & n1280_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1284_o = n1277_o & n1279_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1285_o = n948_o[1]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1286_o = ~n1285_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1287_o = n1281_o & n1286_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1288_o = n1281_o & n1285_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1289_o = n1282_o & n1286_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1290_o = n1282_o & n1285_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1291_o = n1283_o & n1286_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1292_o = n1283_o & n1285_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1293_o = n1284_o & n1286_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1294_o = n1284_o & n1285_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1295_o = n948_o[0]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1296_o = ~n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1297_o = n1287_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1298_o = n1287_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1299_o = n1288_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1300_o = n1288_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1301_o = n1289_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1302_o = n1289_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1303_o = n1290_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1304_o = n1290_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1305_o = n1291_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1306_o = n1291_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1307_o = n1292_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1308_o = n1292_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1309_o = n1293_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1310_o = n1293_o & n1295_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1311_o = n1294_o & n1296_o;
  /* BRANCH_PRED.vhd:66:6  */
  assign n1312_o = n1294_o & n1295_o;
  assign n1313_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1314_o = n1297_o ? 2'b10 : n1313_o;
  assign n1315_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1316_o = n1298_o ? 2'b10 : n1315_o;
  assign n1317_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1318_o = n1299_o ? 2'b10 : n1317_o;
  assign n1319_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1320_o = n1300_o ? 2'b10 : n1319_o;
  assign n1321_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1322_o = n1301_o ? 2'b10 : n1321_o;
  assign n1323_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1324_o = n1302_o ? 2'b10 : n1323_o;
  assign n1325_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1326_o = n1303_o ? 2'b10 : n1325_o;
  assign n1327_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1328_o = n1304_o ? 2'b10 : n1327_o;
  assign n1329_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1330_o = n1305_o ? 2'b10 : n1329_o;
  assign n1331_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1332_o = n1306_o ? 2'b10 : n1331_o;
  assign n1333_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1334_o = n1307_o ? 2'b10 : n1333_o;
  assign n1335_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1336_o = n1308_o ? 2'b10 : n1335_o;
  assign n1337_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1338_o = n1309_o ? 2'b10 : n1337_o;
  assign n1339_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1340_o = n1310_o ? 2'b10 : n1339_o;
  assign n1341_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1342_o = n1311_o ? 2'b10 : n1341_o;
  assign n1343_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:66:6  */
  assign n1344_o = n1312_o ? 2'b10 : n1343_o;
  assign n1345_o = {n1344_o, n1342_o, n1340_o, n1338_o, n1336_o, n1334_o, n1332_o, n1330_o, n1328_o, n1326_o, n1324_o, n1322_o, n1320_o, n1318_o, n1316_o, n1314_o};
  /* BRANCH_PRED.vhd:68:6  */
  assign n1346_o = n955_o[3]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1347_o = ~n1346_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1348_o = n955_o[2]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1349_o = ~n1348_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1350_o = n1347_o & n1349_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1351_o = n1347_o & n1348_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1352_o = n1346_o & n1349_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1353_o = n1346_o & n1348_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1354_o = n955_o[1]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1355_o = ~n1354_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1356_o = n1350_o & n1355_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1357_o = n1350_o & n1354_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1358_o = n1351_o & n1355_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1359_o = n1351_o & n1354_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1360_o = n1352_o & n1355_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1361_o = n1352_o & n1354_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1362_o = n1353_o & n1355_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1363_o = n1353_o & n1354_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1364_o = n955_o[0]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1365_o = ~n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1366_o = n1356_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1367_o = n1356_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1368_o = n1357_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1369_o = n1357_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1370_o = n1358_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1371_o = n1358_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1372_o = n1359_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1373_o = n1359_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1374_o = n1360_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1375_o = n1360_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1376_o = n1361_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1377_o = n1361_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1378_o = n1362_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1379_o = n1362_o & n1364_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1380_o = n1363_o & n1365_o;
  /* BRANCH_PRED.vhd:68:6  */
  assign n1381_o = n1363_o & n1364_o;
  assign n1382_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1383_o = n1366_o ? 2'b11 : n1382_o;
  assign n1384_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1385_o = n1367_o ? 2'b11 : n1384_o;
  assign n1386_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1387_o = n1368_o ? 2'b11 : n1386_o;
  assign n1388_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1389_o = n1369_o ? 2'b11 : n1388_o;
  assign n1390_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1391_o = n1370_o ? 2'b11 : n1390_o;
  assign n1392_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1393_o = n1371_o ? 2'b11 : n1392_o;
  assign n1394_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1395_o = n1372_o ? 2'b11 : n1394_o;
  assign n1396_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1397_o = n1373_o ? 2'b11 : n1396_o;
  assign n1398_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1399_o = n1374_o ? 2'b11 : n1398_o;
  assign n1400_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1401_o = n1375_o ? 2'b11 : n1400_o;
  assign n1402_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1403_o = n1376_o ? 2'b11 : n1402_o;
  assign n1404_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1405_o = n1377_o ? 2'b11 : n1404_o;
  assign n1406_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1407_o = n1378_o ? 2'b11 : n1406_o;
  assign n1408_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1409_o = n1379_o ? 2'b11 : n1408_o;
  assign n1410_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1411_o = n1380_o ? 2'b11 : n1410_o;
  assign n1412_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:68:6  */
  assign n1413_o = n1381_o ? 2'b11 : n1412_o;
  assign n1414_o = {n1413_o, n1411_o, n1409_o, n1407_o, n1405_o, n1403_o, n1401_o, n1399_o, n1397_o, n1395_o, n1393_o, n1391_o, n1389_o, n1387_o, n1385_o, n1383_o};
  /* BRANCH_PRED.vhd:70:6  */
  assign n1415_o = n962_o[3]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1416_o = ~n1415_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1417_o = n962_o[2]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1418_o = ~n1417_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1419_o = n1416_o & n1418_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1420_o = n1416_o & n1417_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1421_o = n1415_o & n1418_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1422_o = n1415_o & n1417_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1423_o = n962_o[1]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1424_o = ~n1423_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1425_o = n1419_o & n1424_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1426_o = n1419_o & n1423_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1427_o = n1420_o & n1424_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1428_o = n1420_o & n1423_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1429_o = n1421_o & n1424_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1430_o = n1421_o & n1423_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1431_o = n1422_o & n1424_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1432_o = n1422_o & n1423_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1433_o = n962_o[0]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1434_o = ~n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1435_o = n1425_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1436_o = n1425_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1437_o = n1426_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1438_o = n1426_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1439_o = n1427_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1440_o = n1427_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1441_o = n1428_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1442_o = n1428_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1443_o = n1429_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1444_o = n1429_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1445_o = n1430_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1446_o = n1430_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1447_o = n1431_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1448_o = n1431_o & n1433_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1449_o = n1432_o & n1434_o;
  /* BRANCH_PRED.vhd:70:6  */
  assign n1450_o = n1432_o & n1433_o;
  assign n1451_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1452_o = n1435_o ? 2'b11 : n1451_o;
  assign n1453_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1454_o = n1436_o ? 2'b11 : n1453_o;
  assign n1455_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1456_o = n1437_o ? 2'b11 : n1455_o;
  assign n1457_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1458_o = n1438_o ? 2'b11 : n1457_o;
  assign n1459_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1460_o = n1439_o ? 2'b11 : n1459_o;
  assign n1461_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1462_o = n1440_o ? 2'b11 : n1461_o;
  assign n1463_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1464_o = n1441_o ? 2'b11 : n1463_o;
  assign n1465_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1466_o = n1442_o ? 2'b11 : n1465_o;
  assign n1467_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1468_o = n1443_o ? 2'b11 : n1467_o;
  assign n1469_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1470_o = n1444_o ? 2'b11 : n1469_o;
  assign n1471_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1472_o = n1445_o ? 2'b11 : n1471_o;
  assign n1473_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1474_o = n1446_o ? 2'b11 : n1473_o;
  assign n1475_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1476_o = n1447_o ? 2'b11 : n1475_o;
  assign n1477_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1478_o = n1448_o ? 2'b11 : n1477_o;
  assign n1479_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1480_o = n1449_o ? 2'b11 : n1479_o;
  assign n1481_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:70:6  */
  assign n1482_o = n1450_o ? 2'b11 : n1481_o;
  assign n1483_o = {n1482_o, n1480_o, n1478_o, n1476_o, n1474_o, n1472_o, n1470_o, n1468_o, n1466_o, n1464_o, n1462_o, n1460_o, n1458_o, n1456_o, n1454_o, n1452_o};
  /* BRANCH_PRED.vhd:72:6  */
  assign n1484_o = n969_o[3]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1485_o = ~n1484_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1486_o = n969_o[2]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1487_o = ~n1486_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1488_o = n1485_o & n1487_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1489_o = n1485_o & n1486_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1490_o = n1484_o & n1487_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1491_o = n1484_o & n1486_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1492_o = n969_o[1]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1493_o = ~n1492_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1494_o = n1488_o & n1493_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1495_o = n1488_o & n1492_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1496_o = n1489_o & n1493_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1497_o = n1489_o & n1492_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1498_o = n1490_o & n1493_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1499_o = n1490_o & n1492_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1500_o = n1491_o & n1493_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1501_o = n1491_o & n1492_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1502_o = n969_o[0]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1503_o = ~n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1504_o = n1494_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1505_o = n1494_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1506_o = n1495_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1507_o = n1495_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1508_o = n1496_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1509_o = n1496_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1510_o = n1497_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1511_o = n1497_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1512_o = n1498_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1513_o = n1498_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1514_o = n1499_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1515_o = n1499_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1516_o = n1500_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1517_o = n1500_o & n1502_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1518_o = n1501_o & n1503_o;
  /* BRANCH_PRED.vhd:72:6  */
  assign n1519_o = n1501_o & n1502_o;
  assign n1520_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1521_o = n1504_o ? 2'b01 : n1520_o;
  assign n1522_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1523_o = n1505_o ? 2'b01 : n1522_o;
  assign n1524_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1525_o = n1506_o ? 2'b01 : n1524_o;
  assign n1526_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1527_o = n1507_o ? 2'b01 : n1526_o;
  assign n1528_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1529_o = n1508_o ? 2'b01 : n1528_o;
  assign n1530_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1531_o = n1509_o ? 2'b01 : n1530_o;
  assign n1532_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1533_o = n1510_o ? 2'b01 : n1532_o;
  assign n1534_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1535_o = n1511_o ? 2'b01 : n1534_o;
  assign n1536_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1537_o = n1512_o ? 2'b01 : n1536_o;
  assign n1538_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1539_o = n1513_o ? 2'b01 : n1538_o;
  assign n1540_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1541_o = n1514_o ? 2'b01 : n1540_o;
  assign n1542_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1543_o = n1515_o ? 2'b01 : n1542_o;
  assign n1544_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1545_o = n1516_o ? 2'b01 : n1544_o;
  assign n1546_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1547_o = n1517_o ? 2'b01 : n1546_o;
  assign n1548_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1549_o = n1518_o ? 2'b01 : n1548_o;
  assign n1550_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:72:6  */
  assign n1551_o = n1519_o ? 2'b01 : n1550_o;
  assign n1552_o = {n1551_o, n1549_o, n1547_o, n1545_o, n1543_o, n1541_o, n1539_o, n1537_o, n1535_o, n1533_o, n1531_o, n1529_o, n1527_o, n1525_o, n1523_o, n1521_o};
  /* BRANCH_PRED.vhd:75:5  */
  assign n1553_o = n976_o[3]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1554_o = ~n1553_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1555_o = n976_o[2]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1556_o = ~n1555_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1557_o = n1554_o & n1556_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1558_o = n1554_o & n1555_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1559_o = n1553_o & n1556_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1560_o = n1553_o & n1555_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1561_o = n976_o[1]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1562_o = ~n1561_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1563_o = n1557_o & n1562_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1564_o = n1557_o & n1561_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1565_o = n1558_o & n1562_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1566_o = n1558_o & n1561_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1567_o = n1559_o & n1562_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1568_o = n1559_o & n1561_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1569_o = n1560_o & n1562_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1570_o = n1560_o & n1561_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1571_o = n976_o[0]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1572_o = ~n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1573_o = n1563_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1574_o = n1563_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1575_o = n1564_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1576_o = n1564_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1577_o = n1565_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1578_o = n1565_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1579_o = n1566_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1580_o = n1566_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1581_o = n1567_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1582_o = n1567_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1583_o = n1568_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1584_o = n1568_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1585_o = n1569_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1586_o = n1569_o & n1571_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1587_o = n1570_o & n1572_o;
  /* BRANCH_PRED.vhd:75:5  */
  assign n1588_o = n1570_o & n1571_o;
  assign n1589_o = btb[31:0]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1590_o = n1573_o ? actual_target_e : n1589_o;
  assign n1591_o = btb[63:32]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1592_o = n1574_o ? actual_target_e : n1591_o;
  assign n1593_o = btb[95:64]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1594_o = n1575_o ? actual_target_e : n1593_o;
  assign n1595_o = btb[127:96]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1596_o = n1576_o ? actual_target_e : n1595_o;
  assign n1597_o = btb[159:128]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1598_o = n1577_o ? actual_target_e : n1597_o;
  assign n1599_o = btb[191:160]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1600_o = n1578_o ? actual_target_e : n1599_o;
  assign n1601_o = btb[223:192]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1602_o = n1579_o ? actual_target_e : n1601_o;
  assign n1603_o = btb[255:224]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1604_o = n1580_o ? actual_target_e : n1603_o;
  assign n1605_o = btb[287:256]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1606_o = n1581_o ? actual_target_e : n1605_o;
  assign n1607_o = btb[319:288]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1608_o = n1582_o ? actual_target_e : n1607_o;
  assign n1609_o = btb[351:320]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1610_o = n1583_o ? actual_target_e : n1609_o;
  assign n1611_o = btb[383:352]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1612_o = n1584_o ? actual_target_e : n1611_o;
  assign n1613_o = btb[415:384]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1614_o = n1585_o ? actual_target_e : n1613_o;
  assign n1615_o = btb[447:416]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1616_o = n1586_o ? actual_target_e : n1615_o;
  assign n1617_o = btb[479:448]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1618_o = n1587_o ? actual_target_e : n1617_o;
  assign n1619_o = btb[511:480]; // extract
  /* BRANCH_PRED.vhd:75:5  */
  assign n1620_o = n1588_o ? actual_target_e : n1619_o;
  assign n1621_o = {n1620_o, n1618_o, n1616_o, n1614_o, n1612_o, n1610_o, n1608_o, n1606_o, n1604_o, n1602_o, n1600_o, n1598_o, n1596_o, n1594_o, n1592_o, n1590_o};
  /* BRANCH_PRED.vhd:76:5  */
  assign n1622_o = n980_o[3]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1623_o = ~n1622_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1624_o = n980_o[2]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1625_o = ~n1624_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1626_o = n1623_o & n1625_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1627_o = n1623_o & n1624_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1628_o = n1622_o & n1625_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1629_o = n1622_o & n1624_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1630_o = n980_o[1]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1631_o = ~n1630_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1632_o = n1626_o & n1631_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1633_o = n1626_o & n1630_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1634_o = n1627_o & n1631_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1635_o = n1627_o & n1630_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1636_o = n1628_o & n1631_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1637_o = n1628_o & n1630_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1638_o = n1629_o & n1631_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1639_o = n1629_o & n1630_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1640_o = n980_o[0]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1641_o = ~n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1642_o = n1632_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1643_o = n1632_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1644_o = n1633_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1645_o = n1633_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1646_o = n1634_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1647_o = n1634_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1648_o = n1635_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1649_o = n1635_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1650_o = n1636_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1651_o = n1636_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1652_o = n1637_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1653_o = n1637_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1654_o = n1638_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1655_o = n1638_o & n1640_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1656_o = n1639_o & n1641_o;
  /* BRANCH_PRED.vhd:76:5  */
  assign n1657_o = n1639_o & n1640_o;
  assign n1658_o = btb_tag[31:0]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1659_o = n1642_o ? pc_e : n1658_o;
  assign n1660_o = btb_tag[63:32]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1661_o = n1643_o ? pc_e : n1660_o;
  assign n1662_o = btb_tag[95:64]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1663_o = n1644_o ? pc_e : n1662_o;
  assign n1664_o = btb_tag[127:96]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1665_o = n1645_o ? pc_e : n1664_o;
  assign n1666_o = btb_tag[159:128]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1667_o = n1646_o ? pc_e : n1666_o;
  assign n1668_o = btb_tag[191:160]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1669_o = n1647_o ? pc_e : n1668_o;
  assign n1670_o = btb_tag[223:192]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1671_o = n1648_o ? pc_e : n1670_o;
  assign n1672_o = btb_tag[255:224]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1673_o = n1649_o ? pc_e : n1672_o;
  assign n1674_o = btb_tag[287:256]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1675_o = n1650_o ? pc_e : n1674_o;
  assign n1676_o = btb_tag[319:288]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1677_o = n1651_o ? pc_e : n1676_o;
  assign n1678_o = btb_tag[351:320]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1679_o = n1652_o ? pc_e : n1678_o;
  assign n1680_o = btb_tag[383:352]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1681_o = n1653_o ? pc_e : n1680_o;
  assign n1682_o = btb_tag[415:384]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1683_o = n1654_o ? pc_e : n1682_o;
  assign n1684_o = btb_tag[447:416]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1685_o = n1655_o ? pc_e : n1684_o;
  assign n1686_o = btb_tag[479:448]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1687_o = n1656_o ? pc_e : n1686_o;
  assign n1688_o = btb_tag[511:480]; // extract
  /* BRANCH_PRED.vhd:76:5  */
  assign n1689_o = n1657_o ? pc_e : n1688_o;
  assign n1690_o = {n1689_o, n1687_o, n1685_o, n1683_o, n1681_o, n1679_o, n1677_o, n1675_o, n1673_o, n1671_o, n1669_o, n1667_o, n1665_o, n1663_o, n1661_o, n1659_o};
  /* BRANCH_PRED.vhd:77:5  */
  assign n1691_o = index_e[3]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1692_o = ~n1691_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1693_o = index_e[2]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1694_o = ~n1693_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1695_o = n1692_o & n1694_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1696_o = n1692_o & n1693_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1697_o = n1691_o & n1694_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1698_o = n1691_o & n1693_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1699_o = index_e[1]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1700_o = ~n1699_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1701_o = n1695_o & n1700_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1702_o = n1695_o & n1699_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1703_o = n1696_o & n1700_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1704_o = n1696_o & n1699_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1705_o = n1697_o & n1700_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1706_o = n1697_o & n1699_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1707_o = n1698_o & n1700_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1708_o = n1698_o & n1699_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1709_o = index_e[0]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1710_o = ~n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1711_o = n1701_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1712_o = n1701_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1713_o = n1702_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1714_o = n1702_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1715_o = n1703_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1716_o = n1703_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1717_o = n1704_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1718_o = n1704_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1719_o = n1705_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1720_o = n1705_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1721_o = n1706_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1722_o = n1706_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1723_o = n1707_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1724_o = n1707_o & n1709_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1725_o = n1708_o & n1710_o;
  /* BRANCH_PRED.vhd:77:5  */
  assign n1726_o = n1708_o & n1709_o;
  assign n1727_o = btb_valid[0]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1728_o = n1711_o ? 1'b1 : n1727_o;
  assign n1729_o = btb_valid[1]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1730_o = n1712_o ? 1'b1 : n1729_o;
  assign n1731_o = btb_valid[2]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1732_o = n1713_o ? 1'b1 : n1731_o;
  assign n1733_o = btb_valid[3]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1734_o = n1714_o ? 1'b1 : n1733_o;
  assign n1735_o = btb_valid[4]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1736_o = n1715_o ? 1'b1 : n1735_o;
  assign n1737_o = btb_valid[5]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1738_o = n1716_o ? 1'b1 : n1737_o;
  assign n1739_o = btb_valid[6]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1740_o = n1717_o ? 1'b1 : n1739_o;
  assign n1741_o = btb_valid[7]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1742_o = n1718_o ? 1'b1 : n1741_o;
  assign n1743_o = btb_valid[8]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1744_o = n1719_o ? 1'b1 : n1743_o;
  assign n1745_o = btb_valid[9]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1746_o = n1720_o ? 1'b1 : n1745_o;
  assign n1747_o = btb_valid[10]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1748_o = n1721_o ? 1'b1 : n1747_o;
  assign n1749_o = btb_valid[11]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1750_o = n1722_o ? 1'b1 : n1749_o;
  assign n1751_o = btb_valid[12]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1752_o = n1723_o ? 1'b1 : n1751_o;
  assign n1753_o = btb_valid[13]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1754_o = n1724_o ? 1'b1 : n1753_o;
  assign n1755_o = btb_valid[14]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1756_o = n1725_o ? 1'b1 : n1755_o;
  assign n1757_o = btb_valid[15]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1758_o = n1726_o ? 1'b1 : n1757_o;
  assign n1759_o = {n1758_o, n1756_o, n1754_o, n1752_o, n1750_o, n1748_o, n1746_o, n1744_o, n1742_o, n1740_o, n1738_o, n1736_o, n1734_o, n1732_o, n1730_o, n1728_o};
  /* BRANCH_PRED.vhd:77:15  */
  assign n1760_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:77:5  */
  assign n1761_o = bht[3:2]; // extract
  assign n1762_o = bht[5:4]; // extract
  assign n1763_o = bht[7:6]; // extract
  assign n1764_o = bht[9:8]; // extract
  assign n1765_o = bht[11:10]; // extract
  assign n1766_o = bht[13:12]; // extract
  assign n1767_o = bht[15:14]; // extract
  assign n1768_o = bht[17:16]; // extract
  assign n1769_o = bht[19:18]; // extract
  assign n1770_o = bht[21:20]; // extract
  assign n1771_o = bht[23:22]; // extract
  assign n1772_o = bht[25:24]; // extract
  assign n1773_o = bht[27:26]; // extract
  assign n1774_o = bht[29:28]; // extract
  assign n1775_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  assign n1776_o = n988_o[1:0]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  always @*
    case (n1776_o)
      2'b00: n1777_o = n1760_o;
      2'b01: n1777_o = n1761_o;
      2'b10: n1777_o = n1762_o;
      2'b11: n1777_o = n1763_o;
    endcase
  /* BRANCH_PRED.vhd:80:14  */
  assign n1778_o = n988_o[1:0]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  always @*
    case (n1778_o)
      2'b00: n1779_o = n1764_o;
      2'b01: n1779_o = n1765_o;
      2'b10: n1779_o = n1766_o;
      2'b11: n1779_o = n1767_o;
    endcase
  /* BRANCH_PRED.vhd:80:14  */
  assign n1780_o = n988_o[1:0]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  always @*
    case (n1780_o)
      2'b00: n1781_o = n1768_o;
      2'b01: n1781_o = n1769_o;
      2'b10: n1781_o = n1770_o;
      2'b11: n1781_o = n1771_o;
    endcase
  /* BRANCH_PRED.vhd:80:14  */
  assign n1782_o = n988_o[1:0]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  always @*
    case (n1782_o)
      2'b00: n1783_o = n1772_o;
      2'b01: n1783_o = n1773_o;
      2'b10: n1783_o = n1774_o;
      2'b11: n1783_o = n1775_o;
    endcase
  /* BRANCH_PRED.vhd:80:14  */
  assign n1784_o = n988_o[3:2]; // extract
  /* BRANCH_PRED.vhd:80:14  */
  always @*
    case (n1784_o)
      2'b00: n1785_o = n1777_o;
      2'b01: n1785_o = n1779_o;
      2'b10: n1785_o = n1781_o;
      2'b11: n1785_o = n1783_o;
    endcase
  /* BRANCH_PRED.vhd:82:6  */
  assign n1786_o = n992_o[3]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1787_o = ~n1786_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1788_o = n992_o[2]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1789_o = ~n1788_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1790_o = n1787_o & n1789_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1791_o = n1787_o & n1788_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1792_o = n1786_o & n1789_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1793_o = n1786_o & n1788_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1794_o = n992_o[1]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1795_o = ~n1794_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1796_o = n1790_o & n1795_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1797_o = n1790_o & n1794_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1798_o = n1791_o & n1795_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1799_o = n1791_o & n1794_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1800_o = n1792_o & n1795_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1801_o = n1792_o & n1794_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1802_o = n1793_o & n1795_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1803_o = n1793_o & n1794_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1804_o = n992_o[0]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1805_o = ~n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1806_o = n1796_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1807_o = n1796_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1808_o = n1797_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1809_o = n1797_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1810_o = n1798_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1811_o = n1798_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1812_o = n1799_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1813_o = n1799_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1814_o = n1800_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1815_o = n1800_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1816_o = n1801_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1817_o = n1801_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1818_o = n1802_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1819_o = n1802_o & n1804_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1820_o = n1803_o & n1805_o;
  /* BRANCH_PRED.vhd:82:6  */
  assign n1821_o = n1803_o & n1804_o;
  assign n1822_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1823_o = n1806_o ? 2'b10 : n1822_o;
  assign n1824_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1825_o = n1807_o ? 2'b10 : n1824_o;
  assign n1826_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1827_o = n1808_o ? 2'b10 : n1826_o;
  assign n1828_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1829_o = n1809_o ? 2'b10 : n1828_o;
  assign n1830_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1831_o = n1810_o ? 2'b10 : n1830_o;
  assign n1832_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1833_o = n1811_o ? 2'b10 : n1832_o;
  assign n1834_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1835_o = n1812_o ? 2'b10 : n1834_o;
  assign n1836_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1837_o = n1813_o ? 2'b10 : n1836_o;
  assign n1838_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1839_o = n1814_o ? 2'b10 : n1838_o;
  assign n1840_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1841_o = n1815_o ? 2'b10 : n1840_o;
  assign n1842_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1843_o = n1816_o ? 2'b10 : n1842_o;
  assign n1844_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1845_o = n1817_o ? 2'b10 : n1844_o;
  assign n1846_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1847_o = n1818_o ? 2'b10 : n1846_o;
  assign n1848_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1849_o = n1819_o ? 2'b10 : n1848_o;
  assign n1850_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1851_o = n1820_o ? 2'b10 : n1850_o;
  assign n1852_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:82:6  */
  assign n1853_o = n1821_o ? 2'b10 : n1852_o;
  assign n1854_o = {n1853_o, n1851_o, n1849_o, n1847_o, n1845_o, n1843_o, n1841_o, n1839_o, n1837_o, n1835_o, n1833_o, n1831_o, n1829_o, n1827_o, n1825_o, n1823_o};
  /* BRANCH_PRED.vhd:84:6  */
  assign n1855_o = n999_o[3]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1856_o = ~n1855_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1857_o = n999_o[2]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1858_o = ~n1857_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1859_o = n1856_o & n1858_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1860_o = n1856_o & n1857_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1861_o = n1855_o & n1858_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1862_o = n1855_o & n1857_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1863_o = n999_o[1]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1864_o = ~n1863_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1865_o = n1859_o & n1864_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1866_o = n1859_o & n1863_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1867_o = n1860_o & n1864_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1868_o = n1860_o & n1863_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1869_o = n1861_o & n1864_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1870_o = n1861_o & n1863_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1871_o = n1862_o & n1864_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1872_o = n1862_o & n1863_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1873_o = n999_o[0]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1874_o = ~n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1875_o = n1865_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1876_o = n1865_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1877_o = n1866_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1878_o = n1866_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1879_o = n1867_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1880_o = n1867_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1881_o = n1868_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1882_o = n1868_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1883_o = n1869_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1884_o = n1869_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1885_o = n1870_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1886_o = n1870_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1887_o = n1871_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1888_o = n1871_o & n1873_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1889_o = n1872_o & n1874_o;
  /* BRANCH_PRED.vhd:84:6  */
  assign n1890_o = n1872_o & n1873_o;
  assign n1891_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1892_o = n1875_o ? 2'b01 : n1891_o;
  assign n1893_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1894_o = n1876_o ? 2'b01 : n1893_o;
  assign n1895_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1896_o = n1877_o ? 2'b01 : n1895_o;
  assign n1897_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1898_o = n1878_o ? 2'b01 : n1897_o;
  assign n1899_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1900_o = n1879_o ? 2'b01 : n1899_o;
  assign n1901_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1902_o = n1880_o ? 2'b01 : n1901_o;
  assign n1903_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1904_o = n1881_o ? 2'b01 : n1903_o;
  assign n1905_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1906_o = n1882_o ? 2'b01 : n1905_o;
  assign n1907_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1908_o = n1883_o ? 2'b01 : n1907_o;
  assign n1909_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1910_o = n1884_o ? 2'b01 : n1909_o;
  assign n1911_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1912_o = n1885_o ? 2'b01 : n1911_o;
  assign n1913_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1914_o = n1886_o ? 2'b01 : n1913_o;
  assign n1915_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1916_o = n1887_o ? 2'b01 : n1915_o;
  assign n1917_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1918_o = n1888_o ? 2'b01 : n1917_o;
  assign n1919_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1920_o = n1889_o ? 2'b01 : n1919_o;
  assign n1921_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:84:6  */
  assign n1922_o = n1890_o ? 2'b01 : n1921_o;
  assign n1923_o = {n1922_o, n1920_o, n1918_o, n1916_o, n1914_o, n1912_o, n1910_o, n1908_o, n1906_o, n1904_o, n1902_o, n1900_o, n1898_o, n1896_o, n1894_o, n1892_o};
  /* BRANCH_PRED.vhd:86:6  */
  assign n1924_o = n1006_o[3]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1925_o = ~n1924_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1926_o = n1006_o[2]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1927_o = ~n1926_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1928_o = n1925_o & n1927_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1929_o = n1925_o & n1926_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1930_o = n1924_o & n1927_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1931_o = n1924_o & n1926_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1932_o = n1006_o[1]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1933_o = ~n1932_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1934_o = n1928_o & n1933_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1935_o = n1928_o & n1932_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1936_o = n1929_o & n1933_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1937_o = n1929_o & n1932_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1938_o = n1930_o & n1933_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1939_o = n1930_o & n1932_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1940_o = n1931_o & n1933_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1941_o = n1931_o & n1932_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1942_o = n1006_o[0]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1943_o = ~n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1944_o = n1934_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1945_o = n1934_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1946_o = n1935_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1947_o = n1935_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1948_o = n1936_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1949_o = n1936_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1950_o = n1937_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1951_o = n1937_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1952_o = n1938_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1953_o = n1938_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1954_o = n1939_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1955_o = n1939_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1956_o = n1940_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1957_o = n1940_o & n1942_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1958_o = n1941_o & n1943_o;
  /* BRANCH_PRED.vhd:86:6  */
  assign n1959_o = n1941_o & n1942_o;
  assign n1960_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1961_o = n1944_o ? 2'b00 : n1960_o;
  assign n1962_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1963_o = n1945_o ? 2'b00 : n1962_o;
  assign n1964_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1965_o = n1946_o ? 2'b00 : n1964_o;
  assign n1966_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1967_o = n1947_o ? 2'b00 : n1966_o;
  assign n1968_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1969_o = n1948_o ? 2'b00 : n1968_o;
  assign n1970_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1971_o = n1949_o ? 2'b00 : n1970_o;
  assign n1972_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1973_o = n1950_o ? 2'b00 : n1972_o;
  assign n1974_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1975_o = n1951_o ? 2'b00 : n1974_o;
  assign n1976_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1977_o = n1952_o ? 2'b00 : n1976_o;
  assign n1978_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1979_o = n1953_o ? 2'b00 : n1978_o;
  assign n1980_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1981_o = n1954_o ? 2'b00 : n1980_o;
  assign n1982_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1983_o = n1955_o ? 2'b00 : n1982_o;
  assign n1984_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1985_o = n1956_o ? 2'b00 : n1984_o;
  assign n1986_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1987_o = n1957_o ? 2'b00 : n1986_o;
  assign n1988_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1989_o = n1958_o ? 2'b00 : n1988_o;
  assign n1990_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:86:6  */
  assign n1991_o = n1959_o ? 2'b00 : n1990_o;
  assign n1992_o = {n1991_o, n1989_o, n1987_o, n1985_o, n1983_o, n1981_o, n1979_o, n1977_o, n1975_o, n1973_o, n1971_o, n1969_o, n1967_o, n1965_o, n1963_o, n1961_o};
  /* BRANCH_PRED.vhd:88:6  */
  assign n1993_o = n1013_o[3]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n1994_o = ~n1993_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n1995_o = n1013_o[2]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n1996_o = ~n1995_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n1997_o = n1994_o & n1996_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n1998_o = n1994_o & n1995_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n1999_o = n1993_o & n1996_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2000_o = n1993_o & n1995_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2001_o = n1013_o[1]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2002_o = ~n2001_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2003_o = n1997_o & n2002_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2004_o = n1997_o & n2001_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2005_o = n1998_o & n2002_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2006_o = n1998_o & n2001_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2007_o = n1999_o & n2002_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2008_o = n1999_o & n2001_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2009_o = n2000_o & n2002_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2010_o = n2000_o & n2001_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2011_o = n1013_o[0]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2012_o = ~n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2013_o = n2003_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2014_o = n2003_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2015_o = n2004_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2016_o = n2004_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2017_o = n2005_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2018_o = n2005_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2019_o = n2006_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2020_o = n2006_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2021_o = n2007_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2022_o = n2007_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2023_o = n2008_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2024_o = n2008_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2025_o = n2009_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2026_o = n2009_o & n2011_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2027_o = n2010_o & n2012_o;
  /* BRANCH_PRED.vhd:88:6  */
  assign n2028_o = n2010_o & n2011_o;
  assign n2029_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2030_o = n2013_o ? 2'b00 : n2029_o;
  assign n2031_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2032_o = n2014_o ? 2'b00 : n2031_o;
  assign n2033_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2034_o = n2015_o ? 2'b00 : n2033_o;
  assign n2035_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2036_o = n2016_o ? 2'b00 : n2035_o;
  assign n2037_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2038_o = n2017_o ? 2'b00 : n2037_o;
  assign n2039_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2040_o = n2018_o ? 2'b00 : n2039_o;
  assign n2041_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2042_o = n2019_o ? 2'b00 : n2041_o;
  assign n2043_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2044_o = n2020_o ? 2'b00 : n2043_o;
  assign n2045_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2046_o = n2021_o ? 2'b00 : n2045_o;
  assign n2047_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2048_o = n2022_o ? 2'b00 : n2047_o;
  assign n2049_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2050_o = n2023_o ? 2'b00 : n2049_o;
  assign n2051_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2052_o = n2024_o ? 2'b00 : n2051_o;
  assign n2053_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2054_o = n2025_o ? 2'b00 : n2053_o;
  assign n2055_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2056_o = n2026_o ? 2'b00 : n2055_o;
  assign n2057_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2058_o = n2027_o ? 2'b00 : n2057_o;
  assign n2059_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:88:6  */
  assign n2060_o = n2028_o ? 2'b00 : n2059_o;
  assign n2061_o = {n2060_o, n2058_o, n2056_o, n2054_o, n2052_o, n2050_o, n2048_o, n2046_o, n2044_o, n2042_o, n2040_o, n2038_o, n2036_o, n2034_o, n2032_o, n2030_o};
  /* BRANCH_PRED.vhd:90:6  */
  assign n2062_o = n1020_o[3]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2063_o = ~n2062_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2064_o = n1020_o[2]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2065_o = ~n2064_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2066_o = n2063_o & n2065_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2067_o = n2063_o & n2064_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2068_o = n2062_o & n2065_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2069_o = n2062_o & n2064_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2070_o = n1020_o[1]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2071_o = ~n2070_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2072_o = n2066_o & n2071_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2073_o = n2066_o & n2070_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2074_o = n2067_o & n2071_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2075_o = n2067_o & n2070_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2076_o = n2068_o & n2071_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2077_o = n2068_o & n2070_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2078_o = n2069_o & n2071_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2079_o = n2069_o & n2070_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2080_o = n1020_o[0]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2081_o = ~n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2082_o = n2072_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2083_o = n2072_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2084_o = n2073_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2085_o = n2073_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2086_o = n2074_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2087_o = n2074_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2088_o = n2075_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2089_o = n2075_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2090_o = n2076_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2091_o = n2076_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2092_o = n2077_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2093_o = n2077_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2094_o = n2078_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2095_o = n2078_o & n2080_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2096_o = n2079_o & n2081_o;
  /* BRANCH_PRED.vhd:90:6  */
  assign n2097_o = n2079_o & n2080_o;
  assign n2098_o = bht[1:0]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2099_o = n2082_o ? 2'b01 : n2098_o;
  assign n2100_o = bht[3:2]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2101_o = n2083_o ? 2'b01 : n2100_o;
  assign n2102_o = bht[5:4]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2103_o = n2084_o ? 2'b01 : n2102_o;
  assign n2104_o = bht[7:6]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2105_o = n2085_o ? 2'b01 : n2104_o;
  assign n2106_o = bht[9:8]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2107_o = n2086_o ? 2'b01 : n2106_o;
  assign n2108_o = bht[11:10]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2109_o = n2087_o ? 2'b01 : n2108_o;
  assign n2110_o = bht[13:12]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2111_o = n2088_o ? 2'b01 : n2110_o;
  assign n2112_o = bht[15:14]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2113_o = n2089_o ? 2'b01 : n2112_o;
  assign n2114_o = bht[17:16]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2115_o = n2090_o ? 2'b01 : n2114_o;
  assign n2116_o = bht[19:18]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2117_o = n2091_o ? 2'b01 : n2116_o;
  assign n2118_o = bht[21:20]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2119_o = n2092_o ? 2'b01 : n2118_o;
  assign n2120_o = bht[23:22]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2121_o = n2093_o ? 2'b01 : n2120_o;
  assign n2122_o = bht[25:24]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2123_o = n2094_o ? 2'b01 : n2122_o;
  assign n2124_o = bht[27:26]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2125_o = n2095_o ? 2'b01 : n2124_o;
  assign n2126_o = bht[29:28]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2127_o = n2096_o ? 2'b01 : n2126_o;
  assign n2128_o = bht[31:30]; // extract
  /* BRANCH_PRED.vhd:90:6  */
  assign n2129_o = n2097_o ? 2'b01 : n2128_o;
  assign n2130_o = {n2129_o, n2127_o, n2125_o, n2123_o, n2121_o, n2119_o, n2117_o, n2115_o, n2113_o, n2111_o, n2109_o, n2107_o, n2105_o, n2103_o, n2101_o, n2099_o};
endmodule

module mem_wb
  (input  clk,
   input  rst,
   input  [1:0] res_src_m,
   input  reg_write_m,
   input  valid_m,
   input  [4:0] rd_m,
   input  [31:0] pc_plus_4_m,
   input  [31:0] alu_res_m,
   input  [31:0] read_data_m,
   output valid_w,
   output [1:0] res_src_w,
   output reg_write_w,
   output [31:0] read_data_w,
   output [4:0] rd_w,
   output [31:0] pc_plus_4_w,
   output [31:0] alu_res_w);
  wire n870_o;
  wire [1:0] n872_o;
  wire n874_o;
  wire [31:0] n876_o;
  wire [4:0] n878_o;
  wire [31:0] n880_o;
  wire [31:0] n882_o;
  reg n891_q;
  reg [1:0] n892_q;
  reg n893_q;
  reg [31:0] n894_q;
  reg [4:0] n895_q;
  reg [31:0] n896_q;
  reg [31:0] n897_q;
  assign valid_w = n891_q; //(module output)
  assign res_src_w = n892_q; //(module output)
  assign reg_write_w = n893_q; //(module output)
  assign read_data_w = n894_q; //(module output)
  assign rd_w = n895_q; //(module output)
  assign pc_plus_4_w = n896_q; //(module output)
  assign alu_res_w = n897_q; //(module output)
  /* MEM_WB.vhd:37:1  */
  assign n870_o = rst ? 1'b0 : valid_m;
  /* MEM_WB.vhd:37:1  */
  assign n872_o = rst ? 2'b00 : res_src_m;
  /* MEM_WB.vhd:37:1  */
  assign n874_o = rst ? 1'b0 : reg_write_m;
  /* MEM_WB.vhd:37:1  */
  assign n876_o = rst ? 32'b00000000000000000000000000000000 : read_data_m;
  /* MEM_WB.vhd:37:1  */
  assign n878_o = rst ? 5'b00000 : rd_m;
  /* MEM_WB.vhd:37:1  */
  assign n880_o = rst ? 32'b00000000000000000000000000000000 : pc_plus_4_m;
  /* MEM_WB.vhd:37:1  */
  assign n882_o = rst ? 32'b00000000000000000000000000000000 : alu_res_m;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n891_q <= n870_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n892_q <= n872_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n893_q <= n874_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n894_q <= n876_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n895_q <= n878_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n896_q <= n880_o;
  /* MEM_WB.vhd:35:1  */
  always @(posedge clk)
    n897_q <= n882_o;
endmodule

module ex_mem
  (input  clk,
   input  rst,
   input  [1:0] res_src_e,
   input  mem_write_e,
   input  reg_write_e,
   input  valid_e,
   input  [4:0] rd_e,
   input  [31:0] pc_plus_4_e,
   input  [31:0] alu_res_e,
   input  [31:0] write_data_e,
   output valid_m,
   output [1:0] res_src_m,
   output mem_write_m,
   output reg_write_m,
   output [4:0] rd_m,
   output [31:0] pc_plus_4_m,
   output [31:0] alu_res_m,
   output [31:0] write_data_m);
  wire n828_o;
  wire [1:0] n830_o;
  wire n832_o;
  wire n834_o;
  wire [4:0] n836_o;
  wire [31:0] n838_o;
  wire [31:0] n840_o;
  wire [31:0] n842_o;
  reg n852_q;
  reg [1:0] n853_q;
  reg n854_q;
  reg n855_q;
  reg [4:0] n856_q;
  reg [31:0] n857_q;
  reg [31:0] n858_q;
  reg [31:0] n859_q;
  assign valid_m = n852_q; //(module output)
  assign res_src_m = n853_q; //(module output)
  assign mem_write_m = n854_q; //(module output)
  assign reg_write_m = n855_q; //(module output)
  assign rd_m = n856_q; //(module output)
  assign pc_plus_4_m = n857_q; //(module output)
  assign alu_res_m = n858_q; //(module output)
  assign write_data_m = n859_q; //(module output)
  /* EX_MEM.vhd:39:1  */
  assign n828_o = rst ? 1'b0 : valid_e;
  /* EX_MEM.vhd:39:1  */
  assign n830_o = rst ? 2'b00 : res_src_e;
  /* EX_MEM.vhd:39:1  */
  assign n832_o = rst ? 1'b0 : mem_write_e;
  /* EX_MEM.vhd:39:1  */
  assign n834_o = rst ? 1'b0 : reg_write_e;
  /* EX_MEM.vhd:39:1  */
  assign n836_o = rst ? 5'b00000 : rd_e;
  /* EX_MEM.vhd:39:1  */
  assign n838_o = rst ? 32'b00000000000000000000000000000000 : pc_plus_4_e;
  /* EX_MEM.vhd:39:1  */
  assign n840_o = rst ? 32'b00000000000000000000000000000000 : alu_res_e;
  /* EX_MEM.vhd:39:1  */
  assign n842_o = rst ? 32'b00000000000000000000000000000000 : write_data_e;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n852_q <= n828_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n853_q <= n830_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n854_q <= n832_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n855_q <= n834_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n856_q <= n836_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n857_q <= n838_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n858_q <= n840_o;
  /* EX_MEM.vhd:37:1  */
  always @(posedge clk)
    n859_q <= n842_o;
endmodule

module id_ex
  (input  clk,
   input  rst,
   input  flush,
   input  [1:0] res_src_d,
   input  mem_write_d,
   input  [2:0] alu_cont_d,
   input  alu_src_d,
   input  reg_write_d,
   input  branch_d,
   input  jump_d,
   input  valid_d,
   input  predicted_taken_d,
   input  [31:0] predicted_target_d,
   input  [31:0] rd1_d,
   input  [31:0] rd2_d,
   input  [4:0] ra1_d,
   input  [4:0] ra2_d,
   input  [4:0] rd_d,
   input  [31:0] sign_imm_d,
   input  [31:0] pc_d,
   input  [31:0] pc_plus_4_d,
   output valid_e,
   output [1:0] res_src_e,
   output mem_write_e,
   output [2:0] alu_cont_e,
   output alu_src_e,
   output reg_write_e,
   output branch_e,
   output jump_e,
   output predicted_taken_e,
   output [31:0] predicted_target_e,
   output [31:0] rd1_e,
   output [31:0] rd2_e,
   output [4:0] ra1_e,
   output [4:0] ra2_e,
   output [4:0] rd_e,
   output [31:0] sign_imm_e,
   output [31:0] pc_plus_4_e,
   output [31:0] pc_e);
  wire n709_o;
  wire [1:0] n711_o;
  wire n713_o;
  wire [2:0] n715_o;
  wire n717_o;
  wire n719_o;
  wire n721_o;
  wire n723_o;
  wire n725_o;
  wire [31:0] n727_o;
  wire [31:0] n729_o;
  wire [31:0] n731_o;
  wire [4:0] n733_o;
  wire [4:0] n735_o;
  wire [4:0] n737_o;
  wire [31:0] n739_o;
  wire [31:0] n741_o;
  wire [31:0] n743_o;
  wire n745_o;
  wire [1:0] n747_o;
  wire n749_o;
  wire [2:0] n751_o;
  wire n753_o;
  wire n755_o;
  wire n757_o;
  wire n759_o;
  wire n761_o;
  wire [31:0] n763_o;
  wire [31:0] n765_o;
  wire [31:0] n767_o;
  wire [4:0] n769_o;
  wire [4:0] n771_o;
  wire [4:0] n773_o;
  wire [31:0] n775_o;
  wire [31:0] n777_o;
  wire [31:0] n779_o;
  reg n799_q;
  reg [1:0] n800_q;
  reg n801_q;
  reg [2:0] n802_q;
  reg n803_q;
  reg n804_q;
  reg n805_q;
  reg n806_q;
  reg n807_q;
  reg [31:0] n808_q;
  reg [31:0] n809_q;
  reg [31:0] n810_q;
  reg [4:0] n811_q;
  reg [4:0] n812_q;
  reg [4:0] n813_q;
  reg [31:0] n814_q;
  reg [31:0] n815_q;
  reg [31:0] n816_q;
  assign valid_e = n799_q; //(module output)
  assign res_src_e = n800_q; //(module output)
  assign mem_write_e = n801_q; //(module output)
  assign alu_cont_e = n802_q; //(module output)
  assign alu_src_e = n803_q; //(module output)
  assign reg_write_e = n804_q; //(module output)
  assign branch_e = n805_q; //(module output)
  assign jump_e = n806_q; //(module output)
  assign predicted_taken_e = n807_q; //(module output)
  assign predicted_target_e = n808_q; //(module output)
  assign rd1_e = n809_q; //(module output)
  assign rd2_e = n810_q; //(module output)
  assign ra1_e = n811_q; //(module output)
  assign ra2_e = n812_q; //(module output)
  assign rd_e = n813_q; //(module output)
  assign sign_imm_e = n814_q; //(module output)
  assign pc_plus_4_e = n815_q; //(module output)
  assign pc_e = n816_q; //(module output)
  /* ID_EX.vhd:84:3  */
  assign n709_o = flush ? 1'b0 : valid_d;
  /* ID_EX.vhd:84:3  */
  assign n711_o = flush ? 2'b00 : res_src_d;
  /* ID_EX.vhd:84:3  */
  assign n713_o = flush ? 1'b0 : mem_write_d;
  /* ID_EX.vhd:84:3  */
  assign n715_o = flush ? 3'b000 : alu_cont_d;
  /* ID_EX.vhd:84:3  */
  assign n717_o = flush ? 1'b0 : alu_src_d;
  /* ID_EX.vhd:84:3  */
  assign n719_o = flush ? 1'b0 : reg_write_d;
  /* ID_EX.vhd:84:3  */
  assign n721_o = flush ? 1'b0 : branch_d;
  /* ID_EX.vhd:84:3  */
  assign n723_o = flush ? 1'b0 : jump_d;
  /* ID_EX.vhd:84:3  */
  assign n725_o = flush ? 1'b0 : predicted_taken_d;
  /* ID_EX.vhd:84:3  */
  assign n727_o = flush ? 32'b00000000000000000000000000000000 : predicted_target_d;
  /* ID_EX.vhd:84:3  */
  assign n729_o = flush ? 32'b00000000000000000000000000000000 : rd1_d;
  /* ID_EX.vhd:84:3  */
  assign n731_o = flush ? 32'b00000000000000000000000000000000 : rd2_d;
  /* ID_EX.vhd:84:3  */
  assign n733_o = flush ? 5'b00000 : ra1_d;
  /* ID_EX.vhd:84:3  */
  assign n735_o = flush ? 5'b00000 : ra2_d;
  /* ID_EX.vhd:84:3  */
  assign n737_o = flush ? 5'b00000 : rd_d;
  /* ID_EX.vhd:84:3  */
  assign n739_o = flush ? 32'b00000000000000000000000000000000 : sign_imm_d;
  /* ID_EX.vhd:84:3  */
  assign n741_o = flush ? 32'b00000000000000000000000000000000 : pc_plus_4_d;
  /* ID_EX.vhd:84:3  */
  assign n743_o = flush ? 32'b00000000000000000000000000000000 : pc_d;
  /* ID_EX.vhd:61:3  */
  assign n745_o = rst ? 1'b0 : n709_o;
  /* ID_EX.vhd:61:3  */
  assign n747_o = rst ? 2'b00 : n711_o;
  /* ID_EX.vhd:61:3  */
  assign n749_o = rst ? 1'b0 : n713_o;
  /* ID_EX.vhd:61:3  */
  assign n751_o = rst ? 3'b000 : n715_o;
  /* ID_EX.vhd:61:3  */
  assign n753_o = rst ? 1'b0 : n717_o;
  /* ID_EX.vhd:61:3  */
  assign n755_o = rst ? 1'b0 : n719_o;
  /* ID_EX.vhd:61:3  */
  assign n757_o = rst ? 1'b0 : n721_o;
  /* ID_EX.vhd:61:3  */
  assign n759_o = rst ? 1'b0 : n723_o;
  /* ID_EX.vhd:61:3  */
  assign n761_o = rst ? 1'b0 : n725_o;
  /* ID_EX.vhd:61:3  */
  assign n763_o = rst ? 32'b00000000000000000000000000000000 : n727_o;
  /* ID_EX.vhd:61:3  */
  assign n765_o = rst ? 32'b00000000000000000000000000000000 : n729_o;
  /* ID_EX.vhd:61:3  */
  assign n767_o = rst ? 32'b00000000000000000000000000000000 : n731_o;
  /* ID_EX.vhd:61:3  */
  assign n769_o = rst ? 5'b00000 : n733_o;
  /* ID_EX.vhd:61:3  */
  assign n771_o = rst ? 5'b00000 : n735_o;
  /* ID_EX.vhd:61:3  */
  assign n773_o = rst ? 5'b00000 : n737_o;
  /* ID_EX.vhd:61:3  */
  assign n775_o = rst ? 32'b00000000000000000000000000000000 : n739_o;
  /* ID_EX.vhd:61:3  */
  assign n777_o = rst ? 32'b00000000000000000000000000000000 : n741_o;
  /* ID_EX.vhd:61:3  */
  assign n779_o = rst ? 32'b00000000000000000000000000000000 : n743_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n799_q <= n745_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n800_q <= n747_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n801_q <= n749_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n802_q <= n751_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n803_q <= n753_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n804_q <= n755_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n805_q <= n757_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n806_q <= n759_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n807_q <= n761_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n808_q <= n763_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n809_q <= n765_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n810_q <= n767_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n811_q <= n769_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n812_q <= n771_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n813_q <= n773_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n814_q <= n775_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n815_q <= n777_o;
  /* ID_EX.vhd:59:3  */
  always @(posedge clk)
    n816_q <= n779_o;
endmodule

module if_id
  (input  clk,
   input  rst,
   input  flush,
   input  stall,
   input  [31:0] instr_f,
   input  [31:0] pc_f,
   input  [31:0] pc_plus_4_f,
   input  valid_f,
   input  predicted_taken_f,
   input  [31:0] predicted_target_f,
   output predicted_taken_d,
   output [31:0] predicted_target_d,
   output valid_d,
   output [31:0] instr_d,
   output [31:0] pc_d,
   output [31:0] pc_plus_4_d);
  wire n644_o;
  wire n645_o;
  wire [31:0] n646_o;
  wire n647_o;
  wire [31:0] n648_o;
  wire [31:0] n649_o;
  wire [31:0] n650_o;
  wire n652_o;
  wire [31:0] n654_o;
  wire n656_o;
  wire [31:0] n658_o;
  wire [31:0] n660_o;
  wire [31:0] n662_o;
  wire n664_o;
  wire [31:0] n666_o;
  wire n668_o;
  wire [31:0] n670_o;
  wire [31:0] n672_o;
  wire [31:0] n674_o;
  reg n682_q;
  reg [31:0] n683_q;
  reg n684_q;
  reg [31:0] n685_q;
  reg [31:0] n686_q;
  reg [31:0] n687_q;
  assign predicted_taken_d = n682_q; //(module output)
  assign predicted_target_d = n683_q; //(module output)
  assign valid_d = n684_q; //(module output)
  assign instr_d = n685_q; //(module output)
  assign pc_d = n686_q; //(module output)
  assign pc_plus_4_d = n687_q; //(module output)
  /* IF_ID.vhd:50:15  */
  assign n644_o = ~stall;
  /* IF_ID.vhd:50:3  */
  assign n645_o = n644_o ? predicted_taken_f : n682_q;
  /* IF_ID.vhd:50:3  */
  assign n646_o = n644_o ? predicted_target_f : n683_q;
  /* IF_ID.vhd:50:3  */
  assign n647_o = n644_o ? valid_f : n684_q;
  /* IF_ID.vhd:50:3  */
  assign n648_o = n644_o ? instr_f : n685_q;
  /* IF_ID.vhd:50:3  */
  assign n649_o = n644_o ? pc_f : n686_q;
  /* IF_ID.vhd:50:3  */
  assign n650_o = n644_o ? pc_plus_4_f : n687_q;
  /* IF_ID.vhd:42:3  */
  assign n652_o = flush ? 1'b0 : n645_o;
  /* IF_ID.vhd:42:3  */
  assign n654_o = flush ? 32'b00000000000000000000000000000000 : n646_o;
  /* IF_ID.vhd:42:3  */
  assign n656_o = flush ? 1'b0 : n647_o;
  /* IF_ID.vhd:42:3  */
  assign n658_o = flush ? 32'b00000000000000000000000000010011 : n648_o;
  /* IF_ID.vhd:42:3  */
  assign n660_o = flush ? 32'b00000000000000000000000000000000 : n649_o;
  /* IF_ID.vhd:42:3  */
  assign n662_o = flush ? 32'b00000000000000000000000000000000 : n650_o;
  /* IF_ID.vhd:34:3  */
  assign n664_o = rst ? 1'b0 : n652_o;
  /* IF_ID.vhd:34:3  */
  assign n666_o = rst ? 32'b00000000000000000000000000000000 : n654_o;
  /* IF_ID.vhd:34:3  */
  assign n668_o = rst ? 1'b0 : n656_o;
  /* IF_ID.vhd:34:3  */
  assign n670_o = rst ? 32'b00000000000000000000000000010011 : n658_o;
  /* IF_ID.vhd:34:3  */
  assign n672_o = rst ? 32'b00000000000000000000000000000000 : n660_o;
  /* IF_ID.vhd:34:3  */
  assign n674_o = rst ? 32'b00000000000000000000000000000000 : n662_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n682_q <= n664_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n683_q <= n666_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n684_q <= n668_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n685_q <= n670_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n686_q <= n672_o;
  /* IF_ID.vhd:32:3  */
  always @(posedge clk)
    n687_q <= n674_o;
endmodule

module hazard_unit
  (input  [4:0] ra1_d,
   input  [4:0] ra2_d,
   input  [4:0] ra1_e,
   input  [4:0] ra2_e,
   input  [4:0] rd_e,
   input  [4:0] rd_m,
   input  [4:0] rd_w,
   input  pc_src_e,
   input  [1:0] res_src_e,
   input  reg_write_m,
   input  reg_write_w,
   output stall_f,
   output stall_d,
   output flush_d,
   output flush_e,
   output [1:0] forward_ae,
   output [1:0] forward_be);
  wire n594_o;
  wire n595_o;
  wire n596_o;
  wire n597_o;
  wire n598_o;
  wire n601_o;
  wire n602_o;
  wire n603_o;
  wire n604_o;
  wire n606_o;
  wire n607_o;
  wire n608_o;
  wire n609_o;
  wire n611_o;
  wire n612_o;
  wire [1:0] n615_o;
  wire [1:0] n617_o;
  wire n618_o;
  wire n619_o;
  wire n621_o;
  wire n622_o;
  wire n623_o;
  wire n624_o;
  wire n626_o;
  wire n627_o;
  wire [1:0] n630_o;
  wire [1:0] n632_o;
  assign stall_f = n601_o; //(module output)
  assign stall_d = n601_o; //(module output)
  assign flush_d = pc_src_e; //(module output)
  assign flush_e = n602_o; //(module output)
  assign forward_ae = n617_o; //(module output)
  assign forward_be = n632_o; //(module output)
  /* HAZARD_UNIT.vhd:39:17  */
  assign n594_o = res_src_e == 2'b01;
  /* HAZARD_UNIT.vhd:39:37  */
  assign n595_o = ra1_d == rd_e;
  /* HAZARD_UNIT.vhd:39:55  */
  assign n596_o = ra2_d == rd_e;
  /* HAZARD_UNIT.vhd:39:45  */
  assign n597_o = n595_o | n596_o;
  /* HAZARD_UNIT.vhd:39:25  */
  assign n598_o = n597_o & n594_o;
  /* HAZARD_UNIT.vhd:39:3  */
  assign n601_o = n598_o ? 1'b1 : 1'b0;
  /* HAZARD_UNIT.vhd:49:25  */
  assign n602_o = pc_src_e | n601_o;
  /* HAZARD_UNIT.vhd:52:14  */
  assign n603_o = ra1_e == rd_m;
  /* HAZARD_UNIT.vhd:52:22  */
  assign n604_o = reg_write_m & n603_o;
  /* HAZARD_UNIT.vhd:52:56  */
  assign n606_o = ra1_e != 5'b00000;
  /* HAZARD_UNIT.vhd:52:45  */
  assign n607_o = n606_o & n604_o;
  /* HAZARD_UNIT.vhd:54:17  */
  assign n608_o = ra1_e == rd_w;
  /* HAZARD_UNIT.vhd:54:25  */
  assign n609_o = reg_write_w & n608_o;
  /* HAZARD_UNIT.vhd:54:59  */
  assign n611_o = ra1_e != 5'b00000;
  /* HAZARD_UNIT.vhd:54:48  */
  assign n612_o = n611_o & n609_o;
  /* HAZARD_UNIT.vhd:54:3  */
  assign n615_o = n612_o ? 2'b01 : 2'b00;
  /* HAZARD_UNIT.vhd:52:3  */
  assign n617_o = n607_o ? 2'b10 : n615_o;
  /* HAZARD_UNIT.vhd:60:14  */
  assign n618_o = ra2_e == rd_m;
  /* HAZARD_UNIT.vhd:60:22  */
  assign n619_o = reg_write_m & n618_o;
  /* HAZARD_UNIT.vhd:60:56  */
  assign n621_o = ra2_e != 5'b00000;
  /* HAZARD_UNIT.vhd:60:45  */
  assign n622_o = n621_o & n619_o;
  /* HAZARD_UNIT.vhd:62:17  */
  assign n623_o = ra2_e == rd_w;
  /* HAZARD_UNIT.vhd:62:25  */
  assign n624_o = reg_write_w & n623_o;
  /* HAZARD_UNIT.vhd:62:59  */
  assign n626_o = ra2_e != 5'b00000;
  /* HAZARD_UNIT.vhd:62:48  */
  assign n627_o = n626_o & n624_o;
  /* HAZARD_UNIT.vhd:62:3  */
  assign n630_o = n627_o ? 2'b01 : 2'b00;
  /* HAZARD_UNIT.vhd:60:3  */
  assign n632_o = n622_o ? 2'b10 : n630_o;
endmodule

module control_unit
  (input  [6:0] op,
   input  [2:0] funct3,
   input  funct7_5,
   output [1:0] res_src,
   output mem_write,
   output [2:0] alu_cont,
   output alu_src,
   output [2:0] imm_src,
   output reg_write,
   output branch,
   output jump);
  wire branch_s;
  wire jump_s;
  wire [1:0] alu_op_s;
  wire [2:0] main_d_n557;
  wire main_d_n558;
  wire [1:0] main_d_n559;
  wire main_d_n560;
  wire main_d_n561;
  wire main_d_n562;
  wire main_d_n563;
  wire [1:0] main_d_n564;
  wire [2:0] main_d_imm_src;
  wire main_d_reg_write;
  wire [1:0] main_d_res_src;
  wire main_d_alu_src;
  wire main_d_branch;
  wire main_d_jump;
  wire main_d_mem_write;
  wire [1:0] main_d_alu_op;
  wire n581_o;
  wire [2:0] alu_d_n582;
  wire [2:0] alu_d_alu_cont;
  assign res_src = main_d_n559; //(module output)
  assign mem_write = main_d_n563; //(module output)
  assign alu_cont = alu_d_n582; //(module output)
  assign alu_src = main_d_n560; //(module output)
  assign imm_src = main_d_n557; //(module output)
  assign reg_write = main_d_n558; //(module output)
  assign branch = branch_s; //(module output)
  assign jump = jump_s; //(module output)
  /* CONTROL_UNIT.vhd:25:8  */
  assign branch_s = main_d_n561; // (signal)
  /* CONTROL_UNIT.vhd:25:18  */
  assign jump_s = main_d_n562; // (signal)
  /* CONTROL_UNIT.vhd:26:8  */
  assign alu_op_s = main_d_n564; // (signal)
  /* CONTROL_UNIT.vhd:62:27  */
  assign main_d_n557 = main_d_imm_src; // (signal)
  /* CONTROL_UNIT.vhd:63:27  */
  assign main_d_n558 = main_d_reg_write; // (signal)
  /* CONTROL_UNIT.vhd:64:27  */
  assign main_d_n559 = main_d_res_src; // (signal)
  /* CONTROL_UNIT.vhd:65:27  */
  assign main_d_n560 = main_d_alu_src; // (signal)
  /* CONTROL_UNIT.vhd:66:27  */
  assign main_d_n561 = main_d_branch; // (signal)
  /* CONTROL_UNIT.vhd:67:27  */
  assign main_d_n562 = main_d_jump; // (signal)
  /* CONTROL_UNIT.vhd:68:27  */
  assign main_d_n563 = main_d_mem_write; // (signal)
  /* CONTROL_UNIT.vhd:69:27  */
  assign main_d_n564 = main_d_alu_op; // (signal)
  /* CONTROL_UNIT.vhd:59:3  */
  main_decoder main_d (
    .op(op),
    .imm_src(main_d_imm_src),
    .reg_write(main_d_reg_write),
    .res_src(main_d_res_src),
    .alu_src(main_d_alu_src),
    .branch(main_d_branch),
    .jump(main_d_jump),
    .mem_write(main_d_mem_write),
    .alu_op(main_d_alu_op));
  /* CONTROL_UNIT.vhd:75:29  */
  assign n581_o = op[5]; // extract
  /* CONTROL_UNIT.vhd:77:27  */
  assign alu_d_n582 = alu_d_alu_cont; // (signal)
  /* CONTROL_UNIT.vhd:71:3  */
  alu_decoder alu_d (
    .funct3(funct3),
    .funct7_5(funct7_5),
    .op5(n581_o),
    .alu_op(alu_op_s),
    .alu_cont(alu_d_alu_cont));
endmodule

module mux_32
  (input  [31:0] d0,
   input  [31:0] d1,
   input  sel,
   output [31:0] y);
  wire n544_o;
  wire n546_o;
  wire [1:0] n547_o;
  reg [31:0] n548_o;
  assign y = n548_o; //(module output)
  /* MUX.vhd:18:13  */
  assign n544_o = sel == 1'b0;
  /* MUX.vhd:19:13  */
  assign n546_o = sel == 1'b1;
  assign n547_o = {n546_o, n544_o};
  /* MUX.vhd:17:3  */
  always @*
    case (n547_o)
      2'b10: n548_o = d1;
      2'b01: n548_o = d0;
      default: n548_o = d0;
    endcase
endmodule

module mux3_32
  (input  [31:0] d0,
   input  [31:0] d1,
   input  [31:0] d2,
   input  [1:0] sel,
   output [31:0] y);
  wire n535_o;
  wire n537_o;
  wire n539_o;
  wire [2:0] n540_o;
  reg [31:0] n541_o;
  assign y = n541_o; //(module output)
  /* MUX3.vhd:19:13  */
  assign n535_o = sel == 2'b00;
  /* MUX3.vhd:20:13  */
  assign n537_o = sel == 2'b01;
  /* MUX3.vhd:21:13  */
  assign n539_o = sel == 2'b10;
  assign n540_o = {n539_o, n537_o, n535_o};
  /* MUX3.vhd:18:3  */
  always @*
    case (n540_o)
      3'b100: n541_o = d2;
      3'b010: n541_o = d1;
      3'b001: n541_o = d0;
      default: n541_o = d0;
    endcase
endmodule

module data_memory_64_6
  (input  clk,
   input  we,
   input  [31:0] a,
   input  [31:0] wd,
   output [31:0] rd);
  wire [5:0] n511_o;
  wire [5:0] n519_o;
  wire [31:0] n531_data; // mem_rd
  assign rd = n531_data; //(module output)
  /* DATA_MEMORY.vhd:24:37  */
  assign n511_o = a[7:2]; // extract
  /* DATA_MEMORY.vhd:30:37  */
  assign n519_o = a[7:2]; // extract
  /* DATA_MEMORY.vhd:24:16  */
  reg [31:0] memory[63:0] ; // memory
  initial begin
    memory[63] = 32'b00000000000000000000000000000000;
    memory[62] = 32'b00000000000000000000000000000000;
    memory[61] = 32'b00000000000000000000000000000000;
    memory[60] = 32'b00000000000000000000000000000000;
    memory[59] = 32'b00000000000000000000000000000000;
    memory[58] = 32'b00000000000000000000000000000000;
    memory[57] = 32'b00000000000000000000000000000000;
    memory[56] = 32'b00000000000000000000000000000000;
    memory[55] = 32'b00000000000000000000000000000000;
    memory[54] = 32'b00000000000000000000000000000000;
    memory[53] = 32'b00000000000000000000000000000000;
    memory[52] = 32'b00000000000000000000000000000000;
    memory[51] = 32'b00000000000000000000000000000000;
    memory[50] = 32'b00000000000000000000000000000000;
    memory[49] = 32'b00000000000000000000000000000000;
    memory[48] = 32'b00000000000000000000000000000000;
    memory[47] = 32'b00000000000000000000000000000000;
    memory[46] = 32'b00000000000000000000000000000000;
    memory[45] = 32'b00000000000000000000000000000000;
    memory[44] = 32'b00000000000000000000000000000000;
    memory[43] = 32'b00000000000000000000000000000000;
    memory[42] = 32'b00000000000000000000000000000000;
    memory[41] = 32'b00000000000000000000000000000000;
    memory[40] = 32'b00000000000000000000000000000000;
    memory[39] = 32'b00000000000000000000000000000000;
    memory[38] = 32'b00000000000000000000000000000000;
    memory[37] = 32'b00000000000000000000000000000000;
    memory[36] = 32'b00000000000000000000000000000000;
    memory[35] = 32'b00000000000000000000000000000000;
    memory[34] = 32'b00000000000000000000000000000000;
    memory[33] = 32'b00000000000000000000000000000000;
    memory[32] = 32'b00000000000000000000000000000000;
    memory[31] = 32'b00000000000000000000000000000000;
    memory[30] = 32'b00000000000000000000000000000000;
    memory[29] = 32'b00000000000000000000000000000000;
    memory[28] = 32'b00000000000000000000000000000000;
    memory[27] = 32'b00000000000000000000000000000000;
    memory[26] = 32'b00000000000000000000000000000000;
    memory[25] = 32'b00000000000000000000000000000000;
    memory[24] = 32'b00000000000000000000000000000000;
    memory[23] = 32'b00000000000000000000000000000000;
    memory[22] = 32'b00000000000000000000000000000000;
    memory[21] = 32'b00000000000000000000000000000000;
    memory[20] = 32'b00000000000000000000000000000000;
    memory[19] = 32'b00000000000000000000000000000000;
    memory[18] = 32'b00000000000000000000000000000000;
    memory[17] = 32'b00000000000000000000000000000000;
    memory[16] = 32'b00000000000000000000000000000000;
    memory[15] = 32'b00000000000000000000000000000000;
    memory[14] = 32'b00000000000000000000000000000000;
    memory[13] = 32'b00000000000000000000000000000000;
    memory[12] = 32'b00000000000000000000000000000000;
    memory[11] = 32'b00000000000000000000000000000000;
    memory[10] = 32'b00000000000000000000000000000000;
    memory[9] = 32'b00000000000000000000000000000000;
    memory[8] = 32'b00000000000000000000000000000000;
    memory[7] = 32'b00000000000000000000000000000000;
    memory[6] = 32'b00000000000000000000000000000000;
    memory[5] = 32'b00000000000000000000000000000000;
    memory[4] = 32'b00000000000000000000000000000000;
    memory[3] = 32'b00000000000000000000000000000000;
    memory[2] = 32'b00000000000000000000000000000000;
    memory[1] = 32'b00000000000000000000000000000000;
    memory[0] = 32'b00000000000000000000000000000000;
    end
  assign n531_data = memory[n511_o];
  always @(posedge clk)
    if (we)
      memory[n519_o] <= wd;
  /* DATA_MEMORY.vhd:24:16  */
  /* DATA_MEMORY.vhd:30:16  */
endmodule

module alu
  (input  [31:0] srca,
   input  [31:0] srcb,
   input  [2:0] alu_cont,
   output zero,
   output [31:0] alu_res);
  wire [31:0] n482_o;
  wire n484_o;
  wire [31:0] n485_o;
  wire n487_o;
  wire [31:0] n488_o;
  wire n490_o;
  wire [31:0] n491_o;
  wire n493_o;
  wire n494_o;
  wire [31:0] n497_o;
  wire n499_o;
  wire [4:0] n500_o;
  reg [31:0] n502_o;
  wire n504_o;
  wire n507_o;
  assign zero = n507_o; //(module output)
  assign alu_res = n502_o; //(module output)
  /* ALU.vhd:26:24  */
  assign n482_o = srca & srcb;
  /* ALU.vhd:25:7  */
  assign n484_o = alu_cont == 3'b000;
  /* ALU.vhd:28:24  */
  assign n485_o = srca | srcb;
  /* ALU.vhd:27:7  */
  assign n487_o = alu_cont == 3'b001;
  /* ALU.vhd:30:49  */
  assign n488_o = srca + srcb;
  /* ALU.vhd:29:7  */
  assign n490_o = alu_cont == 3'b010;
  /* ALU.vhd:32:49  */
  assign n491_o = srca - srcb;
  /* ALU.vhd:31:7  */
  assign n493_o = alu_cont == 3'b110;
  /* ALU.vhd:34:26  */
  assign n494_o = $signed(srca) < $signed(srcb);
  /* ALU.vhd:34:9  */
  assign n497_o = n494_o ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
  /* ALU.vhd:33:7  */
  assign n499_o = alu_cont == 3'b111;
  assign n500_o = {n499_o, n493_o, n490_o, n487_o, n484_o};
  /* ALU.vhd:24:5  */
  always @*
    case (n500_o)
      5'b10000: n502_o = n497_o;
      5'b01000: n502_o = n491_o;
      5'b00100: n502_o = n488_o;
      5'b00010: n502_o = n485_o;
      5'b00001: n502_o = n482_o;
      default: n502_o = 32'b00000000000000000000000000000000;
    endcase
  /* ALU.vhd:43:16  */
  assign n504_o = n502_o == 32'b00000000000000000000000000000000;
  /* ALU.vhd:43:6  */
  assign n507_o = n504_o ? 1'b1 : 1'b0;
endmodule

module sign_extend
  (input  [2:0] imm_src,
   input  [31:0] instr,
   output [31:0] sign_imm);
  wire n342_o;
  wire n343_o;
  wire n344_o;
  wire n345_o;
  wire n346_o;
  wire n347_o;
  wire n348_o;
  wire n349_o;
  wire n350_o;
  wire n351_o;
  wire n352_o;
  wire n353_o;
  wire n354_o;
  wire n355_o;
  wire n356_o;
  wire n357_o;
  wire n358_o;
  wire n359_o;
  wire n360_o;
  wire n361_o;
  wire [3:0] n362_o;
  wire [3:0] n363_o;
  wire [3:0] n364_o;
  wire [3:0] n365_o;
  wire [3:0] n366_o;
  wire [15:0] n367_o;
  wire [19:0] n368_o;
  wire [11:0] n369_o;
  wire [31:0] n370_o;
  wire n372_o;
  wire n373_o;
  wire n374_o;
  wire n375_o;
  wire n376_o;
  wire n377_o;
  wire n378_o;
  wire n379_o;
  wire n380_o;
  wire n381_o;
  wire n382_o;
  wire n383_o;
  wire n384_o;
  wire n385_o;
  wire n386_o;
  wire n387_o;
  wire n388_o;
  wire n389_o;
  wire n390_o;
  wire n391_o;
  wire n392_o;
  wire [3:0] n393_o;
  wire [3:0] n394_o;
  wire [3:0] n395_o;
  wire [3:0] n396_o;
  wire [3:0] n397_o;
  wire [15:0] n398_o;
  wire [19:0] n399_o;
  wire [6:0] n400_o;
  wire [26:0] n401_o;
  wire [4:0] n402_o;
  wire [31:0] n403_o;
  wire n405_o;
  wire n406_o;
  wire n407_o;
  wire n408_o;
  wire n409_o;
  wire n410_o;
  wire n411_o;
  wire n412_o;
  wire n413_o;
  wire n414_o;
  wire n415_o;
  wire n416_o;
  wire n417_o;
  wire n418_o;
  wire n419_o;
  wire n420_o;
  wire n421_o;
  wire n422_o;
  wire n423_o;
  wire n424_o;
  wire n425_o;
  wire [3:0] n426_o;
  wire [3:0] n427_o;
  wire [3:0] n428_o;
  wire [3:0] n429_o;
  wire [3:0] n430_o;
  wire [15:0] n431_o;
  wire [19:0] n432_o;
  wire n433_o;
  wire [20:0] n434_o;
  wire [5:0] n435_o;
  wire [26:0] n436_o;
  wire [3:0] n437_o;
  wire [30:0] n438_o;
  wire [31:0] n440_o;
  wire n442_o;
  wire n443_o;
  wire n444_o;
  wire n445_o;
  wire n446_o;
  wire n447_o;
  wire n448_o;
  wire n449_o;
  wire n450_o;
  wire n451_o;
  wire n452_o;
  wire n453_o;
  wire n454_o;
  wire [3:0] n455_o;
  wire [3:0] n456_o;
  wire [3:0] n457_o;
  wire [11:0] n458_o;
  wire [7:0] n459_o;
  wire [19:0] n460_o;
  wire n461_o;
  wire [20:0] n462_o;
  wire [9:0] n463_o;
  wire [30:0] n464_o;
  wire [31:0] n466_o;
  wire n468_o;
  wire [19:0] n469_o;
  wire [31:0] n471_o;
  wire n473_o;
  wire [4:0] n474_o;
  reg [31:0] n476_o;
  assign sign_imm = n476_o; //(module output)
  /* SIGN_EXTEND.vhd:21:38  */
  assign n342_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n343_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n344_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n345_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n346_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n347_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n348_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n349_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n350_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n351_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n352_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n353_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n354_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n355_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n356_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n357_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n358_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n359_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n360_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:21:38  */
  assign n361_o = instr[31]; // extract
  /* TOP.vhd:651:26  */
  assign n362_o = {n361_o, n360_o, n359_o, n358_o};
  /* TOP.vhd:650:26  */
  assign n363_o = {n357_o, n356_o, n355_o, n354_o};
  /* TOP.vhd:649:26  */
  assign n364_o = {n353_o, n352_o, n351_o, n350_o};
  /* TOP.vhd:648:26  */
  assign n365_o = {n349_o, n348_o, n347_o, n346_o};
  /* TOP.vhd:647:26  */
  assign n366_o = {n345_o, n344_o, n343_o, n342_o};
  /* TOP.vhd:646:26  */
  assign n367_o = {n362_o, n363_o, n364_o, n365_o};
  /* TOP.vhd:645:26  */
  assign n368_o = {n367_o, n366_o};
  /* SIGN_EXTEND.vhd:21:50  */
  assign n369_o = instr[31:20]; // extract
  /* SIGN_EXTEND.vhd:21:43  */
  assign n370_o = {n368_o, n369_o};
  /* SIGN_EXTEND.vhd:20:5  */
  assign n372_o = imm_src == 3'b000;
  /* SIGN_EXTEND.vhd:23:38  */
  assign n373_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n374_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n375_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n376_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n377_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n378_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n379_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n380_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n381_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n382_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n383_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n384_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n385_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n386_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n387_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n388_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n389_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n390_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n391_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:23:38  */
  assign n392_o = instr[31]; // extract
  /* TOP.vhd:618:27  */
  assign n393_o = {n392_o, n391_o, n390_o, n389_o};
  /* TOP.vhd:610:3  */
  assign n394_o = {n388_o, n387_o, n386_o, n385_o};
  /* TOP.vhd:610:3  */
  assign n395_o = {n384_o, n383_o, n382_o, n381_o};
  /* TOP.vhd:610:3  */
  assign n396_o = {n380_o, n379_o, n378_o, n377_o};
  /* TOP.vhd:610:3  */
  assign n397_o = {n376_o, n375_o, n374_o, n373_o};
  /* TOP.vhd:610:3  */
  assign n398_o = {n393_o, n394_o, n395_o, n396_o};
  /* TOP.vhd:610:3  */
  assign n399_o = {n398_o, n397_o};
  /* SIGN_EXTEND.vhd:23:50  */
  assign n400_o = instr[31:25]; // extract
  /* SIGN_EXTEND.vhd:23:43  */
  assign n401_o = {n399_o, n400_o};
  /* SIGN_EXTEND.vhd:23:71  */
  assign n402_o = instr[11:7]; // extract
  /* SIGN_EXTEND.vhd:23:64  */
  assign n403_o = {n401_o, n402_o};
  /* SIGN_EXTEND.vhd:22:5  */
  assign n405_o = imm_src == 3'b001;
  /* SIGN_EXTEND.vhd:25:38  */
  assign n406_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n407_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n408_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n409_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n410_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n411_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n412_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n413_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n414_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n415_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n416_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n417_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n418_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n419_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n420_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n421_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n422_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n423_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n424_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:25:38  */
  assign n425_o = instr[31]; // extract
  /* TOP.vhd:573:3  */
  assign n426_o = {n425_o, n424_o, n423_o, n422_o};
  /* TOP.vhd:573:3  */
  assign n427_o = {n421_o, n420_o, n419_o, n418_o};
  /* TOP.vhd:571:19  */
  assign n428_o = {n417_o, n416_o, n415_o, n414_o};
  /* TOP.vhd:566:3  */
  assign n429_o = {n413_o, n412_o, n411_o, n410_o};
  /* TOP.vhd:563:19  */
  assign n430_o = {n409_o, n408_o, n407_o, n406_o};
  /* TOP.vhd:557:3  */
  assign n431_o = {n426_o, n427_o, n428_o, n429_o};
  /* TOP.vhd:554:19  */
  assign n432_o = {n431_o, n430_o};
  /* SIGN_EXTEND.vhd:25:50  */
  assign n433_o = instr[7]; // extract
  /* SIGN_EXTEND.vhd:25:43  */
  assign n434_o = {n432_o, n433_o};
  /* SIGN_EXTEND.vhd:25:61  */
  assign n435_o = instr[30:25]; // extract
  /* SIGN_EXTEND.vhd:25:53  */
  assign n436_o = {n434_o, n435_o};
  /* SIGN_EXTEND.vhd:25:83  */
  assign n437_o = instr[11:8]; // extract
  /* SIGN_EXTEND.vhd:25:76  */
  assign n438_o = {n436_o, n437_o};
  /* SIGN_EXTEND.vhd:25:96  */
  assign n440_o = {n438_o, 1'b0};
  /* SIGN_EXTEND.vhd:24:5  */
  assign n442_o = imm_src == 3'b010;
  /* SIGN_EXTEND.vhd:27:39  */
  assign n443_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n444_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n445_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n446_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n447_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n448_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n449_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n450_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n451_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n452_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n453_o = instr[31]; // extract
  /* SIGN_EXTEND.vhd:27:39  */
  assign n454_o = instr[31]; // extract
  /* TOP.vhd:14:6  */
  assign n455_o = {n454_o, n453_o, n452_o, n451_o};
  /* TOP.vhd:13:6  */
  assign n456_o = {n450_o, n449_o, n448_o, n447_o};
  /* TOP.vhd:12:6  */
  assign n457_o = {n446_o, n445_o, n444_o, n443_o};
  /* TOP.vhd:11:6  */
  assign n458_o = {n455_o, n456_o, n457_o};
  /* SIGN_EXTEND.vhd:27:51  */
  assign n459_o = instr[19:12]; // extract
  /* SIGN_EXTEND.vhd:27:44  */
  assign n460_o = {n458_o, n459_o};
  /* SIGN_EXTEND.vhd:27:72  */
  assign n461_o = instr[20]; // extract
  /* SIGN_EXTEND.vhd:27:65  */
  assign n462_o = {n460_o, n461_o};
  /* SIGN_EXTEND.vhd:27:84  */
  assign n463_o = instr[30:21]; // extract
  /* SIGN_EXTEND.vhd:27:77  */
  assign n464_o = {n462_o, n463_o};
  /* SIGN_EXTEND.vhd:27:98  */
  assign n466_o = {n464_o, 1'b0};
  /* SIGN_EXTEND.vhd:26:5  */
  assign n468_o = imm_src == 3'b011;
  /* SIGN_EXTEND.vhd:29:23  */
  assign n469_o = instr[31:12]; // extract
  /* SIGN_EXTEND.vhd:29:37  */
  assign n471_o = {n469_o, 12'b000000000000};
  /* SIGN_EXTEND.vhd:28:5  */
  assign n473_o = imm_src == 3'b100;
  assign n474_o = {n473_o, n468_o, n442_o, n405_o, n372_o};
  /* SIGN_EXTEND.vhd:19:5  */
  always @*
    case (n474_o)
      5'b10000: n476_o = n471_o;
      5'b01000: n476_o = n466_o;
      5'b00100: n476_o = n440_o;
      5'b00010: n476_o = n403_o;
      5'b00001: n476_o = n370_o;
      default: n476_o = 32'b00000000000000000000000000000000;
    endcase
endmodule

module register_file
  (input  clk,
   input  we3,
   input  [4:0] ra1,
   input  [4:0] ra2,
   input  [4:0] rd,
   input  [31:0] wd3,
   output [31:0] rd1,
   output [31:0] rd2);
  wire n324_o;
  wire n331_o;
  wire [31:0] n337_data; // mem_rd
  wire [31:0] n338_data; // mem_rd
  assign rd1 = n338_data; //(module output)
  assign rd2 = n337_data; //(module output)
  /* REGISTER_FILE.vhd:29:15  */
  assign n324_o = rd != 5'b00000;
  /* REGISTER_FILE.vhd:28:7  */
  assign n331_o = n324_o & we3;
  /* REGISTER_FILE.vhd:22:19  */
  reg [31:0] reg_type[31:0] ; // memory
  initial begin
    reg_type[31] = 32'b00000000000000000000000000000000;
    reg_type[30] = 32'b00000000000000000000000000000000;
    reg_type[29] = 32'b00000000000000000000000000000000;
    reg_type[28] = 32'b00000000000000000000000000000000;
    reg_type[27] = 32'b00000000000000000000000000000000;
    reg_type[26] = 32'b00000000000000000000000000000000;
    reg_type[25] = 32'b00000000000000000000000000000000;
    reg_type[24] = 32'b00000000000000000000000000000000;
    reg_type[23] = 32'b00000000000000000000000000000000;
    reg_type[22] = 32'b00000000000000000000000000000000;
    reg_type[21] = 32'b00000000000000000000000000000000;
    reg_type[20] = 32'b00000000000000000000000000000000;
    reg_type[19] = 32'b00000000000000000000000000000000;
    reg_type[18] = 32'b00000000000000000000000000000000;
    reg_type[17] = 32'b00000000000000000000000000000000;
    reg_type[16] = 32'b00000000000000000000000000000000;
    reg_type[15] = 32'b00000000000000000000000000000000;
    reg_type[14] = 32'b00000000000000000000000000000000;
    reg_type[13] = 32'b00000000000000000000000000000000;
    reg_type[12] = 32'b00000000000000000000000000000000;
    reg_type[11] = 32'b00000000000000000000000000000000;
    reg_type[10] = 32'b00000000000000000000000000000000;
    reg_type[9] = 32'b00000000000000000000000000000000;
    reg_type[8] = 32'b00000000000000000000000000000000;
    reg_type[7] = 32'b00000000000000000000000000000000;
    reg_type[6] = 32'b00000000000000000000000000000000;
    reg_type[5] = 32'b00000000000000000000000000000000;
    reg_type[4] = 32'b00000000000000000000000000000000;
    reg_type[3] = 32'b00000000000000000000000000000000;
    reg_type[2] = 32'b00000000000000000000000000000000;
    reg_type[1] = 32'b00000000000000000000000000000000;
    reg_type[0] = 32'b00000000000000000000000000000000;
    end
  assign n337_data = reg_type[ra2];
  assign n338_data = reg_type[ra1];
  always @(negedge clk)
    if (n331_o)
      reg_type[rd] <= wd3;
  /* REGISTER_FILE.vhd:23:19  */
  /* REGISTER_FILE.vhd:22:19  */
  /* REGISTER_FILE.vhd:30:20  */
endmodule

module instruction_memory
  (input  [31:0] address,
   output [31:0] instr);
  reg [2047:0] memory;
  wire [29:0] n299_o;
  wire [5:0] n301_o;
  wire [5:0] n303_o;
  wire [31:0] n307_data; // mem_rd
  assign instr = n307_data; //(module output)
  /* INSTRUCTION_MEMORY.vhd:20:8  */
  always @*
    memory = 2048'b00000000000100000000000010010011000000000010000000000001000100110000000001000000000000011001001100000000100000000000001000010011000001000001000000100000001000110000010000100000001000000010001100000100001100000010000000100011000001000100000000100000001000111111111100011111111100000110111100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011; // (isignal)
  initial
    memory = 2048'b00000000000100000000000010010011000000000010000000000001000100110000000001000000000000011001001100000000100000000000001000010011000001000001000000100000001000110000010000100000001000000010001100000100001100000010000000100011000001000100000000100000001000111111111100011111111100000110111100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011000000000000000000000000000100110000000000000000000000000001001100000000000000000000000000010011;
  /* INSTRUCTION_MEMORY.vhd:36:46  */
  assign n299_o = address[31:2]; // extract
  /* INSTRUCTION_MEMORY.vhd:36:19  */
  assign n301_o = n299_o[5:0];  // trunc
  /* INSTRUCTION_MEMORY.vhd:36:19  */
  assign n303_o = 6'b111111 - n301_o;
  /* INSTRUCTION_MEMORY.vhd:8:6  */
  reg [31:0] n306[63:0] ; // memory
  initial begin
    n306[63] = 32'b00000000000100000000000010010011;
    n306[62] = 32'b00000000001000000000000100010011;
    n306[61] = 32'b00000000010000000000000110010011;
    n306[60] = 32'b00000000100000000000001000010011;
    n306[59] = 32'b00000100000100000010000000100011;
    n306[58] = 32'b00000100001000000010000000100011;
    n306[57] = 32'b00000100001100000010000000100011;
    n306[56] = 32'b00000100010000000010000000100011;
    n306[55] = 32'b11111111000111111111000001101111;
    n306[54] = 32'b00000000000000000000000000010011;
    n306[53] = 32'b00000000000000000000000000010011;
    n306[52] = 32'b00000000000000000000000000010011;
    n306[51] = 32'b00000000000000000000000000010011;
    n306[50] = 32'b00000000000000000000000000010011;
    n306[49] = 32'b00000000000000000000000000010011;
    n306[48] = 32'b00000000000000000000000000010011;
    n306[47] = 32'b00000000000000000000000000010011;
    n306[46] = 32'b00000000000000000000000000010011;
    n306[45] = 32'b00000000000000000000000000010011;
    n306[44] = 32'b00000000000000000000000000010011;
    n306[43] = 32'b00000000000000000000000000010011;
    n306[42] = 32'b00000000000000000000000000010011;
    n306[41] = 32'b00000000000000000000000000010011;
    n306[40] = 32'b00000000000000000000000000010011;
    n306[39] = 32'b00000000000000000000000000010011;
    n306[38] = 32'b00000000000000000000000000010011;
    n306[37] = 32'b00000000000000000000000000010011;
    n306[36] = 32'b00000000000000000000000000010011;
    n306[35] = 32'b00000000000000000000000000010011;
    n306[34] = 32'b00000000000000000000000000010011;
    n306[33] = 32'b00000000000000000000000000010011;
    n306[32] = 32'b00000000000000000000000000010011;
    n306[31] = 32'b00000000000000000000000000010011;
    n306[30] = 32'b00000000000000000000000000010011;
    n306[29] = 32'b00000000000000000000000000010011;
    n306[28] = 32'b00000000000000000000000000010011;
    n306[27] = 32'b00000000000000000000000000010011;
    n306[26] = 32'b00000000000000000000000000010011;
    n306[25] = 32'b00000000000000000000000000010011;
    n306[24] = 32'b00000000000000000000000000010011;
    n306[23] = 32'b00000000000000000000000000010011;
    n306[22] = 32'b00000000000000000000000000010011;
    n306[21] = 32'b00000000000000000000000000010011;
    n306[20] = 32'b00000000000000000000000000010011;
    n306[19] = 32'b00000000000000000000000000010011;
    n306[18] = 32'b00000000000000000000000000010011;
    n306[17] = 32'b00000000000000000000000000010011;
    n306[16] = 32'b00000000000000000000000000010011;
    n306[15] = 32'b00000000000000000000000000010011;
    n306[14] = 32'b00000000000000000000000000010011;
    n306[13] = 32'b00000000000000000000000000010011;
    n306[12] = 32'b00000000000000000000000000010011;
    n306[11] = 32'b00000000000000000000000000010011;
    n306[10] = 32'b00000000000000000000000000010011;
    n306[9] = 32'b00000000000000000000000000010011;
    n306[8] = 32'b00000000000000000000000000010011;
    n306[7] = 32'b00000000000000000000000000010011;
    n306[6] = 32'b00000000000000000000000000010011;
    n306[5] = 32'b00000000000000000000000000010011;
    n306[4] = 32'b00000000000000000000000000010011;
    n306[3] = 32'b00000000000000000000000000010011;
    n306[2] = 32'b00000000000000000000000000010011;
    n306[1] = 32'b00000000000000000000000000010011;
    n306[0] = 32'b00000000000000000000000000010011;
    end
  assign n307_data = n306[n303_o];
  /* INSTRUCTION_MEMORY.vhd:36:19  */
endmodule

module program_counter
  (input  clk,
   input  rst,
   input  [31:0] pc_next,
   input  stall,
   output [31:0] pc);
  wire n289_o;
  wire [31:0] n295_o;
  reg [31:0] n296_q;
  assign pc = n296_q; //(module output)
  /* PROGRAM_COUNTER.vhd:22:14  */
  assign n289_o = ~stall;
  /* PROGRAM_COUNTER.vhd:21:5  */
  assign n295_o = n289_o ? pc_next : n296_q;
  /* PROGRAM_COUNTER.vhd:21:5  */
  always @(posedge clk or posedge rst)
    if (rst)
      n296_q <= 32'b00000000000000000000000000000000;
    else
      n296_q <= n295_o;
endmodule

module top
  (input  clk,
   input  rst,
   output [7:0] gpio_out,
   output valid_w_dbg,
   output stall_f_dbg,
   output stall_d_dbg,
   output flush_d_dbg,
   output flush_e_dbg,
   output branch_e_dbg,
   output jump_e_dbg);
  wire dmem_we;
  reg branch_prediction_enable;
  wire predict_taken_f;
  wire actual_taken_e;
  wire predictor_update_e;
  wire [31:0] predicted_target_f;
  wire predicted_taken_d;
  wire predicted_taken_e;
  wire [31:0] predicted_target_d;
  wire [31:0] predicted_target_e;
  wire target_mismatch_e;
  wire taken_mismatch_e;
  wire mispredict_e;
  wire [31:0] correct_pc_e;
  wire valid_f;
  wire valid_d;
  wire valid_e;
  wire valid_m;
  wire valid_w;
  wire reg_write_real;
  wire mem_write_real;
  reg rst_sync1;
  reg rst_sync2;
  wire rst_local;
  wire [31:0] pc;
  wire [31:0] pc_next;
  wire [31:0] pc_plus_4;
  wire [31:0] instr;
  wire [31:0] result_w;
  wire [31:0] srca_e;
  wire [31:0] srcb_e;
  wire zero_e;
  wire funct7_5;
  wire [2:0] imm_src;
  wire [6:0] op;
  wire [2:0] funct3;
  wire [31:0] pc_target_e;
  wire pc_src_e;
  wire [31:0] instr_d;
  wire [31:0] pc_d;
  wire [31:0] pc_plus_4_d;
  wire [1:0] res_src_d;
  wire [1:0] res_src_e;
  wire mem_write_d;
  wire mem_write_e;
  wire [2:0] alu_cont_d;
  wire [2:0] alu_cont_e;
  wire alu_src_d;
  wire alu_src_e;
  wire reg_write_d;
  wire reg_write_e;
  wire branch_d;
  wire branch_e;
  wire jump_d;
  wire jump_e;
  wire [31:0] rd1_d;
  wire [31:0] rd2_d;
  wire [31:0] rd1_e;
  wire [31:0] rd2_e;
  wire [4:0] ra1_d;
  wire [4:0] ra2_d;
  wire [4:0] rd_d;
  wire [4:0] ra1_e;
  wire [4:0] ra2_e;
  wire [4:0] rd_e;
  wire [31:0] sign_imm_d;
  wire [31:0] sign_imm_e;
  wire [31:0] pc_e;
  wire [31:0] pc_plus_4_e;
  wire [1:0] res_src_m;
  wire mem_write_m;
  wire reg_write_m;
  wire [4:0] rd_m;
  wire [31:0] pc_plus_4_m;
  wire [31:0] alu_res_e;
  wire [31:0] alu_res_m;
  wire [31:0] write_data_e;
  wire [31:0] write_data_m;
  wire [1:0] res_src_w;
  wire reg_write_w;
  wire [31:0] read_data_w;
  wire [31:0] read_data_m;
  wire [4:0] rd_w;
  wire [31:0] pc_plus_4_w;
  wire [31:0] alu_res_w;
  wire stall_f;
  wire stall_d;
  wire flush_d;
  wire flush_e;
  wire [1:0] forward_ae;
  wire [1:0] forward_be;
  wire [31:0] n13_o;
  wire [31:0] n14_o;
  wire n15_o;
  wire n16_o;
  wire n17_o;
  wire n18_o;
  wire n19_o;
  wire n20_o;
  wire n21_o;
  wire n22_o;
  wire n23_o;
  wire n24_o;
  wire n25_o;
  wire n27_o;
  wire n28_o;
  wire n29_o;
  wire n30_o;
  wire n31_o;
  wire n32_o;
  wire [31:0] n34_o;
  wire n35_o;
  wire n36_o;
  wire n37_o;
  wire n38_o;
  wire n41_o;
  wire [31:0] n42_o;
  wire [31:0] n43_o;
  wire [31:0] n44_o;
  wire n45_o;
  wire n46_o;
  wire n47_o;
  wire [31:0] n48_o;
  wire [31:0] n49_o;
  wire n62_o;
  wire n63_o;
  wire [6:0] n64_o;
  wire [2:0] n65_o;
  wire n66_o;
  wire [4:0] n67_o;
  wire [4:0] n68_o;
  wire [4:0] n69_o;
  wire [31:0] pc_reg_n70;
  wire [31:0] pc_reg_pc;
  wire [31:0] imem_n73;
  wire [31:0] imem_instr;
  wire [31:0] rf_n76;
  wire [31:0] rf_n77;
  wire [31:0] rf_rd1;
  wire [31:0] rf_rd2;
  wire [31:0] se_n82;
  wire [31:0] se_sign_imm;
  wire alu_unit_n85;
  wire [31:0] alu_unit_n86;
  wire alu_unit_zero;
  wire [31:0] alu_unit_alu_res;
  wire [31:0] dmem_n91;
  wire [31:0] dmem_rd;
  wire [31:0] mux_res_src_n94;
  wire [31:0] mux_res_src_y;
  wire [31:0] mux_fwd_a_n97;
  wire [31:0] mux_fwd_a_y;
  wire [31:0] mux_fwd_b_n100;
  wire [31:0] mux_fwd_b_y;
  wire [31:0] mux_alusrc_n103;
  wire [31:0] mux_alusrc_y;
  wire [1:0] ctrl_n106;
  wire ctrl_n107;
  wire [2:0] ctrl_n108;
  wire ctrl_n109;
  wire [2:0] ctrl_n110;
  wire ctrl_n111;
  wire ctrl_n112;
  wire ctrl_n113;
  wire [1:0] ctrl_res_src;
  wire ctrl_mem_write;
  wire [2:0] ctrl_alu_cont;
  wire ctrl_alu_src;
  wire [2:0] ctrl_imm_src;
  wire ctrl_reg_write;
  wire ctrl_branch;
  wire ctrl_jump;
  wire hz_n130;
  wire hz_n131;
  wire hz_n132;
  wire hz_n133;
  wire [1:0] hz_n134;
  wire [1:0] hz_n135;
  wire hz_stall_f;
  wire hz_stall_d;
  wire hz_flush_d;
  wire hz_flush_e;
  wire [1:0] hz_forward_ae;
  wire [1:0] hz_forward_be;
  wire ifid_n148;
  wire [31:0] ifid_n149;
  wire [31:0] ifid_n150;
  wire [31:0] ifid_n151;
  wire ifid_n152;
  wire [31:0] ifid_n153;
  wire ifid_predicted_taken_d;
  wire [31:0] ifid_predicted_target_d;
  wire ifid_valid_d;
  wire [31:0] ifid_instr_d;
  wire [31:0] ifid_pc_d;
  wire [31:0] ifid_pc_plus_4_d;
  wire idex_n166;
  wire [1:0] idex_n167;
  wire idex_n168;
  wire [2:0] idex_n169;
  wire idex_n170;
  wire idex_n171;
  wire idex_n172;
  wire idex_n173;
  wire [31:0] idex_n174;
  wire [31:0] idex_n175;
  wire [4:0] idex_n176;
  wire [4:0] idex_n177;
  wire [4:0] idex_n178;
  wire [31:0] idex_n179;
  wire [31:0] idex_n180;
  wire [31:0] idex_n181;
  wire idex_n182;
  wire [31:0] idex_n183;
  wire idex_valid_e;
  wire [1:0] idex_res_src_e;
  wire idex_mem_write_e;
  wire [2:0] idex_alu_cont_e;
  wire idex_alu_src_e;
  wire idex_reg_write_e;
  wire idex_branch_e;
  wire idex_jump_e;
  wire idex_predicted_taken_e;
  wire [31:0] idex_predicted_target_e;
  wire [31:0] idex_rd1_e;
  wire [31:0] idex_rd2_e;
  wire [4:0] idex_ra1_e;
  wire [4:0] idex_ra2_e;
  wire [4:0] idex_rd_e;
  wire [31:0] idex_sign_imm_e;
  wire [31:0] idex_pc_plus_4_e;
  wire [31:0] idex_pc_e;
  wire exmem_n220;
  wire [1:0] exmem_n221;
  wire exmem_n222;
  wire exmem_n223;
  wire [4:0] exmem_n224;
  wire [31:0] exmem_n225;
  wire [31:0] exmem_n226;
  wire [31:0] exmem_n227;
  wire exmem_valid_m;
  wire [1:0] exmem_res_src_m;
  wire exmem_mem_write_m;
  wire exmem_reg_write_m;
  wire [4:0] exmem_rd_m;
  wire [31:0] exmem_pc_plus_4_m;
  wire [31:0] exmem_alu_res_m;
  wire [31:0] exmem_write_data_m;
  wire memwb_n244;
  wire [1:0] memwb_n245;
  wire memwb_n246;
  wire [31:0] memwb_n247;
  wire [4:0] memwb_n248;
  wire [31:0] memwb_n249;
  wire [31:0] memwb_n250;
  wire memwb_valid_w;
  wire [1:0] memwb_res_src_w;
  wire memwb_reg_write_w;
  wire [31:0] memwb_read_data_w;
  wire [4:0] memwb_rd_w;
  wire [31:0] memwb_pc_plus_4_w;
  wire [31:0] memwb_alu_res_w;
  wire bp_n265;
  wire [31:0] bp_n267;
  wire bp_predict_taken_f;
  wire [1:0] bp_debug_counter_f;
  wire [31:0] bp_predicted_target_f;
  wire bp_btb_valid_f;
  wire bus_unit_n277;
  wire [7:0] bus_unit_n278;
  wire bus_unit_dmem_we;
  wire [7:0] bus_unit_gpio_out;
  reg n283_q;
  reg n284_q;
  assign gpio_out = bus_unit_n278; //(module output)
  assign valid_w_dbg = valid_w; //(module output)
  assign stall_f_dbg = stall_f; //(module output)
  assign stall_d_dbg = stall_d; //(module output)
  assign flush_d_dbg = flush_d; //(module output)
  assign flush_e_dbg = flush_e; //(module output)
  assign branch_e_dbg = branch_e; //(module output)
  assign jump_e_dbg = jump_e; //(module output)
  /* TOP.vhd:23:8  */
  assign dmem_we = bus_unit_n277; // (signal)
  /* TOP.vhd:25:8  */
  always @*
    branch_prediction_enable = 1'b1; // (isignal)
  initial
    branch_prediction_enable = 1'b1;
  /* TOP.vhd:27:8  */
  assign predict_taken_f = bp_n265; // (signal)
  /* TOP.vhd:28:8  */
  assign actual_taken_e = n62_o; // (signal)
  /* TOP.vhd:29:8  */
  assign predictor_update_e = n63_o; // (signal)
  /* TOP.vhd:32:8  */
  assign predicted_target_f = bp_n267; // (signal)
  /* TOP.vhd:37:8  */
  assign predicted_taken_d = ifid_n152; // (signal)
  /* TOP.vhd:38:8  */
  assign predicted_taken_e = idex_n182; // (signal)
  /* TOP.vhd:40:8  */
  assign predicted_target_d = ifid_n153; // (signal)
  /* TOP.vhd:41:8  */
  assign predicted_target_e = idex_n183; // (signal)
  /* TOP.vhd:43:8  */
  assign target_mismatch_e = n32_o; // (signal)
  /* TOP.vhd:44:8  */
  assign taken_mismatch_e = n25_o; // (signal)
  /* TOP.vhd:45:8  */
  assign mispredict_e = n38_o; // (signal)
  /* TOP.vhd:46:8  */
  assign correct_pc_e = n34_o; // (signal)
  /* TOP.vhd:48:8  */
  assign valid_f = 1'b1; // (signal)
  /* TOP.vhd:49:8  */
  assign valid_d = ifid_n148; // (signal)
  /* TOP.vhd:50:8  */
  assign valid_e = idex_n166; // (signal)
  /* TOP.vhd:51:8  */
  assign valid_m = exmem_n220; // (signal)
  /* TOP.vhd:52:8  */
  assign valid_w = memwb_n244; // (signal)
  /* TOP.vhd:53:8  */
  assign reg_write_real = n15_o; // (signal)
  /* TOP.vhd:54:8  */
  assign mem_write_real = n16_o; // (signal)
  /* TOP.vhd:56:8  */
  always @*
    rst_sync1 = n283_q; // (isignal)
  initial
    rst_sync1 = 1'b1;
  /* TOP.vhd:57:8  */
  always @*
    rst_sync2 = n284_q; // (isignal)
  initial
    rst_sync2 = 1'b1;
  /* TOP.vhd:58:8  */
  assign rst_local = rst_sync2; // (signal)
  /* TOP.vhd:60:8  */
  assign pc = pc_reg_n70; // (signal)
  /* TOP.vhd:61:8  */
  assign pc_next = n49_o; // (signal)
  /* TOP.vhd:62:8  */
  assign pc_plus_4 = n13_o; // (signal)
  /* TOP.vhd:65:8  */
  assign instr = imem_n73; // (signal)
  /* TOP.vhd:70:8  */
  assign result_w = mux_res_src_n94; // (signal)
  /* TOP.vhd:72:8  */
  assign srca_e = mux_fwd_a_n97; // (signal)
  /* TOP.vhd:73:8  */
  assign srcb_e = mux_alusrc_n103; // (signal)
  /* TOP.vhd:75:8  */
  assign zero_e = alu_unit_n85; // (signal)
  /* TOP.vhd:83:8  */
  assign funct7_5 = n66_o; // (signal)
  /* TOP.vhd:86:8  */
  assign imm_src = ctrl_n110; // (signal)
  /* TOP.vhd:87:8  */
  assign op = n64_o; // (signal)
  /* TOP.vhd:88:8  */
  assign funct3 = n65_o; // (signal)
  /* TOP.vhd:91:8  */
  assign pc_target_e = n14_o; // (signal)
  /* TOP.vhd:92:8  */
  assign pc_src_e = n24_o; // (signal)
  /* TOP.vhd:99:8  */
  assign instr_d = ifid_n149; // (signal)
  /* TOP.vhd:100:8  */
  assign pc_d = ifid_n150; // (signal)
  /* TOP.vhd:101:8  */
  assign pc_plus_4_d = ifid_n151; // (signal)
  /* TOP.vhd:103:8  */
  assign res_src_d = ctrl_n106; // (signal)
  /* TOP.vhd:103:19  */
  assign res_src_e = idex_n167; // (signal)
  /* TOP.vhd:104:8  */
  assign mem_write_d = ctrl_n107; // (signal)
  /* TOP.vhd:104:21  */
  assign mem_write_e = idex_n168; // (signal)
  /* TOP.vhd:105:8  */
  assign alu_cont_d = ctrl_n108; // (signal)
  /* TOP.vhd:105:20  */
  assign alu_cont_e = idex_n169; // (signal)
  /* TOP.vhd:106:8  */
  assign alu_src_d = ctrl_n109; // (signal)
  /* TOP.vhd:106:19  */
  assign alu_src_e = idex_n170; // (signal)
  /* TOP.vhd:107:8  */
  assign reg_write_d = ctrl_n111; // (signal)
  /* TOP.vhd:107:21  */
  assign reg_write_e = idex_n171; // (signal)
  /* TOP.vhd:108:8  */
  assign branch_d = ctrl_n112; // (signal)
  /* TOP.vhd:108:18  */
  assign branch_e = idex_n172; // (signal)
  /* TOP.vhd:109:8  */
  assign jump_d = ctrl_n113; // (signal)
  /* TOP.vhd:109:16  */
  assign jump_e = idex_n173; // (signal)
  /* TOP.vhd:111:8  */
  assign rd1_d = rf_n76; // (signal)
  /* TOP.vhd:111:15  */
  assign rd2_d = rf_n77; // (signal)
  /* TOP.vhd:111:22  */
  assign rd1_e = idex_n174; // (signal)
  /* TOP.vhd:111:29  */
  assign rd2_e = idex_n175; // (signal)
  /* TOP.vhd:112:8  */
  assign ra1_d = n67_o; // (signal)
  /* TOP.vhd:112:15  */
  assign ra2_d = n68_o; // (signal)
  /* TOP.vhd:112:22  */
  assign rd_d = n69_o; // (signal)
  /* TOP.vhd:112:28  */
  assign ra1_e = idex_n176; // (signal)
  /* TOP.vhd:112:35  */
  assign ra2_e = idex_n177; // (signal)
  /* TOP.vhd:112:42  */
  assign rd_e = idex_n178; // (signal)
  /* TOP.vhd:113:8  */
  assign sign_imm_d = se_n82; // (signal)
  /* TOP.vhd:114:8  */
  assign sign_imm_e = idex_n179; // (signal)
  /* TOP.vhd:114:20  */
  assign pc_e = idex_n181; // (signal)
  /* TOP.vhd:114:26  */
  assign pc_plus_4_e = idex_n180; // (signal)
  /* TOP.vhd:116:8  */
  assign res_src_m = exmem_n221; // (signal)
  /* TOP.vhd:117:8  */
  assign mem_write_m = exmem_n222; // (signal)
  /* TOP.vhd:118:8  */
  assign reg_write_m = exmem_n223; // (signal)
  /* TOP.vhd:120:8  */
  assign rd_m = exmem_n224; // (signal)
  /* TOP.vhd:121:8  */
  assign pc_plus_4_m = exmem_n225; // (signal)
  /* TOP.vhd:121:21  */
  assign alu_res_e = alu_unit_n86; // (signal)
  /* TOP.vhd:121:32  */
  assign alu_res_m = exmem_n226; // (signal)
  /* TOP.vhd:122:8  */
  assign write_data_e = mux_fwd_b_n100; // (signal)
  /* TOP.vhd:122:22  */
  assign write_data_m = exmem_n227; // (signal)
  /* TOP.vhd:124:8  */
  assign res_src_w = memwb_n245; // (signal)
  /* TOP.vhd:125:8  */
  assign reg_write_w = memwb_n246; // (signal)
  /* TOP.vhd:127:8  */
  assign read_data_w = memwb_n247; // (signal)
  /* TOP.vhd:127:20  */
  assign read_data_m = dmem_n91; // (signal)
  /* TOP.vhd:128:8  */
  assign rd_w = memwb_n248; // (signal)
  /* TOP.vhd:129:8  */
  assign pc_plus_4_w = memwb_n249; // (signal)
  /* TOP.vhd:129:21  */
  assign alu_res_w = memwb_n250; // (signal)
  /* TOP.vhd:131:8  */
  assign stall_f = hz_n130; // (signal)
  /* TOP.vhd:131:17  */
  assign stall_d = hz_n131; // (signal)
  /* TOP.vhd:132:8  */
  assign flush_d = hz_n132; // (signal)
  /* TOP.vhd:132:17  */
  assign flush_e = hz_n133; // (signal)
  /* TOP.vhd:133:8  */
  assign forward_ae = hz_n134; // (signal)
  /* TOP.vhd:134:8  */
  assign forward_be = hz_n135; // (signal)
  /* TOP.vhd:393:45  */
  assign n13_o = pc + 32'b00000000000000000000000000000100;
  /* TOP.vhd:394:50  */
  assign n14_o = pc_e + sign_imm_e;
  /* TOP.vhd:397:29  */
  assign n15_o = valid_w & reg_write_w;
  /* TOP.vhd:398:29  */
  assign n16_o = valid_m & mem_write_m;
  /* TOP.vhd:400:41  */
  assign n17_o = branch_prediction_enable & mispredict_e;
  /* TOP.vhd:401:15  */
  assign n18_o = ~branch_prediction_enable;
  /* TOP.vhd:401:45  */
  assign n19_o = n18_o & valid_e;
  /* TOP.vhd:401:57  */
  assign n20_o = n19_o & branch_e;
  /* TOP.vhd:401:70  */
  assign n21_o = n20_o & zero_e;
  /* TOP.vhd:400:59  */
  assign n22_o = n17_o | n21_o;
  /* TOP.vhd:402:22  */
  assign n23_o = valid_e & jump_e;
  /* TOP.vhd:401:82  */
  assign n24_o = n22_o | n23_o;
  /* TOP.vhd:404:39  */
  assign n25_o = predicted_taken_e ^ actual_taken_e;
  /* TOP.vhd:407:19  */
  assign n27_o = branch_e & valid_e;
  /* TOP.vhd:407:38  */
  assign n28_o = predicted_taken_e & n27_o;
  /* TOP.vhd:408:29  */
  assign n29_o = actual_taken_e & n28_o;
  /* TOP.vhd:409:24  */
  assign n30_o = predicted_target_e != pc_target_e;
  /* TOP.vhd:408:54  */
  assign n31_o = n30_o & n29_o;
  /* TOP.vhd:406:26  */
  assign n32_o = n31_o ? 1'b1 : 1'b0;
  /* TOP.vhd:412:29  */
  assign n34_o = actual_taken_e ? pc_target_e : pc_plus_4_e;
  /* TOP.vhd:415:42  */
  assign n35_o = branch_prediction_enable & valid_e;
  /* TOP.vhd:415:54  */
  assign n36_o = n35_o & branch_e;
  /* TOP.vhd:416:35  */
  assign n37_o = taken_mismatch_e | target_mismatch_e;
  /* TOP.vhd:415:67  */
  assign n38_o = n36_o & n37_o;
  /* TOP.vhd:427:25  */
  assign n41_o = jump_e & valid_e;
  /* TOP.vhd:430:5  */
  assign n42_o = predict_taken_f ? predicted_target_f : pc_plus_4;
  /* TOP.vhd:427:5  */
  assign n43_o = n41_o ? pc_target_e : n42_o;
  /* TOP.vhd:424:5  */
  assign n44_o = mispredict_e ? correct_pc_e : n43_o;
  /* TOP.vhd:439:45  */
  assign n45_o = zero_e & branch_e;
  /* TOP.vhd:439:65  */
  assign n46_o = n45_o | jump_e;
  /* TOP.vhd:439:22  */
  assign n47_o = n46_o & valid_e;
  /* TOP.vhd:439:5  */
  assign n48_o = n47_o ? pc_target_e : pc_plus_4;
  /* TOP.vhd:422:3  */
  assign n49_o = branch_prediction_enable ? n44_o : n48_o;
  /* TOP.vhd:464:32  */
  assign n62_o = branch_e & zero_e;
  /* TOP.vhd:465:31  */
  assign n63_o = valid_e & branch_e;
  /* TOP.vhd:476:23  */
  assign n64_o = instr_d[6:0]; // extract
  /* TOP.vhd:477:23  */
  assign n65_o = instr_d[14:12]; // extract
  /* TOP.vhd:478:23  */
  assign n66_o = instr_d[30]; // extract
  /* TOP.vhd:479:23  */
  assign n67_o = instr_d[19:15]; // extract
  /* TOP.vhd:480:23  */
  assign n68_o = instr_d[24:20]; // extract
  /* TOP.vhd:481:23  */
  assign n69_o = instr_d[11:7]; // extract
  /* TOP.vhd:489:23  */
  assign pc_reg_n70 = pc_reg_pc; // (signal)
  /* TOP.vhd:483:3  */
  program_counter pc_reg (
    .clk(clk),
    .rst(rst_local),
    .pc_next(pc_next),
    .stall(stall_f),
    .pc(pc_reg_pc));
  /* TOP.vhd:494:24  */
  assign imem_n73 = imem_instr; // (signal)
  /* TOP.vhd:491:3  */
  instruction_memory imem (
    .address(pc),
    .instr(imem_instr));
  /* TOP.vhd:504:19  */
  assign rf_n76 = rf_rd1; // (signal)
  /* TOP.vhd:505:19  */
  assign rf_n77 = rf_rd2; // (signal)
  /* TOP.vhd:496:3  */
  register_file rf (
    .clk(clk),
    .we3(reg_write_real),
    .ra1(ra1_d),
    .ra2(ra2_d),
    .rd(rd_w),
    .wd3(result_w),
    .rd1(rf_rd1),
    .rd2(rf_rd2));
  /* TOP.vhd:511:24  */
  assign se_n82 = se_sign_imm; // (signal)
  /* TOP.vhd:507:3  */
  sign_extend se (
    .imm_src(imm_src),
    .instr(instr_d),
    .sign_imm(se_sign_imm));
  /* TOP.vhd:518:26  */
  assign alu_unit_n85 = alu_unit_zero; // (signal)
  /* TOP.vhd:519:26  */
  assign alu_unit_n86 = alu_unit_alu_res; // (signal)
  /* TOP.vhd:513:3  */
  alu alu_unit (
    .srca(srca_e),
    .srcb(srcb_e),
    .alu_cont(alu_cont_e),
    .zero(alu_unit_zero),
    .alu_res(alu_unit_alu_res));
  /* TOP.vhd:527:19  */
  assign dmem_n91 = dmem_rd; // (signal)
  /* TOP.vhd:521:3  */
  data_memory_64_6 dmem (
    .clk(clk),
    .we(dmem_we),
    .a(alu_res_m),
    .wd(write_data_m),
    .rd(dmem_rd));
  /* TOP.vhd:545:19  */
  assign mux_res_src_n94 = mux_res_src_y; // (signal)
  /* TOP.vhd:538:3  */
  mux3_32 mux_res_src (
    .d0(alu_res_w),
    .d1(read_data_w),
    .d2(pc_plus_4_w),
    .sel(res_src_w),
    .y(mux_res_src_y));
  /* TOP.vhd:554:19  */
  assign mux_fwd_a_n97 = mux_fwd_a_y; // (signal)
  /* TOP.vhd:548:3  */
  mux3_32 mux_fwd_a (
    .d0(rd1_e),
    .d1(result_w),
    .d2(alu_res_m),
    .sel(forward_ae),
    .y(mux_fwd_a_y));
  /* TOP.vhd:563:19  */
  assign mux_fwd_b_n100 = mux_fwd_b_y; // (signal)
  /* TOP.vhd:557:3  */
  mux3_32 mux_fwd_b (
    .d0(rd2_e),
    .d1(result_w),
    .d2(alu_res_m),
    .sel(forward_be),
    .y(mux_fwd_b_y));
  /* TOP.vhd:571:19  */
  assign mux_alusrc_n103 = mux_alusrc_y; // (signal)
  /* TOP.vhd:566:3  */
  mux_32 mux_alusrc (
    .d0(write_data_e),
    .d1(sign_imm_e),
    .sel(alu_src_e),
    .y(mux_alusrc_y));
  /* TOP.vhd:583:25  */
  assign ctrl_n106 = ctrl_res_src; // (signal)
  /* TOP.vhd:586:25  */
  assign ctrl_n107 = ctrl_mem_write; // (signal)
  /* TOP.vhd:587:25  */
  assign ctrl_n108 = ctrl_alu_cont; // (signal)
  /* TOP.vhd:584:25  */
  assign ctrl_n109 = ctrl_alu_src; // (signal)
  /* TOP.vhd:579:25  */
  assign ctrl_n110 = ctrl_imm_src; // (signal)
  /* TOP.vhd:582:25  */
  assign ctrl_n111 = ctrl_reg_write; // (signal)
  /* TOP.vhd:585:25  */
  assign ctrl_n112 = ctrl_branch; // (signal)
  /* TOP.vhd:580:25  */
  assign ctrl_n113 = ctrl_jump; // (signal)
  /* TOP.vhd:573:3  */
  control_unit ctrl (
    .op(op),
    .funct3(funct3),
    .funct7_5(funct7_5),
    .res_src(ctrl_res_src),
    .mem_write(ctrl_mem_write),
    .alu_cont(ctrl_alu_cont),
    .alu_src(ctrl_alu_src),
    .imm_src(ctrl_imm_src),
    .reg_write(ctrl_reg_write),
    .branch(ctrl_branch),
    .jump(ctrl_jump));
  /* TOP.vhd:602:26  */
  assign hz_n130 = hz_stall_f; // (signal)
  /* TOP.vhd:603:26  */
  assign hz_n131 = hz_stall_d; // (signal)
  /* TOP.vhd:604:26  */
  assign hz_n132 = hz_flush_d; // (signal)
  /* TOP.vhd:605:26  */
  assign hz_n133 = hz_flush_e; // (signal)
  /* TOP.vhd:606:26  */
  assign hz_n134 = hz_forward_ae; // (signal)
  /* TOP.vhd:607:26  */
  assign hz_n135 = hz_forward_be; // (signal)
  /* TOP.vhd:589:3  */
  hazard_unit hz (
    .ra1_d(ra1_d),
    .ra2_d(ra2_d),
    .ra1_e(ra1_e),
    .ra2_e(ra2_e),
    .rd_e(rd_e),
    .rd_m(rd_m),
    .rd_w(rd_w),
    .pc_src_e(pc_src_e),
    .res_src_e(res_src_e),
    .reg_write_m(reg_write_m),
    .reg_write_w(reg_write_w),
    .stall_f(hz_stall_f),
    .stall_d(hz_stall_d),
    .flush_d(hz_flush_d),
    .flush_e(hz_flush_e),
    .forward_ae(hz_forward_ae),
    .forward_be(hz_forward_be));
  /* TOP.vhd:618:27  */
  assign ifid_n148 = ifid_valid_d; // (signal)
  /* TOP.vhd:621:27  */
  assign ifid_n149 = ifid_instr_d; // (signal)
  /* TOP.vhd:622:27  */
  assign ifid_n150 = ifid_pc_d; // (signal)
  /* TOP.vhd:623:27  */
  assign ifid_n151 = ifid_pc_plus_4_d; // (signal)
  /* TOP.vhd:627:34  */
  assign ifid_n152 = ifid_predicted_taken_d; // (signal)
  /* TOP.vhd:628:34  */
  assign ifid_n153 = ifid_predicted_target_d; // (signal)
  /* TOP.vhd:610:3  */
  if_id ifid (
    .clk(clk),
    .rst(rst_local),
    .flush(flush_d),
    .stall(stall_d),
    .instr_f(instr),
    .pc_f(pc),
    .pc_plus_4_f(pc_plus_4),
    .valid_f(valid_f),
    .predicted_taken_f(predict_taken_f),
    .predicted_target_f(predicted_target_f),
    .predicted_taken_d(ifid_predicted_taken_d),
    .predicted_target_d(ifid_predicted_target_d),
    .valid_d(ifid_valid_d),
    .instr_d(ifid_instr_d),
    .pc_d(ifid_pc_d),
    .pc_plus_4_d(ifid_pc_plus_4_d));
  /* TOP.vhd:652:26  */
  assign idex_n166 = idex_valid_e; // (signal)
  /* TOP.vhd:645:26  */
  assign idex_n167 = idex_res_src_e; // (signal)
  /* TOP.vhd:646:26  */
  assign idex_n168 = idex_mem_write_e; // (signal)
  /* TOP.vhd:647:26  */
  assign idex_n169 = idex_alu_cont_e; // (signal)
  /* TOP.vhd:648:26  */
  assign idex_n170 = idex_alu_src_e; // (signal)
  /* TOP.vhd:649:26  */
  assign idex_n171 = idex_reg_write_e; // (signal)
  /* TOP.vhd:650:26  */
  assign idex_n172 = idex_branch_e; // (signal)
  /* TOP.vhd:651:26  */
  assign idex_n173 = idex_jump_e; // (signal)
  /* TOP.vhd:663:26  */
  assign idex_n174 = idex_rd1_e; // (signal)
  /* TOP.vhd:664:26  */
  assign idex_n175 = idex_rd2_e; // (signal)
  /* TOP.vhd:665:26  */
  assign idex_n176 = idex_ra1_e; // (signal)
  /* TOP.vhd:666:26  */
  assign idex_n177 = idex_ra2_e; // (signal)
  /* TOP.vhd:667:26  */
  assign idex_n178 = idex_rd_e; // (signal)
  /* TOP.vhd:668:26  */
  assign idex_n179 = idex_sign_imm_e; // (signal)
  /* TOP.vhd:669:26  */
  assign idex_n180 = idex_pc_plus_4_e; // (signal)
  /* TOP.vhd:670:26  */
  assign idex_n181 = idex_pc_e; // (signal)
  /* TOP.vhd:673:33  */
  assign idex_n182 = idex_predicted_taken_e; // (signal)
  /* TOP.vhd:674:33  */
  assign idex_n183 = idex_predicted_target_e; // (signal)
  /* TOP.vhd:630:3  */
  id_ex idex (
    .clk(clk),
    .rst(rst_local),
    .flush(flush_e),
    .res_src_d(res_src_d),
    .mem_write_d(mem_write_d),
    .alu_cont_d(alu_cont_d),
    .alu_src_d(alu_src_d),
    .reg_write_d(reg_write_d),
    .branch_d(branch_d),
    .jump_d(jump_d),
    .valid_d(valid_d),
    .predicted_taken_d(predicted_taken_d),
    .predicted_target_d(predicted_target_d),
    .rd1_d(rd1_d),
    .rd2_d(rd2_d),
    .ra1_d(ra1_d),
    .ra2_d(ra2_d),
    .rd_d(rd_d),
    .sign_imm_d(sign_imm_d),
    .pc_d(pc_d),
    .pc_plus_4_d(pc_plus_4_d),
    .valid_e(idex_valid_e),
    .res_src_e(idex_res_src_e),
    .mem_write_e(idex_mem_write_e),
    .alu_cont_e(idex_alu_cont_e),
    .alu_src_e(idex_alu_src_e),
    .reg_write_e(idex_reg_write_e),
    .branch_e(idex_branch_e),
    .jump_e(idex_jump_e),
    .predicted_taken_e(idex_predicted_taken_e),
    .predicted_target_e(idex_predicted_target_e),
    .rd1_e(idex_rd1_e),
    .rd2_e(idex_rd2_e),
    .ra1_e(idex_ra1_e),
    .ra2_e(idex_ra2_e),
    .rd_e(idex_rd_e),
    .sign_imm_e(idex_sign_imm_e),
    .pc_plus_4_e(idex_pc_plus_4_e),
    .pc_e(idex_pc_e));
  /* TOP.vhd:697:28  */
  assign exmem_n220 = exmem_valid_m; // (signal)
  /* TOP.vhd:690:28  */
  assign exmem_n221 = exmem_res_src_m; // (signal)
  /* TOP.vhd:691:28  */
  assign exmem_n222 = exmem_mem_write_m; // (signal)
  /* TOP.vhd:692:28  */
  assign exmem_n223 = exmem_reg_write_m; // (signal)
  /* TOP.vhd:693:28  */
  assign exmem_n224 = exmem_rd_m; // (signal)
  /* TOP.vhd:694:28  */
  assign exmem_n225 = exmem_pc_plus_4_m; // (signal)
  /* TOP.vhd:695:28  */
  assign exmem_n226 = exmem_alu_res_m; // (signal)
  /* TOP.vhd:696:28  */
  assign exmem_n227 = exmem_write_data_m; // (signal)
  /* TOP.vhd:676:3  */
  ex_mem exmem (
    .clk(clk),
    .rst(rst_local),
    .res_src_e(res_src_e),
    .mem_write_e(mem_write_e),
    .reg_write_e(reg_write_e),
    .valid_e(valid_e),
    .rd_e(rd_e),
    .pc_plus_4_e(pc_plus_4_e),
    .alu_res_e(alu_res_e),
    .write_data_e(write_data_e),
    .valid_m(exmem_valid_m),
    .res_src_m(exmem_res_src_m),
    .mem_write_m(exmem_mem_write_m),
    .reg_write_m(exmem_reg_write_m),
    .rd_m(exmem_rd_m),
    .pc_plus_4_m(exmem_pc_plus_4_m),
    .alu_res_m(exmem_alu_res_m),
    .write_data_m(exmem_write_data_m));
  /* TOP.vhd:716:27  */
  assign memwb_n244 = memwb_valid_w; // (signal)
  /* TOP.vhd:710:27  */
  assign memwb_n245 = memwb_res_src_w; // (signal)
  /* TOP.vhd:711:27  */
  assign memwb_n246 = memwb_reg_write_w; // (signal)
  /* TOP.vhd:715:27  */
  assign memwb_n247 = memwb_read_data_w; // (signal)
  /* TOP.vhd:712:27  */
  assign memwb_n248 = memwb_rd_w; // (signal)
  /* TOP.vhd:713:27  */
  assign memwb_n249 = memwb_pc_plus_4_w; // (signal)
  /* TOP.vhd:714:27  */
  assign memwb_n250 = memwb_alu_res_w; // (signal)
  /* TOP.vhd:699:3  */
  mem_wb memwb (
    .clk(clk),
    .rst(rst_local),
    .res_src_m(res_src_m),
    .reg_write_m(reg_write_m),
    .valid_m(valid_m),
    .rd_m(rd_m),
    .pc_plus_4_m(pc_plus_4_m),
    .alu_res_m(alu_res_m),
    .read_data_m(read_data_m),
    .valid_w(memwb_valid_w),
    .res_src_w(memwb_res_src_w),
    .reg_write_w(memwb_reg_write_w),
    .read_data_w(memwb_read_data_w),
    .rd_w(memwb_rd_w),
    .pc_plus_4_w(memwb_pc_plus_4_w),
    .alu_res_w(memwb_alu_res_w));
  /* TOP.vhd:726:34  */
  assign bp_n265 = bp_predict_taken_f; // (signal)
  /* TOP.vhd:727:34  */
  assign bp_n267 = bp_predicted_target_f; // (signal)
  /* TOP.vhd:718:3  */
  branch_pred bp (
    .clk(clk),
    .rst(rst_local),
    .pc_f(pc),
    .pc_e(pc_e),
    .actual_taken_e(actual_taken_e),
    .update_en_e(predictor_update_e),
    .actual_target_e(pc_target_e),
    .predict_taken_f(bp_predict_taken_f),
    .debug_counter_f(),
    .predicted_target_f(bp_predicted_target_f),
    .btb_valid_f());
  /* TOP.vhd:739:26  */
  assign bus_unit_n277 = bus_unit_dmem_we; // (signal)
  /* TOP.vhd:740:26  */
  assign bus_unit_n278 = bus_unit_gpio_out; // (signal)
  /* TOP.vhd:732:3  */
  bus_m bus_unit (
    .clk(clk),
    .rst(rst_local),
    .mem_we(mem_write_real),
    .addr(alu_res_m),
    .write_data(write_data_m),
    .dmem_we(bus_unit_dmem_we),
    .gpio_out(bus_unit_gpio_out));
  /* TOP.vhd:455:3  */
  always @(posedge clk or posedge rst)
    if (rst)
      n283_q <= 1'b1;
    else
      n283_q <= 1'b0;
  /* TOP.vhd:455:3  */
  always @(posedge clk or posedge rst)
    if (rst)
      n284_q <= 1'b1;
    else
      n284_q <= rst_sync1;
endmodule

