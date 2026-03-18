`timescale 1ns/1ps

module dip_debounce #
(
    parameter integer WIDTH = 1,
    parameter integer DEBOUNCE_CNT = 1500000   // 需要稳定的时钟周期数（例如100MHz下10ms≈1,000,000）
)
(
    input                  clk,
    input                  rst_n,       // 低有效复位
    input  [WIDTH-1:0]     dip_raw,     // 异步拨码输入
    output reg [WIDTH-1:0] dip_stable,  // 消抖后稳定输出
    output reg             dip_change   // dip_stable 变化时输出1个clk脉冲
);

    // ---------------- 2FF 同步 ----------------
    reg [WIDTH-1:0] dip_sync1;
    reg [WIDTH-1:0] dip_sync2;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            dip_sync1 <= {WIDTH{1'b0}};
            dip_sync2 <= {WIDTH{1'b0}};
        end else begin
            dip_sync1 <= dip_raw;
            dip_sync2 <= dip_sync1;
        end
    end

    // ---------------- 消抖计数 ----------------
    reg [WIDTH-1:0] sample;
    reg [31:0]      cnt;     // 32位一般够用；若DEBOUNCE_CNT很大可自行加宽

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sample     <= {WIDTH{1'b0}};
            dip_stable <= {WIDTH{1'b0}};
            cnt        <= 32'd0;
            dip_change <= 1'b0;
        end else begin
            dip_change <= 1'b0;

            // 输入与当前采样不同：发生跳变，重置计数并更新sample
            if(dip_sync2 != sample) begin
                sample <= dip_sync2;
                cnt    <= 32'd0;
            end else begin
                // 输入持续稳定：计数累加，达到阈值后更新输出
                if(cnt < DEBOUNCE_CNT)
                    cnt <= cnt + 1'b1;

                if(cnt == DEBOUNCE_CNT) begin
                    if(dip_stable != sample) begin
                        dip_stable <= sample;
                        dip_change <= 1'b1;  // 输出变化脉冲
                    end
                end
            end
        end
    end

endmodule