classdef (Abstract) NewTmatrixBase < ott.ui.support.AppTopLevel ...
    & ott.ui.support.AppProducer
% Base class for beam creation application windows.
%
% This class is not intended to be instantiated directly.
% The T-matrix is stored internally and written to the matlab workspace
% if a variable name is given for the shape.  To access the internal
% instance use:
%
%   app = ott.ui.tmatrix.<name-of-your-app>()
%   tmatrix = app.Data

% Copyright 2021 IST Austria, Written by Isaac Lenton
% This file is part of OTT, see LICENSE.md for information about
% using/distributing this file.

  properties (Constant)
    windowSize = [640, 420];
  end
  
  properties (Access=public)
    MainGrid            matlab.ui.container.GridLayout
    ShapeName           ott.ui.support.VariableDropdown
  end
  
  methods (Access=protected)
    function setDefaultValues(app)
      app.VariableName.Value = '';
      app.ParticleName.Value = '';
      app.UpdateButton.Value = 0;
      app.UpdateButton.ClearErrors();
    end
    
    function createMainComponents(app)
      
      % Create grid
      app.MainGrid = uigridlayout(app.UIFigure, [4, 1]);
      app.MainGrid.RowHeight = {32, 32, '1x', 32};
      app.MainGrid.ColumnWidth = {220};
      app.MainGrid.ColumnSpacing = 1;
      app.MainGrid.RowSpacing = 1;
      
      app.VariableName = ott.ui.support.OutputVariableEntry(app.MainGrid);
      app.VariableName.Layout.Row = 1;
      app.VariableName.Layout.Column = 1;
      
      app.ShapeName = ott.ui.support.VariableDropdown(app.MainGrid);
      app.ShapeName.Layout.Row = 2;
      app.ShapeName.Layout.Column = 1;
      
      app.UpdateButton = ott.ui.support.UpdateWithProgress(app.MainGrid);
      app.UpdateButton.Layout.Row = 4;
      app.UpdateButton.Layout.Column = 1;
      
    end
  end
  
  methods
    function app = NewTmatrixBase()
      
      % Call window constructor first to create widgets
      app = app@ott.ui.support.AppTopLevel();
      
      % Then call AppProducer to connect production widgets
      app = app@ott.ui.support.AppProducer();
      
    end
  end
end