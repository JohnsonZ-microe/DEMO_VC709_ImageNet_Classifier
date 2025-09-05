import pygame 
from PIL import Image

def ResizeImage(filein, fileout, width, height, type):
  img = Image.open(filein)
  out = img.resize((width, height),Image.ANTIALIAS) #resize image with high-quality
  out.save(fileout, type)

class Test_image(): 
    def __init__(self, screen, states): 
        """初始化飞船并设置其初始位置""" 
        self.screen = screen # 加载飞船图像并获取其外接矩形 
        self.states = states
        self.update_dir()
        
        
    
    def update_dir(self):
        if(self.states.show == 0):
            self.image_dir = self.states.image_dir
            self.file_in  = self.image_dir
            self.file_out = self.image_dir[:-4] + "png"
            ResizeImage(self.file_in, self.file_out, 448, 448, "PNG")
            self.image = pygame.image.load(self.file_out) 
            self.rect = self.image.get_rect() 
            self.rect.centerx = 50 + 224
            self.rect.centery = 100 + 224
        
    
    def blitme(self): 
        """在指定位置绘制飞船""" 
        self.update_dir()
        self.screen.blit(self.image, self.rect)