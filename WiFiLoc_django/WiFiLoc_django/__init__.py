# 在与 settings.py 同级目录下的 __init__.py 中引入模块和进行配置
import pymysql

pymysql.install_as_MySQLdb()
