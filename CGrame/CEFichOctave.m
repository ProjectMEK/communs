classdef CEFichOctave < CETypeUint16
  properties (Constant)
    analyse =uint16(1);
    Texte =uint16(2);
    A21XML =uint16(3);
    HDF5 =uint16(4);
    %c3d =uint16(5);
    EMG =uint16(6);
    Keithley =uint16(7);
  end

  methods (Access =private)
    function tO = CEFichOctave(VAL)
      try
        tO.setList({'analyse','Texte','A21XML','HDF5','EMG','Keithley'});
        tO.setPpa('CEFichOctave');
        tO.init(VAL);
      catch U;
      	rethrow(U);
      end
    end
  end

  methods (Static)
    function tO = create(Vin)
      try
      	monnom ='CEFichOctave';
        if strncmp(monnom, class(Vin), length(monnom))
          cur =Vin.char();
        else
          cur =Vin;
        end
        tO =CEFichOctave(cur);
      catch U;
        disp(U.identifier)
        disp(U.message)
        for V =1:length(U.stack)
          disp(U.stack(V))
        end
      end
    end
  end
end
