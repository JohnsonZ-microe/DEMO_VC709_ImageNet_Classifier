from make_input_file import make_uart_input



def check_buttons(ai_settings, states, button0, button1, button2, button3, mouse_x, mouse_y): 
    """check button click"""
    if button0.rect.collidepoint(mouse_x, mouse_y): 
        if(states.image_index == 0):
            states.image_index = ai_settings.image_num - 1
        else:
            states.image_index = states.image_index - 1
        states.show = 0
        states.finish = 0
    elif button1.rect.collidepoint(mouse_x, mouse_y): 
        if(states.image_index == ai_settings.image_num - 1):
            states.image_index = 0
        else:
            states.image_index = states.image_index + 1
        states.show   = 0
        states.finish = 0
        
    elif button2.rect.collidepoint(mouse_x, mouse_y): 
        make_uart_input(states.image_index)
        states.show   = 0
        states.finish = 0
    
    elif button3.rect.collidepoint(mouse_x, mouse_y): 
        states.finish = 0
        states.update()
        states.show   = 1
        
        
