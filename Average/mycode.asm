;Obada Tahayna
;1191319
;Section: 1


.model small
.stack 100
.data 
    msg          db 10, 13, "Enter one digit number", 10, 13, '$'
    msg2         db 10, 10, 13, "Enter number to comapre it with the average, enter e to exit:  $"
    errMsg       db 10, 13, "Not valid number", 10, 13, '$'
    number       db ?
    sum          db ?
    avg          db ?  
    newLn        db 10, 13, '$'
    ab           db " > ", '$'
    be           db " < ", '$'
    eq           db " = ", '$'  
    byeMsg       db 10, 10, 13, "Bye!", 10, 13, "Obada Tahayna 1191319", 10, 13, '$'

.code
start:  
    
    ;macros
    printStr macro message
        mov ah, 09
        lea dx, message
        int 21h
    endm 
    
        
        
    scan macro 
            mov ah, 01
            int 21h  
    endm
        
        
    
    printNum macro num
        mov ah, 02
        add num, 30h
        mov dl, num
        int 21h 
    endm
    
    
       
    printRslt macro x
        printNum number 
        printStr x 
        printNum avg
        sub avg, 30h
        jmp x2 
    endm
    ;;;;;;;
           
        
           
           
    mov ax, @data
    mov ds, ax
    mov ax, 0  
    
      
    
    mov cx, 5    ;to loop 5 times        
      
    x1:
        printStr msg
        scan       
        
         
        cmp al, 30h
        jb error1
        
        cmp al, 39h
        ja error1
        
        
        
        sub al, 30h
        add sum, al
    loop x1         
    
      
      
    
    
    ;to find the average
    mov al, sum
    mov ah, 0h
    
    mov bl, 5
    div bl
    mov avg, al      
    ;;;;;;;;;;;;;;;;;;;;
    
    
      
      
      
    
    x2:
        printStr msg2
        scan   
        
        cmp al, 'e'
        jz end  
              
                 
        cmp al, 30h
        jb error2
        
        cmp al, 39h
        ja error2
        
        
              
        mov number, al  
        printStr newLn
        sub number, 30h
        mov al, number
          
        
          
        cmp al, avg        
        ja above
        jb below
        

    
        
        
    equal:
        printRslt eq
        
        
    above:  
        printRslt ab
           
                 
    below:             
        printRslt be   
            
    
    
    error1:
        printStr errMsg
        jmp x1
        
    error2:
        printStr errMsg
        jmp x2    
     
            
    end:  
        printStr byeMsg
        mov ax, 4c00h
        int 21h           
           
    
end start
