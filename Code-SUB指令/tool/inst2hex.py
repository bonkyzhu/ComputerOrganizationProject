bin2hex = {}
inst_list = ""

def toHeximal(bin_str):
  global bin2hex
  hex_str = ""
  for i in range(8):
    hex_str += bin2hex[bin_str[i*4:i*4+4]]
  return hex_str

def encode(s):
  tmp = str(bin(int(s)))[2:]
  return "0" * (5 - len(tmp)) + tmp
  
def subu_instruction(rs, rt, rd):
  opcode = "000000"
  sa = "00000"
  func = "100011"
  rs, rt, rd = (encode(arg) for arg in [rs,rt,rd])
  r_inst = opcode + rs + rt + rd + sa + func
  return toHeximal(r_inst)

def initiate():
  for i in range(16):
    heximal = hex(i)
    bin2hex[encode(str(i))[1:]] = str(heximal)[2]

def program():
  global inst_list
  s = input("输入两个源寄存器和目的寄存器（空格隔开）：")
  if s != 'end':
    rs, rt, rd = s.split(" ")
    inst = subu_instruction(rs, rt, rd)
    inst_list = inst_list + inst + "\n" 
  else:
    return "end"

if __name__ == "__main__":
  initiate()
  while True:
    if program() == 'end':
      print(inst_list)
      break