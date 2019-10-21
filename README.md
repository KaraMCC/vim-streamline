# vim-streamline
A simple, and light as heck statusline that shows you all the information you need.

Your statusline should look something this:
![Gruvbox](https://user-images.githubusercontent.com/56435971/67209464-e924e080-f406-11e9-98ee-23e9a1109020.png)
![OneDark](https://user-images.githubusercontent.com/56435971/67209468-eaeea400-f406-11e9-8343-27fc2bb8b954.png)             
![Darcula](https://user-images.githubusercontent.com/56435971/67209459-e75b1d00-f406-11e9-854a-00bc29526b93.png)

Your statusline will change to adapt to your theme.

## Installation    
With pathogen:    
```    
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

Enable minimalist mode by putting this in your .vimrc:
```vim
let g:streamline_minimal_ui = 1
```
\
\
If you would like any changes to be made to this plugin, please request them, I will try to add them as soon as possible.
