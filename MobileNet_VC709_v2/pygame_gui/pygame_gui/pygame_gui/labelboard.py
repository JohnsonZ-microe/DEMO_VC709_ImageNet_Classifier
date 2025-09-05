import pygame.font 


class Labelboard(): 
    """显示得分信息的类""" 
    def __init__(self, ai_settings, screen): 
        """初始化显示得分涉及的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        self.ai_settings = ai_settings 
        self.text_color = (30, 30, 30)
        self.font = pygame.font.SysFont(None, 72) # 准备初始得分图像 
        # self.font_small = pygame.font.SysFont(None, 48)
        self.prep_score()
        
    def prep_score(self): 
        """将得分转换为一幅渲染的图像""" 
        score_str0 = str("Test image:") 
        self.score_image0 = self.font.render(score_str0, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect0 = self.score_image0.get_rect()
        self.score_rect0.left = 20
        self.score_rect0.top  = 30
        
        score_str1 = str("True label:") 
        self.score_image1 = self.font.render(score_str1, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect1 = self.score_image1.get_rect()
        self.score_rect1.left = 50
        self.score_rect1.top  = 448 + 100 + 100
        
        score_str2 = str("Predicted label:") 
        self.score_image2 = self.font.render(score_str2, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect2 = self.score_image2.get_rect()
        self.score_rect2.left = 50 + 448 + 50
        self.score_rect2.top  = 30
        
        score_str3 = str("Score:") 
        self.score_image3 = self.font.render(score_str3, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect3 = self.score_image3.get_rect()
        self.score_rect3.left = 50 + 448 + 50 + 500 + 50
        self.score_rect3.top  = 30
        
        score_str4 = str("Top-5 accuracy:") 
        self.score_image4 = self.font.render(score_str4, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect4 = self.score_image3.get_rect()
        self.score_rect4.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect4.top  = 30
        
    
        
    def show_score(self): 
        """在屏幕上显示得分""" 
        self.screen.blit(self.score_image0, self.score_rect0)
        self.screen.blit(self.score_image1, self.score_rect1)
        self.screen.blit(self.score_image2, self.score_rect2)
        self.screen.blit(self.score_image3, self.score_rect3)
        self.screen.blit(self.score_image4, self.score_rect4)

class DynamicLabelboard(): 
    """显示得分信息的类""" 
    def __init__(self, ai_settings, screen, states): 
        """初始化显示得分涉及的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        self.ai_settings = ai_settings 
        self.states = states # 显示得分信息时使用的字体设置
        self.text_color = (30, 30, 30)
        self.font = pygame.font.SysFont(None, 72) # 准备初始得分图像 
        self.prep_score()
        
    def prep_score(self): 
        """True label""" 
        self.text_color = (30, 30, 30)
        true_label_str0 = self.states.true_label
        self.score_image15 = self.font.render(true_label_str0, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect15 = self.score_image15.get_rect()
        self.score_rect15.left = 50
        self.score_rect15.top  = 720
        
        
        

        """top-5 scores""" 
        if(self.states.true_label == self.states.label_list[0]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        score_str0 = self.states.score_list[0]
        self.score_image0 = self.font.render(score_str0, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect0 = self.score_image0.get_rect()
        self.score_rect0.left = 50 + 448 + 50 + 500 + 50
        self.score_rect0.top  = 30 + 100
        
        if(self.states.true_label == self.states.label_list[1]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        score_str1 = self.states.score_list[1]
        self.score_image1 = self.font.render(score_str1, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect1 = self.score_image1.get_rect()
        self.score_rect1.left = 50 + 448 + 50 + 500 + 50
        self.score_rect1.top  = 30 + 200
        
        if(self.states.true_label == self.states.label_list[2]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        score_str2 = self.states.score_list[2]
        self.score_image2 = self.font.render(score_str2, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect2 = self.score_image2.get_rect()
        self.score_rect2.left = 50 + 448 + 50 + 500 + 50
        self.score_rect2.top  = 30 + 300
        
        if(self.states.true_label == self.states.label_list[3]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        score_str3 = self.states.score_list[3] 
        self.score_image3 = self.font.render(score_str3, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect3 = self.score_image3.get_rect()
        self.score_rect3.left = 50 + 448 + 50 + 500 + 50
        self.score_rect3.top  = 30 + 400
        
        if(self.states.true_label == self.states.label_list[4]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        score_str4 = self.states.score_list[4]
        self.score_image4 = self.font.render(score_str4, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect4 = self.score_image3.get_rect()
        self.score_rect4.left = 50 + 448 + 50 + 500 + 50
        self.score_rect4.top  = 30 + 500
        
        """top-5 labels""" 
        if(self.states.true_label == self.states.label_list[0]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        label_str0 = self.states.label_list[0]
        self.score_image5 = self.font.render(label_str0, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect5 = self.score_image5.get_rect()
        self.score_rect5.left = 50 + 448 + 50
        self.score_rect5.top  = 30 + 100
        
        if(self.states.true_label == self.states.label_list[1]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        label_str1 = self.states.label_list[1]
        self.score_image6 = self.font.render(label_str1, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect6 = self.score_image6.get_rect()
        self.score_rect6.left = 50 + 448 + 50
        self.score_rect6.top  = 30 + 200
        
        if(self.states.true_label == self.states.label_list[2]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        label_str2 = self.states.label_list[2]
        self.score_image7 = self.font.render(label_str2, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect7 = self.score_image7.get_rect()
        self.score_rect7.left = 50 + 448 + 50
        self.score_rect7.top  = 30 + 300
        
        if(self.states.true_label == self.states.label_list[3]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        label_str3 = self.states.label_list[3] 
        self.score_image8 = self.font.render(label_str3, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect8 = self.score_image8.get_rect()
        self.score_rect8.left = 50 + 448 + 50
        self.score_rect8.top  = 30 + 400
        
        if(self.states.true_label == self.states.label_list[4]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        label_str4 = self.states.label_list[4]
        self.score_image9 = self.font.render(label_str4, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect9 = self.score_image9.get_rect()
        self.score_rect9.left = 50 + 448 + 50
        self.score_rect9.top  = 30 + 500
    
        """top-5 accuracy""" 
        if(self.states.true_label == self.states.label_list[0]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        acc_str0 = self.states.acc_list[0]
        self.score_image10 = self.font.render(acc_str0, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect10 = self.score_image10.get_rect()
        self.score_rect10.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect10.top  = 30 + 100
        
        if(self.states.true_label == self.states.label_list[1]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        acc_str1 = self.states.acc_list[1]
        self.score_image11 = self.font.render(acc_str1, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect11 = self.score_image11.get_rect()
        self.score_rect11.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect11.top  = 30 + 200
        
        if(self.states.true_label == self.states.label_list[2]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        acc_str2 = self.states.acc_list[2]
        self.score_image12 = self.font.render(acc_str2, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect12 = self.score_image12.get_rect()
        self.score_rect12.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect12.top  = 30 + 300
        
        if(self.states.true_label == self.states.label_list[3]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        acc_str3 = self.states.acc_list[3] 
        self.score_image13 = self.font.render(acc_str3, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect13 = self.score_image13.get_rect()
        self.score_rect13.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect13.top  = 30 + 400
        
        if(self.states.true_label == self.states.label_list[4]):
            self.text_color = (220, 20, 60)
        else:
            self.text_color = (30, 30, 30)
        acc_str4 = self.states.acc_list[4]
        self.score_image14 = self.font.render(acc_str4, True, self.text_color, self.ai_settings.bg_color) # 将得分放在屏幕右上角
        self.score_rect14 = self.score_image14.get_rect()
        self.score_rect14.left = 50 + 448 + 50 + 500 + 50 + 225
        self.score_rect14.top  = 30 + 500
        
        
        
    
        
      
        
        
    def show_score(self): 
        """在屏幕上显示得分""" 
        self.screen.blit(self.score_image15, self.score_rect15)
        if(self.states.show == 1):
            self.screen.blit(self.score_image0, self.score_rect0)
            self.screen.blit(self.score_image1, self.score_rect1)
            self.screen.blit(self.score_image2, self.score_rect2)
            self.screen.blit(self.score_image3, self.score_rect3)
            self.screen.blit(self.score_image4, self.score_rect4)
            
            self.screen.blit(self.score_image5, self.score_rect5)
            self.screen.blit(self.score_image6, self.score_rect6)
            self.screen.blit(self.score_image7, self.score_rect7)
            self.screen.blit(self.score_image8, self.score_rect8)
            self.screen.blit(self.score_image9, self.score_rect9)
            
            self.screen.blit(self.score_image11, self.score_rect11)
            self.screen.blit(self.score_image12, self.score_rect12)
            self.screen.blit(self.score_image13, self.score_rect13)
            self.screen.blit(self.score_image14, self.score_rect14)
            self.screen.blit(self.score_image10, self.score_rect10)
            
            
            
