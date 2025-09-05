



class Settings(): 
    """存储《外星人入侵》的所有设置的类""" 
    def __init__(self): # """初始化游戏的设置"""
        # 屏幕设置 
        self.image_num = 20
        self.screen_width = 1700
        self.screen_height = 800
        self.bg_color = (230, 230, 230)
        dir_list = []
        folder_dir = "D:\\Project_UM\\pygame_gui\\pygame_gui\\pygame_gui\\images_to_be_tested\\image"
        for i in range(self.image_num):
            dir_list.append(folder_dir + str(i) + ".JPEG")
        self.dir_list = dir_list
        

