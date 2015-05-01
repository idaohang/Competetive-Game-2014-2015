function r = find_ball_r( tt, argmin, N )
if(nargin < 3 || isempty(N))
    N = 1.1303492302532556e21;
end
count = 1;
sz = size(tt);
%disp(length(sz))
%return
args_top = argmin;
args_bot = argmin;

while count < N
    for i = 1:length(sz)
        if args_top(i) == sz(i) && args_bot(i) ~= 1
            args_bot(i) = args_bot(i) - 1;
        elseif args_top(i) ~= sz(i)
            args_top(i) = args_top(i) + 1;
        end
        
        count = prod(abs(args_top-args_bot + 2*ones(size(args_top)) ));
        disp(count/N*100);
        
        if count >= N
            t = args_top;
            b = args_bot;
            r = tt_max(tt(b(1):t(1),b(2):t(2),b(3):t(3),b(4):t(4),b(5):t(5),b(6):t(6),b(7):t(7),b(8):t(8),b(9):t(9),b(10):t(10),b(11):t(11),b(12):t(12),b(13):t(13),b(14):t(14),b(15):t(15)));
        end
    end
    
    for i = 1:length(sz)
        if args_bot(i) == 1 && args_top(i) ~= sz(i)
            args_top(i) = args_top(i) + 1;
        elseif args_bot(i) ~= 1
            args_bot(i) = args_bot(i) - 1;
        end
        
        count = prod(abs(args_top - args_bot + 2*ones(size(args_top)) ));
        disp(count/N*100);
        if count >= N
            t = args_top;
            b = args_bot;
            r = tt_max(tt(b(1):t(1),b(2):t(2),b(3):t(3),b(4):t(4),b(5):t(5),b(6):t(6),b(7):t(7),b(8):t(8),b(9):t(9),b(10):t(10),b(11):t(11),b(12):t(12),b(13):t(13),b(14):t(14),b(15):t(15)));
        end
        
    end
end

end

