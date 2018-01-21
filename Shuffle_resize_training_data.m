%Matt Viney - 21/01/18

%Program to randomize the images in the Forward, Left and Right folders,
%and rename them with new random numbers then move to a new folder called
%Forward_randomized, left_randomized or right_randomized.
%It then finds the number of images in each category, and deletes the extra
%ones from the remaining 2 categories to give three randomized equally
%sized data sets in the folders Forward_randomized, left_randomized,
%right_randomized.

iteration_number = '4';

%Number of images in Forward file
Forward=dir([strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
    , iteration_number, '\Forward') '/*.jpg']);
Forward_size=size(Forward,1);

%Number of images in Left file
Left=dir([strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
    , iteration_number, '\Left') '/*.jpg']);
Left_size=size(Left,1);

%Number of images in Right file
Right=dir([strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
    , iteration_number, '\Right') '/*.jpg']);
Right_size=size(Right,1);

%Find which category has the minimum number of images
[min_images_number, min_images_category]  = min([Forward_size, Left_size, Right_size]);

%Create an array the same size as the number of Forward images and
%randomize the numbers
random_forward = 1:Forward_size;
random_forward = random_forward(randperm(length(random_forward)));

%Rename each image with the randomized number and move it to a new folder
for i=1:Forward_size
    img_location = strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Forward\image_', num2str(i), '.jpg');
    copyfile(img_location, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Forward_randomized\image_', num2str(random_forward(i)), '.jpg'));
    disp(i);
end

%Create an array the same size as the number of Left images and
%randomize the numbers
random_left = 1:Left_size;
random_left = random_left(randperm(length(random_left)));

%Rename each image with the randomized number and move it to a new folder
for i=1:Left_size
    img_location = strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Left\image_', num2str(i), '.jpg');
    copyfile(img_location, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Left_randomized\image_', num2str(random_left(i)), '.jpg'));
    disp(i);
end

%Create an array the same size as the number of Right images and
%randomize the numbers
random_right = 1:Right_size;
random_right = random_right(randperm(length(random_right)));

%Rename each image with the randomized number and move it to a new folder
for i=1:Right_size
    img_location = strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Right\image_', num2str(i), '.jpg');
    copyfile(img_location, strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
        , iteration_number, '\Right_randomized\image_', num2str(random_right(i)), '.jpg'));
    disp(i);
end


%Delete excess images
if min_images_category == 1
    %Least number of Forward images(should never happen)
    
elseif min_images_category == 2
    %Least number of Left images
    
    %Delete excess Forward images
    for i=min_images_number:Forward_size
        delete(strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            , iteration_number, '\Forward_randomized\image_', num2str(i), '.jpg'));
    end
    
    %Delete excess Right images
    for i=min_images_number:Right_size
        delete(strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            , iteration_number, '\Right_randomized\image_', num2str(i), '.jpg'));
    end
    
elseif min_images_category == 3
    %Least number of Right images
    
    %Delete excess Forward images
    for i=min_images_number:Forward_size
        delete(strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            , iteration_number, '\Forward_randomized\image_', num2str(i), '.jpg'));
    end
    
    %Delete excess Left images
    for i=min_images_number:Left_size
        delete(strcat('C:\Users\Matt\Documents\MATLAB\GTA V\Training_images'...
            , iteration_number, '\Left_randomized\image_', num2str(i), '.jpg'));
    end
    
end
