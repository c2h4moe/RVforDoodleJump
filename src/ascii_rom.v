module ascii_rom (
    input [7:0] code,
    output [127:0] shape
);
initial begin
    rom[0] = 128'h00000000000000000000000000000000;       //0x00
    rom[1] = 128'h00007E81A58181BD9981817E00000000;       //0x01
    rom[2] = 128'h00007EFFDBFFFFC3E7FFFF7E00000000;       //0x02
    rom[3] = 128'h000000006CFEFEFEFE7C381000000000;       //0x03
    rom[4] = 128'h0000000010387CFE7C38100000000000;       //0x04
    rom[5] = 128'h000000183C3CE7E7E718183C00000000;       //0x05
    rom[6] = 128'h000000183C7EFFFF7E18183C00000000;       //0x06
    rom[7] = 128'h000000000000183C3C18000000000000;       //0x07
    rom[8] = 128'hFFFFFFFFFFFFE7C3C3E7FFFFFFFFFFFF;       //0x08
    rom[9] = 128'h00000000003C664242663C0000000000;       //0x09
    rom[10] = 128'hFFFFFFFFFFC399BDBD99C3FFFFFFFFFF;       //0x0A
    rom[11] = 128'h00001E0E1A3278CCCCCCCC7800000000;       //0x0B
    rom[12] = 128'h00003C666666663C187E181800000000;       //0x0C
    rom[13] = 128'h00003F333F3030303070F0E000000000;       //0x0D
    rom[14] = 128'h00007F637F6363636367E7E6C0000000;       //0x0E
    rom[15] = 128'h0000001818DB3CE73CDB181800000000;       //0x0F
    rom[16] = 128'h0080C0E0F0F8FEF8F0E0C08000000000;       //0x10
    rom[17] = 128'h0002060E1E3EFE3E1E0E060200000000;       //0x11
    rom[18] = 128'h0000183C7E1818187E3C180000000000;       //0x12
    rom[19] = 128'h00006666666666666600666600000000;       //0x13
    rom[20] = 128'h00007FDBDBDB7B1B1B1B1B1B00000000;       //0x14
    rom[21] = 128'h007CC660386CC6C66C380CC67C000000;       //0x15
    rom[22] = 128'h0000000000000000FEFEFEFE00000000;       //0x16
    rom[23] = 128'h0000183C7E1818187E3C187E00000000;       //0x17
    rom[24] = 128'h0000183C7E1818181818181800000000;       //0x18
    rom[25] = 128'h0000181818181818187E3C1800000000;       //0x19
    rom[26] = 128'h0000000000180CFE0C18000000000000;       //0x1A
    rom[27] = 128'h00000000003060FE6030000000000000;       //0x1B
    rom[28] = 128'h000000000000C0C0C0FE000000000000;       //0x1C
    rom[29] = 128'h0000000000286CFE6C28000000000000;       //0x1D
    rom[30] = 128'h000000001038387C7CFEFE0000000000;       //0x1E
    rom[31] = 128'h00000000FEFE7C7C3838100000000000;       //0x1F
    rom[32] = 128'h00000000000000000000000000000000;       //0x20' '
    rom[33] = 128'h0000183C3C3C18181800181800000000;       //0x21'!'
    rom[34] = 128'h00666666240000000000000000000000;       //0x22'"'
    rom[35] = 128'h0000006C6CFE6C6C6CFE6C6C00000000;       //0x23'#'
    rom[36] = 128'h18187CC6C2C07C060686C67C18180000;       //0x24'$'
    rom[37] = 128'h00000000C2C60C183060C68600000000;       //0x25'%'
    rom[38] = 128'h0000386C6C3876DCCCCCCC7600000000;       //0x26'&'
    rom[39] = 128'h00303030600000000000000000000000;       //0x27'''
    rom[40] = 128'h00000C18303030303030180C00000000;       //0x28'('
    rom[41] = 128'h000030180C0C0C0C0C0C183000000000;       //0x29')'
    rom[42] = 128'h0000000000663CFF3C66000000000000;       //0x2A'*'
    rom[43] = 128'h000000000018187E1818000000000000;       //0x2B'+'
    rom[44] = 128'h00000000000000000018181830000000;       //0x2C'
    rom[45] = 128'h00000000000000FE0000000000000000;       //0x2D'-'
    rom[46] = 128'h00000000000000000000181800000000;       //0x2E'.'
    rom[47] = 128'h0000000002060C183060C08000000000;       //0x2F'/'
    rom[48] = 128'h0000386CC6C6D6D6C6C66C3800000000;       //0x30'0'
    rom[49] = 128'h00001838781818181818187E00000000;       //0x31'1'
    rom[50] = 128'h00007CC6060C183060C0C6FE00000000;       //0x32'2'
    rom[51] = 128'h00007CC606063C060606C67C00000000;       //0x33'3'
    rom[52] = 128'h00000C1C3C6CCCFE0C0C0C1E00000000;       //0x34'4'
    rom[53] = 128'h0000FEC0C0C0FC060606C67C00000000;       //0x35'5'
    rom[54] = 128'h00003860C0C0FCC6C6C6C67C00000000;       //0x36'6'
    rom[55] = 128'h0000FEC606060C183030303000000000;       //0x37'7'
    rom[56] = 128'h00007CC6C6C67CC6C6C6C67C00000000;       //0x38'8'
    rom[57] = 128'h00007CC6C6C67E0606060C7800000000;       //0x39'9'
    rom[58] = 128'h00000000181800000018180000000000;       //0x3A':'
    rom[59] = 128'h00000000181800000018183000000000;       //0x3B';'
    rom[60] = 128'h000000060C18306030180C0600000000;       //0x3C'<'
    rom[61] = 128'h00000000007E00007E00000000000000;       //0x3D'='
    rom[62] = 128'h0000006030180C060C18306000000000;       //0x3E'>'
    rom[63] = 128'h00007CC6C60C18181800181800000000;       //0x3F'?'
    rom[64] = 128'h0000007CC6C6DEDEDEDCC07C00000000;       //0x40'@'
    rom[65] = 128'h000010386CC6C6FEC6C6C6C600000000;       //0x41'A'
    rom[66] = 128'h0000FC6666667C66666666FC00000000;       //0x42'B'
    rom[67] = 128'h00003C66C2C0C0C0C0C2663C00000000;       //0x43'C'
    rom[68] = 128'h0000F86C6666666666666CF800000000;       //0x44'D'
    rom[69] = 128'h0000FE6662687868606266FE00000000;       //0x45'E'
    rom[70] = 128'h0000FE6662687868606060F000000000;       //0x46'F'
    rom[71] = 128'h00003C66C2C0C0DEC6C6663A00000000;       //0x47'G'
    rom[72] = 128'h0000C6C6C6C6FEC6C6C6C6C600000000;       //0x48'H'
    rom[73] = 128'h00003C18181818181818183C00000000;       //0x49'I'
    rom[74] = 128'h00001E0C0C0C0C0CCCCCCC7800000000;       //0x4A'J'
    rom[75] = 128'h0000E666666C78786C6666E600000000;       //0x4B'K'
    rom[76] = 128'h0000F06060606060606266FE00000000;       //0x4C'L'
    rom[77] = 128'h0000C6EEFEFED6C6C6C6C6C600000000;       //0x4D'M'
    rom[78] = 128'h0000C6E6F6FEDECEC6C6C6C600000000;       //0x4E'N'
    rom[79] = 128'h00007CC6C6C6C6C6C6C6C67C00000000;       //0x4F'O'
    rom[80] = 128'h0000FC6666667C60606060F000000000;       //0x50'P'
    rom[81] = 128'h00007CC6C6C6C6C6C6D6DE7C0C0E0000;       //0x51'Q'
    rom[82] = 128'h0000FC6666667C6C666666E600000000;       //0x52'R'
    rom[83] = 128'h00007CC6C660380C06C6C67C00000000;       //0x53'S'
    rom[84] = 128'h00007E7E5A1818181818183C00000000;       //0x54'T'
    rom[85] = 128'h0000C6C6C6C6C6C6C6C6C67C00000000;       //0x55'U'
    rom[86] = 128'h0000C6C6C6C6C6C6C66C381000000000;       //0x56'V'
    rom[87] = 128'h0000C6C6C6C6D6D6D6FEEE6C00000000;       //0x57'W'
    rom[88] = 128'h0000C6C66C7C38387C6CC6C600000000;       //0x58'X'
    rom[89] = 128'h0000666666663C181818183C00000000;       //0x59'Y'
    rom[90] = 128'h0000FEC6860C183060C2C6FE00000000;       //0x5A'Z'
    rom[91] = 128'h00003C30303030303030303C00000000;       //0x5B'['
    rom[92] = 128'h00000080C0E070381C0E060200000000;       //0x5C'\'
    rom[93] = 128'h00003C0C0C0C0C0C0C0C0C3C00000000;       //0x5D']'
    rom[94] = 128'h10386CC6000000000000000000000000;       //0x5E'^'
    rom[95] = 128'h00000000000000000000000000FF0000;       //0x5F'_'
    rom[96] = 128'h30301800000000000000000000000000;       //0x60'`'
    rom[97] = 128'h0000000000780C7CCCCCCC7600000000;       //0x61'a'
    rom[98] = 128'h0000E06060786C666666667C00000000;       //0x62'b'
    rom[99] = 128'h00000000007CC6C0C0C0C67C00000000;       //0x63'c'
    rom[100] = 128'h00001C0C0C3C6CCCCCCCCC7600000000;       //0x64'd'
    rom[101] = 128'h00000000007CC6FEC0C0C67C00000000;       //0x65'e'
    rom[102] = 128'h0000386C6460F060606060F000000000;       //0x66'f'
    rom[103] = 128'h000000000076CCCCCCCCCC7C0CCC7800;       //0x67'g'
    rom[104] = 128'h0000E060606C7666666666E600000000;       //0x68'h'
    rom[105] = 128'h00001818003818181818183C00000000;       //0x69'i'
    rom[106] = 128'h00000606000E06060606060666663C00;       //0x6A'j'
    rom[107] = 128'h0000E06060666C78786C66E600000000;       //0x6B'k'
    rom[108] = 128'h00003818181818181818183C00000000;       //0x6C'l'
    rom[109] = 128'h0000000000ECFED6D6D6D6C600000000;       //0x6D'm'
    rom[110] = 128'h0000000000DC66666666666600000000;       //0x6E'n'
    rom[111] = 128'h00000000007CC6C6C6C6C67C00000000;       //0x6F'o'
    rom[112] = 128'h0000000000DC66666666667C6060F000;       //0x70'p'
    rom[113] = 128'h000000000076CCCCCCCCCC7C0C0C1E00;       //0x71'q'
    rom[114] = 128'h0000000000DC7666606060F000000000;       //0x72'r'
    rom[115] = 128'h00000000007CC660380CC67C00000000;       //0x73's'
    rom[116] = 128'h0000103030FC30303030361C00000000;       //0x74't'
    rom[117] = 128'h0000000000CCCCCCCCCCCC7600000000;       //0x75'u'
    rom[118] = 128'h000000000066666666663C1800000000;       //0x76'v'
    rom[119] = 128'h0000000000C6C6D6D6D6FE6C00000000;       //0x77'w'
    rom[120] = 128'h0000000000C66C3838386CC600000000;       //0x78'x'
    rom[121] = 128'h0000000000C6C6C6C6C6C67E060CF800;       //0x79'y'
    rom[122] = 128'h0000000000FECC183060C6FE00000000;       //0x7A'z'
    rom[123] = 128'h00000E18181870181818180E00000000;       //0x7B'{'
    rom[124] = 128'h00001818181800181818181800000000;       //0x7C'|'
    rom[125] = 128'h0000701818180E181818187000000000;       //0x7D'}'
    rom[126] = 128'h000076DC000000000000000000000000;       //0x7E'~'
    rom[127] = 128'h0000000010386CC6C6C6FE0000000000;       //0x7F''
    rom[128] = 128'h00003C66C2C0C0C0C2663C0C067C0000;       //0x80
    rom[129] = 128'h0000CC0000CCCCCCCCCCCC7600000000;       //0x81
    rom[130] = 128'h000C1830007CC6FEC0C0C67C00000000;       //0x82
    rom[131] = 128'h0010386C00780C7CCCCCCC7600000000;       //0x83
    rom[132] = 128'h0000CC0000780C7CCCCCCC7600000000;
end
reg [127:0] rom [255:0];
assign shape = rom[code];
endmodule