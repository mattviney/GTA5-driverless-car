%Matt Viney - 21/01/18

%Program to store GTA V images into 1 of 3 categories:
%Forward - when only forward or no button is pressed
%Right - when only right or right and forward are pressed
%Left - when only left or left and forward are pressed
%P - pauses the program
%U - unpauses the program

%Initialize video player to display captured frames (commented out to speed
%up GTA)

%videoPlayer = vision.VideoPlayer('Position', [960, 300, 820, 630]); 

%Iteration number for new folder for current iterations image storage
iteration_number = '4';

%5 second Countdown
z=5;
while z>0
   disp(z);
   pause(1); 
   z=z-1;
end

i=1;
j=1;
k=1;
stop = 0;

while(1)
        
    [direction, stop] = Key_press(stop);
    
    %If pause pressed, sit in loop until unpause pressed
    z=0;
    while stop == 1
        if z==0
            z=1;
            %pause_screen = uint8(zeros(590,800,3));
            text_str = 'Paused';
            %%pause_screen = insertText(pause_screen, [400 300], text_str, "FontSize", 30, "AnchorPoint", "Center");
            disp('*****Paused*****');
        end
        [direction, stop] = Key_press(stop);
        %step(videoPlayer, pause_screen);
    end
    
    frame = Grab_Screen();
    %step(videoPlayer, frame);
    frame = imresize(frame, [227, 227]);
    
    if direction == 'F'
        %If Forward key was pressed, store to Forward folder
        imwrite(frame, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            ,iteration_number,  '\Forward\image_', num2str(i), '.jpg'));
        i=i+1;
        
    elseif direction == 'R'
        %If Right key was pressed, store to Right folder
        imwrite(frame, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            ,iteration_number,  '\Right\image_', num2str(j), '.jpg'));
        j=j+1;
        
    elseif direction == 'L'
        %If Left key was pressed, store to Left folder
        imwrite(frame, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            ,iteration_number,  '\Left\image_', num2str(k), '.jpg'));
        k=k+1;
        
    end
        
    disp(direction);
    
end

function [direction, stop] = Key_press(stop)
%Function to read the keys pressed at current frame
%from python program Key_read.py

    key = char(py.Key_read.key_check());
    key_size = size(key,2);
    key_1 = 0;
    key_2 = 0;
    key_3 = 0;
    
    %Only store 3 pressed keys
    if key_size == 2
        %no buttons pressed
    elseif key_size == 5
        %1 button pressed
        key_1 = key(3);
        key_2 = 0;
        key_3 = 0;
    elseif key_size == 10
        %2 buttons pressed
        key_1 = key(3);
        key_2 = key(8);
        key_3 = 0;
    elseif key_size == 15
        %3 buttons pressed
        key_1 = key(3);
        key_2 = key(8);
        key_3 = key(15);      
    end
    
    if key_1=='A' || key_2=='A' || key_3=='A'
        %if A pressed, go left
        direction = 'L';
    elseif key_1=='D' || key_2=='D' || key_3=='D'
        %if D pressed, go right
        direction = 'R';
    else 
        %Else go forward
        direction = 'F';
    end
    
    if key_1=='P' || key_2=='P' || key_3=='P'
        %If pause pressed, toggle pause on
        stop = 1;
    elseif key_1=='U' || key_2=='U' || key_3=='U'
        %If unpause pressed, toggle pause off
        stop = 0;
    end
end

function [imgData] = Grab_Screen()
%Taken from https://uk.mathworks.com/matlabcentral/answers/362358-how-do-i-take-a-screenshot-using-matlab
    robot = java.awt.Robot();
    pos = [0 30 800 590];
    rect = java.awt.Rectangle(pos(1),pos(2),pos(3),pos(4));
    cap = robot.createScreenCapture(rect);
    rgb = typecast(cap.getRGB(0,0,cap.getWidth,cap.getHeight,[],0,cap.getWidth),'uint8');
    imgData = zeros(cap.getHeight,cap.getWidth,3,'uint8');
    imgData(:,:,1) = reshape(rgb(3:4:end),cap.getWidth,[])';
    imgData(:,:,2) = reshape(rgb(2:4:end),cap.getWidth,[])';
    imgData(:,:,3) = reshape(rgb(1:4:end),cap.getWidth,[])';
end