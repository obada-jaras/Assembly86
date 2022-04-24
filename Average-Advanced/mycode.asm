
;Obada Tahayna
;1191319
;Section: 1


.model small 
.stack 100
.data
    msgWelcome  db  10, 13, "Please Enter 10 numbers (marks):", 10, 13, '$'
    msgMark     db  "Mark $"
    msgColon    db  ": $"
    msgNewLine  db  10, 13, '$'
    msgError    db  10, 13, "This is INVALID mark", 10, 13, '$'
    msgAvg      db  10, 13, "The average is $"
    msgThereAre db  "There are $"
    msgAbove    db  " marks above average", 10, 13, '$'
    msgEqual    db  " marks = average", 10, 13, '$'
    msgBelow    db  " marks below average", 10, 13, '$'
    msgBye      db 10, 10, 10, 13, "Bye!", 10, 13, "Obada Tahayna 1191319", 10, 13, '$'

    sum         dw  ?
    avg         db  ?
    counter     db  0
    number      dw  0Ah
    tempC       dw  ?
    tempP       db  ? 
    rem         db  ?
    above       db  0
    equal       db  0
    below       db  0
    err         db  0





.code 
start:
    
    mov ax, @data
    mov ds, ax 
    mov ax, 0  
     
     
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
        sub num, 30h 
    endm 
     
     
     
     
    scanTwoDigit macro     
        mov dl, 10  
        mov bl, 0 
        mov err, 0
        
        mov cx, 2          ;to read 2 digit number
         
        scanNum:
        
              mov ah, 01h
              int 21h
        
         
              mov ah, 0  
              sub al, 48   ; ASCII to DECIMAL
              
              cmp al, 0
              jb errorFlag
        
              cmp al, 9
              ja errorFlag
              
              rr:
              
              mov dh, al
              mov al, bl   ; Store the previous value in AL
        
              mul dl       ; multiply the previous value with 10
        
              add al, dh   ; previous value + new value ( after previous value is multiplyed with 10 )
              mov bl, al 
              mov bh, 0h
              mov number, bx
              
        loop scanNum    
    endm   
    
    
    
    
    printTwoDigit macro num

        ;clear AH to use for reminder
        mov ah,00
        ;moving sum to al
        mov al,num
        ;take bl=10
        mov bl,10
        ;al/bl --> twodigit number/10 = decemel value
        div bl
        ;move reminder to rim
        mov rem,ah
        ;to print (al) we move al to dl
        mov dl,al
        add dl,48
        mov ah,02h
        int 21h
    
        ;to print the reminder
        mov dl,rem
        add dl,48
        mov ah,02h
        int 21h
    
        
        
        
    endm
    ;endMacros
    
    
    
    
    printStr msgWelcome
    mov cx, 10    ;to read 10 markes        
    
    
    x1: 
        mov tempC, cx 
        rete:
        add counter, 1
        
        printStr msgMark   
        printTwoDigit counter
        printStr msgColon
        scanTwoDigit
        printStr msgNewLine       
        
        
        ;;
        cmp err, 1
        je error1
               
        
        mov bx, number

        mov [si], bx
        add si, 1
        mov dx, number
        add sum, dx         
        mov cx, tempC
        
        
         
    loop x1         
    mov si, 0          
              
   
  
    
       
    ;to find the average
    mov ax, sum
    
    mov bl, 10
    div bl
    mov avg, al     
    ;;;;;;;;;;;;;;;;;;;;
    
    
    printStr msgAvg
    printTwoDigit avg
    
    
    
    
       
    mov cx, 10
    check:
        mov bl, avg
        mov bh, 0
        mov ax, 0
        mov al, [si]
        add si, 1
        
        cmp ax, bx
        ja chAbove 
        ab:
        
        cmp ax, bx
        jz chEqual
        eq:
        
        cmp ax, bx          
        jb chBelow
        be:  
        
        
    loop check
      
      
      
      
         
     printStr msgNewLine
     printStr msgNewLine
     printStr msgNewLine
     
     printStr msgThereAre
     printNum above
     printStr msgAbove
    
     printStr msgThereAre
     printNum equal
     printStr msgEqual
     
     printStr msgThereAre
     printNum below
     printStr msgBelow
    
    jmp toEnd
    
    
    
    
    
    
    chAbove:
       add above, 1
       jmp ab 
    
     chEqual:
       add equal, 1
       jmp eq 
    
     chBelow:
       add below, 1
       jmp be 
    
    
    
 
    errorFlag:
        mov err, 1
        jmp rr
    
       
    error1:
        printStr msgError 
        sub counter, 1
        jmp rete
    
    
    
    
    toEnd:  
        printStr msgBye
        mov ax, 4c00h
        int 21h     
end start      
