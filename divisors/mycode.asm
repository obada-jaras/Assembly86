.model small
.stack 100
.data 
    msg          db "Welcome, enter one digit integer", 10, 13, '$'   
    num          db ?
    ff           db ?
    msg1         db 10, 13, "The divisors are: ", 10, 13, '$'
    result       db ?

.code
start:

    mov ax, @data
    mov ds, ax
    mov ax, 0
               
    
    mov ah, 9
    mov dl, offset msg
    int 21h
    
      
    mov ah, 1
    int 21h  
       
        
    sub al, 48           
    mov cl, al
    
    mov ff, al
    mov ax, 0 
       
       
    mov ah, 9
    mov dl, offset msg1
    int 21h  
    mov ax, 0    
     
          
    x:
        mov bl, cl
        mov al, ff
        div bl    
        
        cmp ah, 0
        je print 
        r:
            mov ax, 0
    
    
    loop x    
    
    jmp end      
    
    
    print:
        mov ah, 2
        mov bl, cl
        add bl, 48
        mov dl, bl
        int 21h
        
        mov dl, 13
        int 21h 
        
        mov dl, 10
        int 21h
        jmp r
    
          
                 
    end:
        mov ax, 4c00h
    
    
    int 21h           
           
    
end start
