clear all;
clc;
% Configurarea portului serial
//s = serialport("COM7", 9600);
configureTerminator(s, "LF");

% Configurarea pinilor de ieșire și intrare
trigPin = "2";
echoPin = "3";
LEDlampRed = "4";
LEDlampYellow = "5";
LEDlampGreen = "6";
soundbuzzer = "7";

write(s, trigPin, "char");
write(s, echoPin, "char");
write(s, LEDlampRed, "char");
write(s, LEDlampYellow, "char");
write(s, LEDlampGreen, "char");
write(s, soundbuzzer, "char");

write(s, "setup", "char");

while (true)
    % Citirea datelor de la senzor
    write(s, "loop", "char");
    distanceincm = str2double(readline(s));
    disp(distanceincm);
    
    % Controlarea LED-urilor și buzzer-ului
    if (distanceincm < 50)
        write(s, LEDlampGreen+"HIGH", "char");
    else
        write(s, LEDlampGreen+"LOW", "char");
    end
    
    if (distanceincm < 20)
        write(s, LEDlampYellow+"HIGH", "char");
    else
        write(s, LEDlampYellow+"LOW", "char");
    end
    
    if (distanceincm < 5)
        write(s, LEDlampRed+"HIGH", "char");
        write(s, soundbuzzer+"1000", "char");
    else
        write(s, LEDlampRed+"LOW", "char");
    end
    
    if (distanceincm > 5 || distanceincm <= 0)
        disp("In afara intervalului permis de distante");
        write(s, "noTone("+soundbuzzer+")", "char");
    else
        disp(distanceincm+" cm");
        write(s, "tone("+soundbuzzer+","+sound+")", "char");
    end
    
    pause(0.3);
end

% Închiderea portului serial
clear s;
