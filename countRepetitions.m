function [anyReps details] = countRepetitions(inputVector)
%COUNTREPETITIONS counts all repetitions of any element in A.
%   T = COUNTREPETITIONS(A) returns the total number of repetitions of any
%   element in A. The n-th element in T is the number of n-time-repetitions
%   of any element in A.
%
%   [T,D] = COUNTREPETITIONS(A) also returns a structure, containing a detailed
%   listing of all repetitions for each element in A. 
%   D.elements just reflects unique(A). Cell array k in D.listing contains only
%   the repetitions of D.elements(k), using the same format as T.
%
%   Input is restricted to be a vector of type logical, numeric or char.
%   Matrices don't get rejected, but are interpreted as single vector, written 
%   column-wise from left to right (so possibly not what you want).
%
%   Example:
%      For A = [0,1,0,0,1,1,1,42,42,42], [T,D] = COUNTREPETITIONS(A) yields:
%
%      T = [2 1 2 0 0 0 0 0 0 0], thus reporting 2x single elements, 1x a tuple,
%                                 and 2x a triple of repeated elements.
%
%      D = elements: [0 1 42]
%           listing: {3x1 cell} is also easily interpreted:
%
%      D.listing contains all element-wise repetitions in the same order
%      as indicated by D.elements:
%
%      D.listing{:}
%       ans =
%            1 1 0 0 0 0 0 0 0 0  (<=> there's 1x a single 0, and 1x "[0,0]")
%       ans =
%            1 0 1 0 0 0 0 0 0 0  (<=> there's 1x a single 1, and 1x "[1,1,1]")
%       ans =
%            0 0 1 0 0 0 0 0 0 0  (<=> there's 1x "[42,42,42]")
%
%       Thus if you are interested in the repetitions of a specific element, you
%       may easily use logical indexing. For example:
%       D.listing{D.elements == 42}, just yields [0 0 1 0 0 0 0 0 0 0].
%
%   Author: Johannes Keyser (jkeyser@uos.de), Autumn 2009
%   Revision 03/18/2010: further generalized output format, simplified code

    %%% First, get rid of unmanageable input...
    if length(inputVector) < 2
        error('MATLAB:countRepetitions:ArrayTooShort',...
              'Please enter an array of length > 1!')
    end
    if ~(isa(inputVector, 'numeric') || isa(inputVector, 'logical') ...
        || isa(inputVector, 'char'))
        error('MATLAB:countRepetitions:NotANumericArray',...
        'Currently, only numeric, logical or char arrays are allowed!')
    end
    % enforce interpretation as column vector
    inputVector = inputVector(:);
    
    %%% General idea:
    % Implement a simple pushdown-automaton with as many states as corresponding
    % to unique elements that _could_ be repeated. If the next element in 
    % inputVector matches the current state, increase the stack; if not, reset
    % the stack (i.e. start over counting from 1).
    % All that's left to do is to save the stack when the state changes!
    % Example: If inputVector constists of only two possible entries, say [0,1],
    %          the resulting states would be '0' <=> "currently counting zeros" 
    %          and '1' <=> "currently counting ones"
    
    %%% Setup
    % all repeatable elements become the automatons' possible states
    uniqElems = unique(inputVector);
    % we'll save repetitions for each repeatable element separately
    repsListing = cell(length(uniqElems), 1);
    % for each element, prepare counters for all its' possible repetitions
    for i = 1:length(uniqElems)
        repsListing{i} = zeros(1, length(inputVector));
    end
    % also prepare a field for ALL repetitions, irrespective of which
    % element got repeated
    anyReps = zeros(1, length(inputVector));
    
    %%% Helper function to increase the counters on state change
    function increaseCounters()
        % increase the column of that counted element which corresponds
        % to the number the stack has reached 
        repsListing{uniqElems == currentState}(stack) = ...
            repsListing{uniqElems == currentState}(stack) +1;
        % also increase the total counter
        anyReps(stack) = ...
            anyReps(stack) +1;
    end

    %%% Now (let the automaton) iterate through the input array
    % set the initial state and init stack with 1st seen element
    currentState = inputVector(1);
    stack = 1;
    for i = 2:length(inputVector);
        if currentState == inputVector(i)
            stack = stack +1;
        else
            % save the stack
            increaseCounters();
            % from now on, count different elements
            currentState = inputVector(i);
            % we got already the 1st new element...
            stack = 1;
        end
    end
    % don't forget to save the last stack state
    increaseCounters();
    
    %%% Prepare Output
    % 1.) often, only repetitions of any element are interesting (set in
    %     increaseCounters())
    % 2.) if asked, also return the element-wise repetition counts
    if nargout > 1
        details = struct;
        % needed to interpret the itemized listing of repetitions per element
        details.elements = uniqElems';
        % contains counted repetition sequences for each element separately
        details.listing = repsListing;
    end
end