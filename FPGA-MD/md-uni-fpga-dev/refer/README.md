# 参考资料说明

- [ ] verilog-pcie的[git库](https://github.com/alexforencich/verilog-pcie.git)中，有axi和axil的master设备侧的参考设计代码，verilog-pcie-master.zip文件为git库master分支代码压缩包
- [ ] Xilinx的[Examples库](https://github.com/Xilinx/Vitis_Accel_Examples.git)中有rtl_vadd的示例工程，可以作为axi的master设备侧和axil的slave设备侧的参考设计代码，rtl_vadd.zip文件中为该示例的压缩包
- [ ] axi和axil的slave设备侧的设计模块，可以采用Xilinx的AXI BRAM Controller IP的作为替代，并转化为常见的BRAM读写接口自用
- [ ] Xilinx的AXI Protocol Converter IP可以提供AXI接口协议的转换，如果直接实现AXI3接口，也无需AXI3和AXI4的协议转换模块
- [ ] XDMA是512位宽@250MHz，HBM是256位宽，时钟频率待定，我们定的数据结构的位宽是512位，可以考虑在接口处增加位宽转换模块（AXI Data Width Converter）
- [ ] 至于是否使用时钟转换模块（AXI Clock Converter），在xdma.bd中已做考虑，在kernel设计中如果只用单一时钟，则无需时钟转换模块
