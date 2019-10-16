# vim-streamline
#### A simple, and light as heck statusline that shows you all the information you need.



Your statusline should look something this:
![screenshot](https://user-images.githubusercontent.com/56435971/66916260-64068980-f00a-11e9-8608-a5ef1812cff0.png)
... or this:
![screenshot2](https://user-images.githubusercontent.com/56435971/66916265-65d04d00-f00a-11e9-8f24-2a042813b174.png)

Your statusline will change to adapt to your theme.

## Installation    
With pathogen:    
```vim    
cd ~/.vim/bundle && \    
git clone https://github.com/KaraMCC/vim-streamline.git    
```    
    
With vim-plug:    
```vim    
Plug 'KaraMCC/vim-streamline'    
```    
    
Vundle example:    
```vim                                                                                
Plugin 'KaraMCC/vim-streamline'                                                  
```                                                                                   
                                                                                      
## Settings                                                                            
Want to show ALE errors and warnings in your statusline? Put this in your .vimrc:     
```vim                                                                                
let g:streamline_show_ale_status = 1                                                  
```                      
