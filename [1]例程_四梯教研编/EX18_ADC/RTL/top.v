module top(
    input  wire                         sys_clk               ,
    input  wire                         sys_rst               ,

    output wire        [   7: 0]        seg                   ,
    output wire        [   7: 0]        sel                   ,

    output wire                         iic_scl               ,
    inout  wire                         iic_sda                         
);

wire               [  31: 0]            dsp_data              ;

//ADC驱动模块
adc#(
    .SYS_CLK                          (28'd50_000_000         ),
    .ADC_SCL                          (28'd100_000            ),
    .DEVICE_ADDR                      (7'b1010_100            ) 
)
adc_inst(
    .adc_clk                          (sys_clk                ),
    .adc_rst                          (sys_rst                ),
    .adc_start                        ('d1                    ),// 开启读取ADC操作 强制置1就一直读
    .dsp_data                         (dsp_data               ),// 从ADC读出的数据转换给 数码显示用的数据
    .iic_scl                          (iic_scl                ),
    .iic_sda                          (iic_sda                ) 
);

//数码管显示模块
seg seg_inst(
    .seg_clk                          (sys_clk               ),
    .seg_rst                          (sys_rst               ),
    .dsp_data                         (dsp_data              ),
    .seg                              (seg                   ),
    .sel                              (sel                   ) 
);

endmodule
