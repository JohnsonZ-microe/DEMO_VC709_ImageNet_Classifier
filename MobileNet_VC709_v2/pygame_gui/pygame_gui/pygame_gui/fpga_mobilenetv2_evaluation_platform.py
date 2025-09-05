import sys
import pygame
from settings import Settings
from test_image import Test_image
from labelboard import Labelboard,DynamicLabelboard
from states     import States
from button     import Button0,Button1,Button2,Button3
from gui_functions import check_buttons

def run_game():
    pygame.init() 
    pygame.display.set_caption("FPGA MobilenetV2 Evaluation Platform")
    
    
    ai_settings = Settings()
    screen      = pygame.display.set_mode( (ai_settings.screen_width, ai_settings.screen_height))
    states      = States(ai_settings)

    button0 = Button0(ai_settings, screen, "Previous")
    button1 = Button1(ai_settings, screen)
    button2 = Button2(ai_settings, screen)
    button3 = Button3(ai_settings, screen)
    
    lb0         = Labelboard(ai_settings, screen)# "Test image"
    dlb0        = DynamicLabelboard(ai_settings, screen, states)
    test_image  = Test_image(screen,states)# class of image to be shown
    
    while True:
        screen.fill(ai_settings.bg_color)
        for event in pygame.event.get(): 
            if event.type == pygame.QUIT: 
                pygame.quit()
                sys.exit()
            elif event.type == pygame.MOUSEBUTTONDOWN: 
                mouse_x, mouse_y = pygame.mouse.get_pos() 
                check_buttons(ai_settings,states, button0, button1, button2, button3, mouse_x, mouse_y)
        
        button0.draw_button()
        button1.draw_button()
        button2.draw_button()
        button3.draw_button()
        states.update()
        
        test_image.blitme()
        lb0.show_score()
        dlb0.prep_score()
        dlb0.show_score()
        
        pygame.display.flip()
        
run_game()
                