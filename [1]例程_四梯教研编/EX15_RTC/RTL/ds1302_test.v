module ds1302_test
(
    input  wire                         ds1302_clk               ,
    input  wire                         ds1302_rst               ,

    output wire        [   7: 0]        read_second              ,
    output wire        [   7: 0]        read_minute              ,
    output wire        [   7: 0]        read_hour                ,
    output wire        [   7: 0]        read_date                ,
    output wire        [   7: 0]        read_month               ,
    output wire        [   7: 0]        read_week                ,
    output wire        [   7: 0]        read_year                ,

    output wire                         ds1302_ce                ,//DS1302 复位引脚
    output wire                         ds1302_sclk              ,//DS1302 时钟引脚
    inout  wire                         ds1302_io                 //DS1302 双向数据引脚  
);

    localparam                          IDLE                  = 0     ; //空闲
    localparam                          READ_CH               = 1     ; //CH = 1，时钟暂停
    localparam                          WRITE                 = 2     ;
    localparam                          READ                  = 4     ;
    localparam                          STOP                  = 5     ;


    reg                [   3: 0]        state                     ;

    reg                [   7: 0]        write_second              ;
    reg                [   7: 0]        write_minute              ;
    reg                [   7: 0]        write_hour                ;
    reg                [   7: 0]        write_date                ;
    reg                [   7: 0]        write_month               ;
    reg                [   7: 0]        write_week                ;
    reg                [   7: 0]        write_year                ;

    reg                                 write_time_req            ;
    reg                                 read_time_req             ;

    wire                                write_time_ack            ;
    wire                                read_time_ack             ;


always@(posedge ds1302_clk or posedge ds1302_rst)begin
    if(ds1302_rst)   
        state <=  IDLE;
    else begin
        case(state)   
            IDLE   :state <= READ_CH;
            READ_CH:
                if((read_time_ack) && (read_second[7] == 1'b1))
                    state <= WRITE;
                else if((read_time_ack) && (read_second[7] == 1'b0))
                    state <= READ;
                else 
                    state <= READ_CH;
            WRITE  :
                if(write_time_ack)
                    state <= READ;
                else 
                    state <= WRITE;
            READ   :
                if(read_time_ack)
                    state <= STOP;
                else 
                    state <= READ;
            STOP   :state <= IDLE;
        endcase
    end
end

//写数据请求
always@(posedge ds1302_clk or posedge ds1302_rst)begin
    if(ds1302_rst)   
        write_time_req <= 'd0;
    else if(write_time_ack)
        write_time_req <= 'd0;
    else if(state == WRITE)
        write_time_req <= 'd1;
    else 
        write_time_req <= write_time_req;
end

//读数据请求
always@(posedge ds1302_clk or posedge ds1302_rst)begin
    if(ds1302_rst)   
        read_time_req <= 'd0;
    else if(read_time_ack)
        read_time_req <= 'd0;
    else if(state == READ || state == READ_CH)
        read_time_req <= 'd1;
    else 
        read_time_req <= read_time_req;
end

//写数据赋值
always@(posedge ds1302_clk or posedge ds1302_rst)begin
    if(ds1302_rst)begin
        write_second  <= 8'h00;  
        write_minute  <= 8'h00; 
        write_hour    <= 8'h00; 
        write_date    <= 8'h00; 
        write_month   <= 8'h00; 
        write_week    <= 8'h00; 
        write_year    <= 8'h00; 
    end
    else if(state == WRITE)begin
        write_second  <= 8'h56;  
        write_minute  <= 8'h59; 
        write_hour    <= 8'h11; 
        write_date    <= 8'h09; 
        write_month   <= 8'h08; 
        write_week    <= 8'h00; 
        write_year    <= 8'h24; 
    end
end

ds1302_wr_ctrl ds1302_wr_ctrl_inst(
    .ds1302_clk                         (ds1302_clk              ),
    .ds1302_rst                         (ds1302_rst              ),
//用户写数据接口
    .write_second                       (write_second            ),
    .write_minute                       (write_minute            ),
    .write_hour                         (write_hour              ),
    .write_date                         (write_date              ),
    .write_month                        (write_month             ),
    .write_week                         (write_week              ),
    .write_year                         (write_year              ),
    .write_time_req                     (write_time_req          ),// 完整写操作的     写请求
    .write_time_ack                     (write_time_ack          ),// 完整读操作完成   应答信号
//用户读数据接口  
    .read_second                        (read_second             ),
    .read_minute                        (read_minute             ),
    .read_hour                          (read_hour               ),
    .read_date                          (read_date               ),
    .read_month                         (read_month              ),
    .read_week                          (read_week               ),
    .read_year                          (read_year               ),
    .read_time_req                      (read_time_req           ),// 完整读操作的 读请求
    .read_time_ack                      (read_time_ack           ),// 完整读操作完成 应答信号
//DS1302物理IO
    .ds1302_ce                          (ds1302_ce               ),// DS1302 复位引脚
    .ds1302_sclk                        (ds1302_sclk             ),// DS1302 时钟引脚
    .ds1302_io                          (ds1302_io               ) // DS1302 双向数据引脚
);

endmodule 