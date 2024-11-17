--LIBRARY SECTION: (
    -- la libreria standard è GIA' inserita di default
    -- questa contiene tipi integer, natural, positive, boolean 
    library IEEE; -- così seleziono la libreria IEEE
    use IEEE.STD_LOGIC_1164.ALL; --qui seleziono i singoli pacchetti della libreria. 
    -- se non li seleziono, NON LI USO! 
    -- ALL serve per usare tutto il "package" 
    use IEEE.NUMERIC_STD.ALL; -- altro package usato per SIGNED e UNSIGNED
--) FINE LIBRARY SECTION.

--TIPI: (
    -- standard: 
    type INTEGER is range -2147483647 to 2147483647 ; --intero a 32 bit, massimo 2^31-1
    subtype NATURAL is range 0 to INTEGER'HIGH; 
    subtype POSITIVE is range 1 to INTEGER'HIGH; --NON usano 32 bit! il massimo è sempre 2^31-1! 
    --quelli sopra sono SCALARI!! NON so cosa instanzierà l'hardware; 
    type BOOLEAN; 
    --std_logic_1164: 
    TYPE std_ulogic IS ( 'U', -- Uninitialized
                        'X', -- Forcing Unknown
                        '0', -- Forcing 0
                        '1', -- Forcing 1
                        'Z', -- High Impedance
                        'W', -- Weak Unknown
                        'L', -- Weak 0
                        'H', -- Weak 1
                        '-' -- Don't care
                        ); 
    SUBTYPE std_logic IS resolved std_ulogic; --questo sa cosa fare se colleghi due buffer allo stesso segnale 
    --ci sono poi i vettori std_logic_vector a cui posso dare indici a fantasia
    --numeric_std: 
    type UNSIGNED is array ( NATURAL range <> ) of STD_LOGIC;
    type SIGNED is array ( NATURAL range <> ) of STD_LOGIC; --sono array di std_logic, ma con dimensione grande a piacere. 
    --se ne possono controllare i singoli bit, essendo vettori di std_logic, a patto di CONOSCERE LA RAPPRESENTAZIONE! 
--) FINE TIPI.

-- ENTITY SECTION: ( --per definire parametri e porte d'ingresso/uscita visibili dall' ESTERNO!!
-- una ENTITY rappresenta il blocco base di VHDL. E'una scatola con ingressi, uscite e una funzione logica di trasferimento
    entity teoria is
        Generic (                   --così dichiaro un parametro che sarà usato solo in PRE-SYNTHESIS 
            COSA : integer := 123   -- gli posso dare un valore di default (quando viene istanziato glielo posso overridare)
            );                     --potrà essere passato solo dall'ESTERNO verso l'INTERNO
        Port (                      --qui dichiaro ingressi e uscite della entity
            nome : in  std_logic ;     -- in ordine <nome : modo tipo>. Modi: IN OUT INOUT BUFFER LINKAGE 
            tristo: inout std_logic; -- usata nei tristate => attento che non puoi sempre usarla 
            gnome: buffer std_logic ;  -- permette di leggere anche valore precedente 
            ferro: linkage std_logic;   -- crea collegamento diretto senza buffer 
            bloccato: in std_logic_vector (0 to 4); --ho bloccato la dimensione dell'array (constrained)
            libero: in std_logic_vector;  --la dimensione sarà determinata dal vettore che ci attacco quando istanzio
            vect: out std_logic_vector (1 to 7) 
            --non posso scegliere opzione "unconstrained" per TOP entity!!  
            );                      --cerca di usare sempre std_logic! Anche per i numeri! 
    end teoria;
-- ) FINE ENTITY SECTION. 

--ARCHITECTURE SECTION: ( per definire comportamento della entity e/o componenti interne 
    -- in generale si descrive 1 architecture per entity, 1 entity per file, e si dà lo stesso nome a file e entity
    architecture Behavioral of teoria is  -- architecture <nome architettura> of <nome entity> is 
    -- DECLARATIONS ( qui si definiscono elementi interni alla entity che verranno usati per espletare la funzione logica 
        signal n1 : std_logic ; --dichiaro un segnale interno, un bus NON inizializzato (valore U) 
        signal n2 : std_logic := '0'; -- ora ho scelto un valore iniziale 
        signal vettore: std_logic_vector (vect'RANGE) := (others => '0'); --ho inizializzato il vettore a tutti zeri 
        constant c1 : std_logic := '1'; --ho fissato una costante interna
        component and2 is --così richiamo una altra entity che a questo punto 
            port (              --potrà essere instanziata più volte nella architecture 
                a : in std_logic; 
                b : in std_logic; 
                c: out std_logic 
                ) ; 
            end component; --attento! Qua scrivi "end component" e non "end <nome entity> " 
    --) fine DECLARATIONS 
    -- CONCURRENT STATEMENTS ( qui si descrive il circuito, tutti i suoi collegamenti interni, e la sua funzione logica 
    begin
    and2_primo: and2 --così istanzio un blocco, che è una altra entity, che avevo dichiarato prima nella sez. DECLARATIONS
        port map ( --dichiaro a chi collego le porte 
            a => bloccato(0), --freccia verso destra! Usa la virgola e non il punto e virgola
            b => bloccato(1),
            c => tristo
            ); 
        vect <= bloccato(2) & bloccato (4) ; -- & è operatore CONCATENAZIONE
        --ATTRIBUTES ( servono per richiamare alcune grandezze chiave dei vettori 
            vect'HIGH => 7; --restituisce indice più alto
            vect'LOW => 1; -- // indice più basso
            vect'LEFT => 1; -- // indice più a sinistra 
            vect'RIGHT => 7; -- // indice più a destra 
            vect'RANGE => (1 to 7); -- // range del vettore 
            vect'REVERSE_RANGE => (7 downto 1); -- // range inverso del vettore 
        --) fine attributes
        --AGGREGATE ( modo per dichiarare i singoli bit di un vettore. Lo uso solo coi singoli bit. Differenze con VHDL 2008
            vect <= ( 1 => '0', 2 => bloccato(0), 3|4 => '1', others => '0'); 
            --sintassi intuitiva, guarda versi frecce. 
        --) fine AGGREGATE
        --ALU ( costrutti utili per fare ALU 
            --WHEN/ELSE ( conditional signal assignment 
                vect <= "0001000" when nome = '1' else 
                        vettore when bloccato = "10010" else 
                        vettore(vettore'HIGH)&"000000" ; --caso default 
            --) fine when/else 
            --  WITH/SELECT ( selected signal assignment, questo fa proprio un multiplexer) 
                with nome select vettore <= "0101010" when '1', --la struttura è a chiasmo (che imbecilli!) 
                                         "1010101" when '0', 
                                         "0001000" when others; --caso di default, da inserire sempre se lasci qualcosa scoperto 
            --) fine with/select 
                
    --) fine CONCURRENT STATEMENTS 
    end Behavioral;
--) fine ARCHITECTURE SECTION