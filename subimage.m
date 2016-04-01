% Copyright (C) 2014 Carn?? Draug <carandraug@octave.org>
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 3 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, see
% <http:##www.gnu.org/licenses/>.

% -*- texinfo -*-
% @deftypefn  {Function File} {} subimage (@var{bw})
% @deftypefnx {Function File} {} subimage (@var{img})
% @deftypefnx {Function File} {} subimage (@var{rgb})
% @deftypefnx {Function File} {} subimage (@var{ind}, @var{cmap})
% @deftypefnx {Function File} {} subimage (@var{x}, @var{y}, @dots{})
% @deftypefnx {Function File} {@var{h} =} subimage (@dots{})
% Display images in subplots.
%
% A single figure, even with multiple subplots, is limited to a single
% colormap.  With the exception of truecolor images, images will use the
% figure colormap which make it impossible to have multiple images with
% different display.  This function transforms any image in truecolor
% to workaround this limitation.
%
% The new subimage is displayed as if using @code{image}.  The optional
% arguments @var{x} and @var{y} are passed to @code{image} to specify the
% range of the axis labels.
%
% @seealso{image, imagesc, imshow, subplot}
% @end deftypefn

% This file has been modified from the original Octave file,
% to be MATLAB compatible. All other functionality remains the same.

function h = subimage (varargin)
if (nargin < 1 || nargin > 4)
    print_usage ();
end

if (nargin < 3)
    alternative_xy = false;
    im_ind = 1;
else
    alternative_xy = true;
    im_ind = 3;
    if (numel (varargin{1}) == 2 && numel (varargin{2}) == 2)
        x = varargin{1};
        y = varargin{2};
    else
        error ('subimage: X and Y must be two element vectors each');
    end
end

im = varargin{im_ind};
if (numel (varargin) > im_ind)
    rgb = ind2rgb (im, varargin{im_ind +1});
elseif (islogical (im))
    rgb = repmat (im2uint8 (im), [1 1 3 1]);
elseif (isgray (im))
    rgb = repmat (im, [1 1 3 1]);
elseif (isrgb (im))
    rgb = im;
else
    error ('subimage: no valid BW, IMG, IND, or RGB images in input arguments');
end

if (alternative_xy)
    tmp_h = image (x, y, rgb);
else
    tmp_h = image (rgb);
end

if (nargout > 0)
    h = tmp_h;
end
end

function imout = im2uint8 (img, varargin)
if (nargin < 1 || nargin > 2)
    print_usage ();
elseif (nargin == 2 && ~ strcmpi (varargin{1}, 'indexed'))
    error ('im2uint8: second input argument must be the string ');
end
imout = imcast (img, 'uint8', varargin{:});
end


function imout = imcast (img, outcls, varargin)

if (nargin < 2 || nargin > 3)
    print_usage ();
elseif (nargin == 3 && ~ strcmpi (varargin{1}, 'indexed'))
    error ('imcast: third argument must be the string');
end

incls = class (img);
if (strcmp (outcls, incls))
    imout = img;
    return
end

% we are dealing with indexed images
if (nargin == 3)
    if (~ isind (img))
        error ('imcast: input should have been an indexed image but it is not.');
    end
    
    % Check that the new class is enough to hold all the previous indices
    % If we are converting to floating point, then we don't bother
    % check the range of indices. Also, note that indexed images of
    % integer class are always unsigned.
    
    % we will be converting a floating point image to integer class
    if (strcmp (outcls, 'single') || strcmp (outcls, 'double'))
        if (isinteger (img))
            imout = cast (img, outcls) +1;
        else
            imout = cast (img, outcls);
        end
        
        % we will be converting an indexed image to integer class
    else
        if (isinteger (img) && intmax (incls) > intmax (outcls) && max (img(:)) > intmax (outcls))
            error ('imcast: IMG has too many colours');
        elseif (isfloat (img))
            imax = max (img(:)) -1;
            if (imax > intmax (outcls))
                error ('imcast: IMG has too many colours');
            end
            img = img - 1;
        end
        imout = cast (img, outcls);
    end
    
    % we are dealing with 'normal' images
else
    problem = false; % did we found a bad conversion?
    switch (incls)
        
        case {'double', 'single'}
            switch (outcls)
                case 'uint8',  imout = uint8  (img * 255);
                case 'uint16', imout = uint16 (img * 65535);
                case 'int16',  imout = int16 (double (img * uint16 (65535)) -32768);
                case {'double', 'single'}, imout = cast (img, outcls);
                otherwise, problem = true;
            end
            
        case {'uint8'}
            switch (outcls)
                case 'double', imout = double (img) / 255;
                case 'single', imout = single (img) / 255;
                case 'uint16', imout = uint16 (img) * 257; % 257 comes from 65535/255
                case 'int16',  imout = int16 ((double (img) * 257) -32768); % 257 comes from 65535/255
                otherwise, problem = true;
            end
            
        case {'uint16'}
            switch (outcls)
                case 'double', imout = double (img) / 65535;
                case 'single', imout = single (img) / 65535;
                case 'uint8',  imout = uint8 (img / 257); % 257 comes from 65535/255
                case 'int16',  imout = int16 (double (img) -32768);
                otherwise, problem = true;
            end
            
        case {'logical'}
            switch (outcls)
                case {'double', 'single'}
                    imout = cast (img, outcls);
                case {'uint8', 'uint16', 'int16'}
                    imout = repmat (intmin (outcls), size (img));
                    imout(img) = intmax (outcls);
                otherwise
                    problem = true;
            end
            
        case {'int16'}
            switch (outcls)
                case 'double', imout = (double (img) + 32768) / 65535;
                case 'single', imout = (single (img) + 32768) / 65535;
                case 'uint8',  imout = uint8 ((double (img) + 32768) / 257); % 257 comes from 65535/255
                case 'uint16', imout = uint16 (double (img) + 32768);
                otherwise, problem = true;
            end
            
        otherwise
            error ('imcast: unknown image of class');
            
    end
    if (problem)
        error ('imcast: unsupported TYPE ');
    end
end

end


