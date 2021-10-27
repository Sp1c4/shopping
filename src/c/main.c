#include "code_def.h"
#include <stdint.h>
#include <string.h>

extern uint32_t key_flag;

int main()
{
	NVIC_CTRL_ADDR = 1;

	int money;
	int money_reg;
	int drink;
	int drink_reg;
	int choose;
  	int flag;
	int reg;
	while(1)
	{
		while (key_flag) 
		{
			uint32_t din;
			din = Keyboard_keydata_clear;
			choose = din;
			
			if(choose == 1)
			{
				drink = 0;
				drink_reg = 0;
				money = 0;
				money_reg = 0;
				flag = 0;
				reg = 0;
			}
			else if(choose == 2) 
			{
				money = money + 1;
				SEG = money + 256;
			}
			else if(choose == 3) 
			{
				money = money + 2;
				SEG = money + 256;
			}
			else if(choose == 4) 
			{
				money = money + 10;
				SEG = money + 256;
			}
			else if(choose == 5) 
			{
				money = money + 20;
				SEG = money + 256;
			}
			else if(choose == 6) 
			{
				drink = 2;
				SEG = 2 + 512;
			}
			else if(choose == 7) 
			{
				drink = 7;
				SEG = 7 + 512;
			}
			else if(choose == 8) 
			{
				drink = 10;
				SEG = 10 + 512;
			}
			
			
			if(drink > money) flag = 1;
			else if(drink < money) flag = 2;
			else if(drink == money) flag = 3;
			key_flag=0;
			Keyboard_keydata_clear=1;
		}
		if(reg != flag)
		{
			reg = flag;
			LED = flag;
		}
		
		
	}
}