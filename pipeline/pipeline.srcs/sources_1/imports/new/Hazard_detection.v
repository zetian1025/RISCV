module Hazard_detection (
    input   [4:0]   ID_rs1,
    input   [4:0]   ID_rs2,
    input   [4:0]   EX_rd,
    input   [4:0]   MEM_rd,
    input   [4:0]   WB_rd,
    output          pipeline_stop
);

reg pipeline1_stop, pipeline2_stop;

always @(*) begin
    case (ID_rs1)
        EX_rd:      pipeline1_stop = 1;
        MEM_rd:     pipeline1_stop = 1;
        WB_rd:      pipeline1_stop = 1;
        default:    pipeline1_stop = 0;
    endcase

    case (ID_rs2) begin
        EX_rd:      pipeline2_stop = 1;
        MEM_rd:     pipeline2_stop = 1;
        WB_rd:      pipeline2_stop = 1;
        default:    pipeline2_stop = 0;
    endcase
end

assign pipeline_stop = pipeline1_stop||pipeline2_stop;

endmodule