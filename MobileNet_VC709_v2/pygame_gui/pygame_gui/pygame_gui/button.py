import pygame.font


class Button0(): 
    def __init__(self, ai_settings, screen, msg): 
        """初始化按钮的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        
        # 设置按钮的尺寸和其他属性 
        self.width, self.height = 200, 50 
        self.button_color = (0, 255, 0) 
        self.text_color = (255, 255, 255)
        self.font = pygame.font.SysFont(None, 48) 
        
        # 创建按钮的rect对象，并使其居中 
        self.rect = pygame.Rect(0, 0, self.width, self.height) 
        self.rect.left = 50
        self.rect.bottom  = 448 + 100 + 70
        self.prep_msg(msg)
        
    def prep_msg(self, msg): 
        """将msg渲染为图像，并使其在按钮上居中""" 
        self.msg_image = self.font.render(msg, True, self.text_color, self.button_color) 
        self.msg_image_rect = self.msg_image.get_rect() 
        self.msg_image_rect.center = self.rect.center
        
    def draw_button(self): 
        # 绘制一个用颜色填充的按钮，再绘制文本 
        self.screen.fill(self.button_color, self.rect) 
        self.screen.blit(self.msg_image, self.msg_image_rect)

class Button1(): 
    def __init__(self, ai_settings, screen, msg = "Next"):   
        """初始化按钮的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        
        # 设置按钮的尺寸和其他属性 
        self.width, self.height = 200, 50 
        self.button_color = (0, 255, 0) 
        self.text_color = (255, 255, 255)
        self.font = pygame.font.SysFont(None, 48) 
        
        # 创建按钮的rect对象，并使其居中 
        self.rect = pygame.Rect(0, 0, self.width, self.height) 
        self.rect.left = 250 + 48
        self.rect.bottom  = 448 + 100 + 70
        self.prep_msg(msg)
        
    def prep_msg(self, msg): 
        """将msg渲染为图像，并使其在按钮上居中""" 
        self.msg_image = self.font.render(msg, True, self.text_color, self.button_color) 
        self.msg_image_rect = self.msg_image.get_rect() 
        self.msg_image_rect.center = self.rect.center
        
    def draw_button(self): 
        # 绘制一个用颜色填充的按钮，再绘制文本 
        self.screen.fill(self.button_color, self.rect) 
        self.screen.blit(self.msg_image, self.msg_image_rect)

class Button2(): 
    def __init__(self, ai_settings, screen, msg = "Make FPGA data"):   
        """初始化按钮的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        
        # 设置按钮的尺寸和其他属性 
        self.width, self.height = 300, 50 
        self.button_color = (0, 255, 0) 
        self.text_color = (255, 255, 255)
        self.font = pygame.font.SysFont(None, 48) 
        
        # 创建按钮的rect对象，并使其居中 
        self.rect = pygame.Rect(0, 0, self.width, self.height) 
        self.rect.left = 50 + 448 + 50 + 200
        self.rect.bottom  = 750
        self.prep_msg(msg)
        
    def prep_msg(self, msg): 
        """将msg渲染为图像，并使其在按钮上居中""" 
        self.msg_image = self.font.render(msg, True, self.text_color, self.button_color) 
        self.msg_image_rect = self.msg_image.get_rect() 
        self.msg_image_rect.center = self.rect.center
        
    def draw_button(self): 
        # 绘制一个用颜色填充的按钮，再绘制文本 
        self.screen.fill(self.button_color, self.rect) 
        self.screen.blit(self.msg_image, self.msg_image_rect)

class Button3(): 
    def __init__(self, ai_settings, screen, msg = "Read FPGA data"):   
        """初始化按钮的属性""" 
        self.screen = screen 
        self.screen_rect = screen.get_rect() 
        
        # 设置按钮的尺寸和其他属性 
        self.width, self.height = 300, 50 
        self.button_color = (0, 255, 0) 
        self.text_color = (255, 255, 255)
        self.font = pygame.font.SysFont(None, 48) 
        
        # 创建按钮的rect对象，并使其居中 
        self.rect = pygame.Rect(0, 0, self.width, self.height) 
        self.rect.left = 50 + 448 + 50 + 350 + 400
        self.rect.bottom  = 750
        self.prep_msg(msg)
        
    def prep_msg(self, msg): 
        """将msg渲染为图像，并使其在按钮上居中""" 
        self.msg_image = self.font.render(msg, True, self.text_color, self.button_color) 
        self.msg_image_rect = self.msg_image.get_rect() 
        self.msg_image_rect.center = self.rect.center
        
    def draw_button(self): 
        # 绘制一个用颜色填充的按钮，再绘制文本 
        self.screen.fill(self.button_color, self.rect) 
        self.screen.blit(self.msg_image, self.msg_image_rect)