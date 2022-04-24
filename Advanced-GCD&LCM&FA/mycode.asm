;Obada Tahayna
;1191319
;Section: 1


.model small 
.stack 100
.data
    msgWelcome      db  "Hello!", 10, 10, 13, '$'   
    msgEnter        db  10, 13, "Please Enter Number $"
    msgColon        db  ": $"      
    msgNewLine      db  10, 13, '$'
    msgErrorIn      db  10, 13, "This is INVALID Number, Please enter just numbers", 10, 10, 13, '$'
    msgErrorBet     db  10, 13, "This is INVALID Number, Please enter number between 0 and 250", 10, 10, 13, '$'
    msgGCD          db  10, 13, "GCD = $"
    msgLCM          db  10, 13, "LCM = $"
    msgExample      db  10, 13, "Example of fractions addition, Enter two fractions", 10, 13, '$'
    msgSlash        db  "/$"
    msgPlus         db  " + $"
    msgEqual        db  " = $"
    strBigNumberError db 10, 10, 13, "Error, the result of adding first numerator with the second one after reduction of fractions is greater than 65536 and It cannot be processed",10, 13, '$'
    msgBye          db  10, 10, 10, 10, 13, "Bye!", 10, 13, "Obada Tahayna 1191319", 10, 13, '$'
       
    number          dw  0Ah   
    number1         dw  0Ah
    number2         dw  0Ah
    errIn           db  0         ;this error flag for invalid input like characters or symbols 
    temp            dw  ?  
    counter         db  0  
    ten             db  0Ah 
    tenW            dw  0Ah
    rem1            dw  ?   
    rem2            dw  ? 
    GCDValue        dw  ?
    LCMValue        dw  ? 
    numerator1      dw  ?
    denominator1    dw  ?
    numerator2      dw  ?
    denominator2    dw  ?
    digit1          db  ?
    digit2          db  ?
    digit3          db  ?  
    digit4          db  ?
    digit5          db  ?



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
       
        
    
    
    printNum macro num
        mov ah, 02
        add num, 30h
        mov dl, num
        int 21h
        sub num, 30h 
    endm  
       
       
       
    
    scan macro 
            mov ah, 01
            int 21h  
    endm  
    
    

    
   printThreeDigit macro num
               
        mov dx, 0
        mov ax, num
        div tenW
        mov digit1, dl
         
        mov dx, 0
        div tenW
        mov digit2, dl            
    
        mov dx, 0
        div tenW
        mov digit3, dl 
        
           
        printNum digit3
        printNum digit2
        printNum digit1 
    endm 
    
    
    
    
    
    
    
    printFiveDigit macro num
               
        mov dx, 0
        mov ax, num
        div tenW
        mov digit1, dl
         
        mov dx, 0
        div tenW
        mov digit2, dl            
    
        mov dx, 0
        div tenW
        mov digit3, dl 
                                                                                                                                                      
        mov dx, 0
        div tenW
        mov digit4, dl
         
        mov dx, 0
        div tenW
        mov digit5, dl
         
        printNum digit5 
        printNum digit4  
        printNum digit3
        printNum digit2
        printNum digit1 
    endm
    ;endMacros
    
    
    
    
    printStr msgWelcome 
         
        
         
    mov cx, 2     
    getTwoNumbers:
        mov temp, cx
        
        rete:
        add counter, 1
        
        
        printStr msgEnter
        printNum counter
        printStr msgColon
        call scanThreeDigit
        
        cmp errIn, 1
        je errorInvalid1 
        
        mov ax, 250
        cmp number, ax
        ja errorBetween1
        
        mov ax, 1
        cmp number, ax
        jb errorBetween1 
        
        mov bx, number
        
        mov [si], bx
        add si, 2
        
        mov cx, temp
    loop getTwoNumbers 
    
    
    
          
           
    mov si, 0
          
    mov ax, [si]
    mov number1, ax
    
    add si, 2     
    mov ax, [si]
    mov number2, ax  
           
         
         
         
         
        
            
            
            
    ;calculate GCD and LCM 
    call getGCD 
           
         
     mov ax, number1
     mul number2
     div GCDValue
     
     mov LCMValue, ax
     ;;
         
         
         
         
    printStr msgNewLine
    printStr msgNewLine    
    printStr msgNewLine     
         
         
    printStr msgGCD
    printFiveDigit GCDValue
           
           
           
    printStr msgLCM
    printFiveDigit LCMValue      
         
         
         
         
         
         
         
         
         
         
         
         
    printStr msgNewLine
    printStr msgNewLine    
    printStr msgNewLine     
      
   
   
   
   
    printStr msgExample
   
   
     
     
     
    mov counter, 1
    rete2:
        reteP1:
        cmp counter, 1
        je one
        
        reteP2:
        cmp counter, 2
        je two
         
        reteP3: 
        cmp counter, 3
        je three
        
        reteP4: 
        cmp counter, 4
        je four
        
        reteP5: 
        cmp counter, 5
        je five
     
               
               
        rete22: 
         
        cmp errIn, 1
        je errorInvalid2 
        
        mov ax, 250
        cmp number, ax
        ja errorBetween2
        
        mov ax, 1
        cmp number, ax
        jb errorBetween2 
          
          
        cmp counter, 1
        je S1
        
        cmp counter, 2
        je S2
        
        cmp counter, 3
        je S3
        
        cmp counter, 4
        je S4
        
        reteS:
        
        add counter, 1h
        jmp rete2
    
     
     
     
     
   
    one:
    call scanThreeDigit
    jmp rete22       
                  
           
    two:
    printStr msgSlash
    call scanThreeDigit
    jmp rete22
    
    
    three:         
    printStr msgplus
    call scanThreeDigit
    jmp rete22
    
    
    four: 
    printStr msgSlash
    call scanThreeDigit
    jmp rete22
    
      
    five:
    printStr msgEqual
               
               
               
               
               
    
    ;; GCD of denominator1 and denominator2
    ;; denominator1 / GCD > rem1
    ;; denominator2 / GCD > rem2
    
    ;; numerator1   *= rem2
    ;; numerator2   *= rem1     
     
    
    
    ;; numerator1 += numerator2
     
    ;; denominator1 *= rem1 
     
    ;; numerator1 and denominator1 > find GCD
    
    ;; numerator1   /= GCD
    ;; denominator1 /= GCD   
      
      
      
       
       
    ; GCD of denominator1
    ; and denominator2
    mov ax, denominator1
    mov number1, ax
    mov ax, denominator2
    mov number2, ax
    
    call getGCD
                               
                               
    ; denominator1 / GCD > rem1
    mov ax, denominator1
    div GCDValue
    mov rem1, ax    
    
    
    ; denominator2 / GCD > rem2
    mov ax, denominator2
    div GCDValue
    mov rem2, ax   
    
    
    ; numerator1   *= rem2 
    mov ax, rem2
    mul numerator1
    mov numerator1, ax 
     
    
    ; numerator2   *= rem1 
    mov ax, rem1
    mul numerator2
    mov numerator2, ax
    
    
    ; denominator1 *= rem2 
    mov ax, rem2
    mul denominator1
    mov denominator1, ax
      
       
       
       
       
    ; numerator1 += numerator2
    mov ax, numerator1
    mov number1, ax
    mov ax, numerator2
    add number1, ax   
          
       
    ;; if the result of adding numerator1 and
    ;; numerator2 is less than the small number
    ;; between them, that means that the result
    ;; is greatest than 65536, that mean we cannot
    ;; process it with our program so the program 
    ;;will print an error message    
    
    
    ;put smaller in number
    mov ax, numerator1   
    cmp numerator2, ax
    ja twoIsBigger   
           
    mov ax, numerator2  
    mov number, ax
    jmp continue1
           
       
    twoIsBigger:
    mov number, ax      
    continue1:   
    ;;
    
    
    ; check if the result is less than number   
    mov ax, number1 
    cmp number, ax
    ja belowError
    
    
    ; return value of number1 to numerator1
    mov ax, number1
    mov numerator1, ax
        
        
        
    ; find GCD of numerator1 and denominator1 
    mov ax, denominator1
    mov number2, ax
    
    call getGCD
    
    
    ; numerator1   /= GCD
    mov ax, numerator1
    div GCDValue
    mov numerator1, ax
           
           
    ; denominator1   /= GCD
    mov ax, denominator1
    div GCDValue
    mov denominator1, ax
           
    
      
      
    printFiveDigit numerator1
    printStr msgSlash 
    printFiveDigit denominator1 
     
     
         
          
        
    jmp toEnd
    
    
       
  
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
     reteP:
        cmp counter, 1
        je reteP1
        
        cmp counter, 2
        je P2
        
        cmp counter, 3
        je P3
        
        cmp counter, 4
        je P4
        
        cmp counter, 5
        je reteP2
        
       
      
    P2:
        printThreeDigit numerator1
        
        jmp reteP2
     
      
    P3: 
        printThreeDigit numerator1
        printStr msgSlash
        printThreeDigit denominator1 
        
        jmp reteP3
     
      
    P4: 
        printThreeDigit numerator1
        printStr msgSlash
        printThreeDigit denominator1
        printStr msgPlus
        printThreeDigit numerator2
        
        jmp reteP4
    
      
    
        
        
    
    S1:
       mov ax, number
       mov numerator1, ax
       jmp reteS
    
    S2:
       mov ax, number
       mov denominator1, ax
       jmp reteS
    
    S3:
       mov ax, number
       mov numerator2, ax
       jmp reteS
    
    S4:
       mov ax, number
       mov denominator2, ax
       jmp reteS
    
   
       
    
    errorInFlag:
        mov errIn, 1
        jmp rr
    
          
          
      
      
    errorInvalid1:
        printStr msgErrorIn 
        sub counter, 1
        jmp rete
    
    errorBetween1:
        printStr msgErrorBet 
        sub counter, 1
        jmp rete
           
           
           
           
  
     
     
     
    errorInvalid2:
        printStr msgErrorIn 
        jmp reteP
    
    errorBetween2:
        printStr msgErrorBet 
        jmp reteP
        
         
         
   belowError:
        printStr strBigNumberError
        jmp toEnd      
        
        
    toEnd:  
        printStr msgBye
        mov ax, 4c00h
        int 21h    
        
        
        
        
    
     
     
     
     
     
    getGCD proc
        ;let number1 is the
        ;greatest between
        ;two numbers and
        ;number2 is the
        ;smallest
        cmp number1, ax
        ja noChange     
        
        
        ;swap
        mov bx, number1
        mov number1, ax
        mov number2, bx     
             
        noChange:     
        ;end swapping 
         
         
                  
        mov ax, number1        
        mov rem1, ax
        
        mov ax, number2        
        mov rem2, ax
        
        
    ;    rem1%rem2>rem1
    ;    swap 
    
        
        GCD:
            mov dx, 0   
            mov ax, rem1     
            div rem2
            mov rem1, dx   
            
            
            ;swap   
            mov bx, rem1
            mov ax, rem2
            mov rem1, ax
            mov rem2, bx    
            ;
            
            cmp rem2, 0h
            je exit
            
            jmp GCD
           
           
        exit:
           
        mov ax, rem1
        mov GCDValue, ax     
        ret
    getGCD endp
    
       
 
    
    
    
    
    scanThreeDigit proc     
        mov bx, 0 
        mov errIn, 0
        
        mov cx, 3          ;to read 3 digit number
         
        scanNum:
   
              
              mov ah, 01h
              int 21h
        
         
              mov ah, 0  
              sub ax, 48   ; ASCII to DECIMAL
              
              cmp ax, 0
              jb errorInFlag
        
              cmp ax, 9
              ja errorInFlag
              
              rr:
              
              mov dx, ax
              mov ax, bx   ; Store the previous value in AL
        
              mul ten      ; multiply the previous value with 10
        
              add ax, dx   ; previous value + new value ( after previous value is multiplyed with 10 )
              mov bx, ax 
            
              mov number, bx
        loop scanNum 
        ret   
    scanThreeDigit endp
    
    
        
            
end start      
