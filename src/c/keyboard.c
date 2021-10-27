#include <stdint.h>
#include "code_def.h"

uint32_t key_flag;

void KEY_ISR(void)
{
	key_flag = 1;

}
