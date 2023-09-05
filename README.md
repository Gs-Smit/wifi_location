# wifi_location

## Introduction - 介绍

利用WiFi的CSI数据实现室内定位，包括后端AP监听WiFi采集CSI数据、定位算法以及前端平台展示。AP需要采用华硕RTX路由器，在路由器上安装nexmon工具；定位算法目前是对CSI数据采用SuperMusic算法估计AOA，而后使用三角定位计算位置；前端可以对定位环境、定位设备进行设置，并对定位结果进行展示

## Requirements - 必要条件
<p>1.AP需要采用华硕RTX路由器，在路由器上安装nexmon工具</p>
<p>2.采集程序，需要在Linux环境下运行脚本</p>
<p>3.前端程序需要安装mysql数据库，python安装django包</p>

## Configuration - 配置（配置信息。）
<p>
  根据AP1,AP2,AP3,AP4的顺序，IP分别为192.168.50.1; 192.168.50.2; 192.168.50.3; 192.168.50.4。
设置其ssh连接的端口为2001，2002，2003，2004 。
</p>

## Installation - 安装（如何安装。）
<p>
  目前的定位系统，需要在正方形区域的四个角落各部署一台AP，在房间的任意位置放置一台路由器X（你需要先连接管理，查看其WiFi信号的配置状态，这会用在之后的pcap文件解析和定位算法中）。被定位设备需要连接路由器X，并与其保持通信。
</p>

## Process - 流程

## Usage - 用法（用法。）
<p>
  在location_linux中
</p>


