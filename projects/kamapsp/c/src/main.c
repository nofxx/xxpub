//  Kamapsp - the portable Kamasutra
/*

code by marcos augusto and rafael coutinho

v0.1 18/04/2007


 *********************************************************************
 * 
 * 
 *                                      			 START
 * 
 *********************************************************************
*/

#include <pspkernel.h>
#include <pspdebug.h>

#include <pspdisplay.h>
#include <pspgu.h>

#include <pspctrl.h>
#include <png.h>
#include <stdio.h>

#include "graphics.h"

PSP_MODULE_INFO("kamapsp", 0, 1, 1);

#define printf pspDebugScreenPrintf
#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))



/*********************************************************************
 * 
 * 
 *                                        ESPECIFIC PSP STUFF
 * 
 *********************************************************************
*//* Exit callback */
int exit_callback(int arg1, int arg2, void *common) {
          sceKernelExitGame();
          return 0;
}

/* Callback thread */
int CallbackThread(SceSize args, void *argp) {
          int cbid;

          cbid = sceKernelCreateCallback("Exit Callback", exit_callback, NULL);
          sceKernelRegisterExitCallback(cbid);

          sceKernelSleepThreadCB();

          return 0;
}

/* Sets up the callback thread and returns its thread id */
int SetupCallbacks(void) {
          int thid = 0;

          thid = sceKernelCreateThread("update_thread", CallbackThread, 0x11, 0xFA0, 0, 0);
          if(thid >= 0) {
                    sceKernelStartThread(thid, 0, 0);
          }

          return thid;
}

/*********************************************************************
 * 
 * 
 *                                      			 MAIN
 * 
 *********************************************************************
*/

int main() 
{
	//call psp stuff
	pspDebugScreenInit();
    SetupCallbacks();
    initGraphics();
    
	char bafer[200];
	
	//Image definido no graphics.h
    Image* nossaImage;
	
	//joga caminho no bafer
	sprintf(bafer, "media/prince_ascii.png");
	nossaImage = loadImage(bafer);
    
    	//checar se imagem existe!!
    	if (!nossaImage) 
    	{
        	//Image load failed
        	printf("Ta lah nao! \n");
        } 
        else 
        {
        	
        	int x = 0;
            int y = 0;
            
            sceDisplayWaitVblankStart();
                      
           	blitAlphaImageToScreen(0 ,0 , 480, 272, nossaImage, x, y);
            
            flipScreen();
            
         } 
	
	sceKernelSleepThread();
    return 0;
}
	
	
/*
 * 
 * ex - programa legal
 * 
 * 
 * 
	
	
	
	
		printf("Oi oi bem vindo ao programa legal");
		int contador = 0;
		int i = 0;
		
		SceCtrlData butao;
		
		printf("Pressione X para comecar a viagem psicodelica");
		
		while(1) 
		{
			sceCtrlReadBufferPositive(&butao, 1);
			
				if(butao.Buttons & PSP_CTRL_CROSS) 
				{
                    break;
          		}	
			
		}
		
		while(1) 
		{
         	sceCtrlReadBufferPositive(&butao, 1);
          	 	
          	 	if(butao.Buttons & PSP_CTRL_CIRCLE) 
          	 	{
                    break;
          		}
          		
          	pspDebugScreenClear();
          	
          	printf("Pressione O para parar a viagem psicodelica \n");
          	printf("Contage: %i veiz q pensei nisso!", contador);
          	
          	contador++;
          	
          	for(i=0; i<5; i++) {
                    sceDisplayWaitVblankStart();
          	}
          		
          		
          		
          		
		}
		
	pspDebugScreenClear();
	
	printf("Termino!");
	printf("Finarmente: %i", contador);
	
	
	
		
	sceKernelSleepThread();
	return 0;
	
	
	
	
	funcao lado a lado
	
	
	int x = 0;
            int y = 0;
            sceDisplayWaitVblankStart();
            
        		while (x < 480) 
        		{
                	while (y < 272) 
                	{
               			blitAlphaImageToScreen(0 ,0 ,32 , 32, nossaImage, x, y);
                        y += 32;
                    }
                       	x += 32;
                        y = 0;
                }

          	flipScreen();
	
	
	
	
	
}*/


