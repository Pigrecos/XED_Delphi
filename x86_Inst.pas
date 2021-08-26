unit x86_Inst;

interface
    uses System.SysUtils, Winapi.Windows, XED,xed.RegEnum,XED.IClassEnum,xed.OperandEnum,
         xed.OperandVisibilityEnum,xed.OperandTypeEnum,xed.OperandElementXtypeEnum,xed.OperandWidthEnum,
         xed.NonterminalEnum,xed.OperandActionEnum,XED.CategoryEnum,XED.ExtensionEnum,XED.IsaSetEnum,xed.IFormEnum,
         xed.SyntaxEnum,xed.RegClassEnum;

type
   x86_register = record
     private
        FXED_Reg : TXED_Reg_Enum;
     public
        // Operator
        class operator implicit(reg:TXED_Reg_Enum): x86_register;
        class operator Equal(reg:x86_register; reg1:x86_register): Boolean;
        class operator Equal(reg:TXED_Reg_Enum; reg1:x86_register): Boolean;
        class operator NotEqual(reg:x86_register; reg1:x86_register): Boolean;
        class operator NotEqual(reg:TXED_Reg_Enum; reg1:x86_register): Boolean;
        class operator LessThan(reg:x86_register; reg1:x86_register): Boolean;
        // wrappers
        function get_name: PAnsiChar;
        function get_class: TXED_Reg_Class_enum;
        function get_class_name: PAnsiChar;
        // Returns the specific width GPR reg class (like XED_REG_CLASS_GPR32 or XED_REG_CLASS_GPR64) for a given GPR register.
        // Or XED_REG_INVALID if not a GPR.
        function get_gpr_class: TXED_Reg_Class_enum;
        function get_largest_enclosing_register32: x86_register;
        function get_largest_enclosing_register: x86_register;
        function get_width_bits :TXEDUnsignedInt32;
        function get_width_bits64:TXEDUnsignedInt32;
        // helpers - GPR
        function is_gpr: Boolean;
        function is_low_gpr: Boolean;
        function is_high_gpr: Boolean;
        function get_gpr8_low: x86_register;	// al, cl, dl, bl
        function get_gpr8_high: x86_register; // ah, ch, dh, bh
        function get_gpr16: x86_register;	  	// ax, cx, dx, bx
        function get_gpr32: x86_register;	  	// eax, ecx, edx, ebx
        function get_gpr64: x86_register;	  	// rax, rcx, rdx, rbx
        // My Function
        function is_valid : Boolean;
        function is_pseudo: Boolean;
        function is_flag: Boolean;
   end;

   x86_Operand = record
     private
        FOp : TXED_Operand  ;
     public
        // Operands Access
        function get_name: TXED_Operand_Enum;
        function get_visibility: TXED_Operand_Visibility_Enum;
        function get_type:TXED_Operand_Type_Enum;
        function get_xtype:TXED_Operand_Element_Xtype_Enum;
        function get_width:TXED_Operand_Width_Enum;
        function get_width_bits(osz: TXEDUnsignedInt32):TXEDUnsignedInt32;
        function get_nonterminal_name: TXED_Nonterminal_Enum;
        function get_reg: TXED_Reg_Enum; // Careful with this one – use xed_decoded_inst_get_reg()! This one is probably not what you think it is.
        function template_is_register: Boolean; // Careful with this one
        function imm: TXEDUnsignedInt32;
        procedure print(buf: PAnsiChar; buflen: Integer);
        // Operand Enum Name Classification
        function is_register(name: TXED_Operand_Enum): Boolean; overload;
        function is_memory_addressing_register(name: TXED_Operand_Enum):Boolean;
        // Operand Read/Written
        function get_rw: TXED_Operand_Action_Enum;
        function is_read: Boolean;
        function is_read_only: Boolean;
        function is_written: Boolean;
        function is_written_only: Boolean;
        function is_read_written: Boolean;
        function is_conditional_read: Boolean;
        function is_conditional_written: Boolean;
        // helpers
        function is_register: Boolean;overload;
        function is_memory: Boolean;
        function is_immediate: Boolean;
        function is_branch: Boolean;

       class operator Explicit(op: TXED_Operand ): x86_Operand ;
       class operator implicit(i: x86_Operand ): TXED_Operand;
       class operator implicit(op: TXED_Operand ):x86_Operand;
  end;

  Px86_instruction = ^x86_instruction;
  x86_instruction = record
     private
        FDecInst : TXEDDecodedInstruction  ;
        FAddr    : Uint64;
        FBytes   : TArray<TXEDUnsignedInt8>;
        FInst    : AnsiString;
     public

       constructor Create(addr: UInt64);

       // xed functions
       function get_name: PAnsiChar;
       function get_category: TXED_Category_Enum;
       function get_extension: TXED_Extension_Enum;
       function get_isa_set: TXEDIsaSetEnum;
       function get_iclass: TXED_iClass_Enum;
       function get_machine_mode_bits: Cardinal;
       // bytes
       function get_length: xed_uint_t;
       function get_byte(byte_index: xed_uint_t): xed_uint_t;
       function get_operand_length_bits(operand_index: xed_uint_t): xed_uint_t;
       function get_iform_enum: TXED_iform_Enum;
       // operands
	     function operands_const: TXEDOperandValuesPtr;
       // register
	     function get_register(name: TXED_Operand_Enum = XED_OPERAND_REG0): x86_register;
       // memory
       function get_number_of_memory_operands: xed_uint_t;
       function is_mem_read(mem_idx: Cardinal = 0): Boolean;
       function is_mem_written(mem_idx: Cardinal = 0): Boolean;
       function is_mem_written_only(mem_idx: Cardinal = 0): Boolean;
       function get_segment_register(mem_idx : Cardinal = 0): x86_register;
       function get_base_register(mem_idx: Cardinal = 0): x86_register;
       function get_index_register(mem_idx: Cardinal = 0): x86_register;
       function get_scale(mem_idx: Cardinal = 0):xed_uint_t;
       function has_displacement: xed_uint_t;
       function get_memory_displacement(mem_idx: Cardinal = 0): TXEDUnsignedInt64;
       function get_memory_displacement_width(mem_idx : Cardinal= 0): xed_uint_t;
       function get_memory_displacement_width_bits(mem_idx: Cardinal = 0): xed_uint_t;
       function get_memory_operand_length(mem_idx: Cardinal = 0): xed_uint_t;
       // branch
       function get_branch_displacement: TXEDInt32;
       function get_branch_displacement_width: xed_uint_t;
       function get_branch_displacement_width_bits: xed_uint_t;
       // immediate
       function get_immediate_width: xed_uint_t ;
       function get_immediate_width_bits: xed_uint_t ;
       function get_immediate_is_signed: Boolean;
       function get_signed_immediate: TXEDInt32;
       function get_unsigned_immediate: TXEDUnsignedInt64;
       function get_second_immediate : TXEDUnsignedInt8;
       // modification
       procedure set_scale(scale: xed_uint_t);
       procedure set_memory_displacement(disp: TXEDInt64; length_bytes: xed_uint_t );
       procedure set_branch_displacement(disp: TXEDInt32; length_bytes: xed_uint_t );
       procedure set_immediate_signed(x: TXEDInt32; length_bytes: xed_uint_t );
       procedure set_immediate_unsigned(x: TXEDUnsignedInt64; length_bytes: xed_uint_t );
       procedure set_memory_displacement_bits(disp: TXEDInt64; length_bits: xed_uint_t);
       procedure set_branch_displacement_bits(disp: TXEDInt32; length_bits: xed_uint_t);
       procedure set_immediate_signed_bits(x: TXEDInt32; length_bits: xed_uint_t);
       procedure set_immediate_unsigned_bits(x: TXEDUnsignedInt64; length_bits: xed_uint_t);
       // encoder
       procedure init_from_decode;
       procedure set_iclass(iclass: TXED_iClass_Enum);
       procedure set_operand_order(i: xed_uint_t; name: TXED_Operand_Enum);
       procedure set_uimm0(uimm: TXEDUnsignedInt64; nbytes: xed_uint_t);
       procedure encode;
       // flags
       function uses_rflags: xed_bool_t;
       function get_read_flag_set: TXED_Flag_SetPtr;
       function get_written_flag_set: TXED_Flag_SetPtr;
       // my Function
       procedure   decode(buf: pbyte; length: uint32; mmode : TXEDMachineMode; stack_addr_width: TXEDAddressWidth = XED_ADDRESS_WIDTH_32b);
       function    get_addr: uint64;
       function    get_operand(i: Cardinal): x86_operand ;
       function    get_operands: TArray<x86_operand>;
       function    get_bytes: TArray<TXEDUnsignedInt8>;
       procedure   get_read_written_registers(var read_registers: TArray<x86_register>; var written_registers:TArray<x86_register>);
       function    get_read_registers: TArray<x86_register>;
	     function    get_written_registers: TArray<x86_register>;

       // additional
       function    is_branch: Boolean;
       // debug functions
	     function  get_string: string;
	     procedure sprintf(buf: PAnsiChar; length: Integer) ;
	     function  ToStr: string;

       class operator implicit(i: x86_instruction ):  TXEDDecodedInstruction;
  end;

implementation

{ x86_Operand }

class operator x86_Operand.Explicit(op: TXED_Operand ): x86_Operand ;
begin
    Result     := default(x86_Operand) ;
    Result.FOp := op ;
end;

class operator x86_Operand.implicit(i: x86_Operand): TXED_Operand;
begin
    Result := i.FOp ;
end;

class operator x86_Operand.implicit(op: TXED_Operand): x86_Operand;
begin
    Result     := default(x86_Operand) ;
    Result.FOp := op
end;

function x86_Operand.get_name: TXED_Operand_Enum;
begin
    Result :=  xed_operand_name(@FOp);
end;

function x86_Operand.get_nonterminal_name: TXED_Nonterminal_Enum;
begin
     Result :=  xed_operand_nonterminal_name(@FOp);
end;

function x86_Operand.get_reg: TXED_Reg_Enum;
begin
    Result := xed_operand_reg(@FOp);
end;

function x86_Operand.get_rw: TXED_Operand_Action_Enum;
begin
    Result := xed_operand_rw(@FOp);
end;

function x86_Operand.get_type: TXED_Operand_Type_Enum;
begin
    Result :=  xed_operand_type(@FOp);
end;

function x86_Operand.get_visibility: TXED_Operand_Visibility_Enum;
begin
    Result :=  xed_operand_operand_visibility(@FOp);
end;

function x86_Operand.get_width: TXED_Operand_Width_Enum;
begin
    Result :=  xed_operand_width(@FOp);
end;

function x86_Operand.get_width_bits(osz: TXEDUnsignedInt32): TXEDUnsignedInt32;
begin
    Result := xed_operand_width_bits(@FOp, osz);
end;

function x86_Operand.get_xtype: TXED_Operand_Element_Xtype_Enum;
begin
    Result :=  xed_operand_xtype(@FOp);
end;

function x86_Operand.imm: TXEDUnsignedInt32;
begin
    Result := xed_operand_imm(@FOp);
end;

function x86_Operand.is_branch: Boolean;
begin
    Result := get_name = XED_OPERAND_RELBR;
end;

function x86_Operand.is_conditional_read: Boolean;
begin
    Result := xed_operand_conditional_read(@FOp) <> 0;
end;

function x86_Operand.is_conditional_written: Boolean;
begin
    Result := xed_operand_conditional_write(@FOp) <> 0;
end;

function x86_Operand.is_immediate: Boolean;
begin
    Result := (get_name = XED_OPERAND_IMM0) or (get_name = XED_OPERAND_IMM1);
end;

function x86_Operand.is_memory: Boolean;
begin
    Result := (get_name = XED_OPERAND_MEM0) or (get_name = XED_OPERAND_MEM1);
end;

function x86_Operand.is_memory_addressing_register(name: TXED_Operand_Enum): Boolean;
begin
    Result := xed_operand_is_memory_addressing_register(name);
end;

function x86_Operand.is_read: Boolean;
begin
    Result :=  xed_operand_read(@FOp) <> 0;
end;

function x86_Operand.is_read_only: Boolean;
begin
    Result := xed_operand_read_only(@FOp) <> 0;
end;

function x86_Operand.is_read_written: Boolean;
begin
    Result :=  xed_operand_read_and_written(@FOp) <> 0;
end;

function x86_Operand.is_register(name: TXED_Operand_Enum): Boolean;
begin
    Result := xed_operand_is_register(name);
end;

function x86_Operand.is_register: Boolean;
begin
    Result := is_register(get_name);
end;

function x86_Operand.is_written: Boolean;
begin
    Result :=  xed_operand_written(@FOp) <> 0;
end;

function x86_Operand.is_written_only: Boolean;
begin
    Result :=  xed_operand_written_only(@FOp) <> 0;
end;

procedure x86_Operand.print(buf: PAnsiChar; buflen: Integer);
begin
    xed_operand_print(@FOp, buf, buflen);
end;

function x86_Operand.template_is_register: Boolean;
begin
    Result :=  xed_operand_template_is_register(@FOp);
end;

{ x86_register }
class operator x86_register.Equal(reg, reg1: x86_register): Boolean;
begin
    Result := reg.FXED_Reg = reg1.FXED_Reg;
end;

class operator x86_register.Equal(reg: TXED_Reg_Enum; reg1: x86_register): Boolean;
begin
    Result := reg = reg1.FXED_Reg;
end;

class operator x86_register.NotEqual(reg, reg1: x86_register): Boolean;
begin
     Result := reg.FXED_Reg <> reg1.FXED_Reg;
end;

class operator x86_register.NotEqual(reg: TXED_Reg_Enum; reg1: x86_register): Boolean;
begin
     Result := reg <> reg1.FXED_Reg;
end;

class operator x86_register.LessThan(reg, reg1: x86_register): Boolean;
begin
    Result := reg.FXED_Reg < reg1.FXED_Reg;
end;

class operator x86_register.implicit(reg: TXED_Reg_Enum): x86_register;
begin
    Result := default(x86_register);
    Result.FXED_Reg :=  reg;
end;

function x86_register.is_flag: Boolean;
begin
    Result := (XED_REG_FLAGS_FIRST <= FXED_Reg) and (FXED_Reg <= XED_REG_FLAGS_LAST);
end;

function x86_register.is_pseudo: Boolean;
begin
    Result :=  ((XED_REG_PSEUDO_FIRST <= FXED_Reg) and (FXED_Reg <= XED_REG_PSEUDO_LAST)) or (xed_reg_enum_t_last <= FXED_Reg);
end;

function x86_register.is_valid: Boolean;
begin
    Result := FXED_Reg <> XED_REG_INVALID;
end;

function x86_register.get_name: PAnsiChar;
begin
    Result := xed_reg_enum_t2str(FXED_Reg);
end;

function x86_register.get_class: TXED_Reg_Class_enum;
begin
    Result := xed_reg_class(FXED_Reg);
end;

function x86_register.get_class_name: PAnsiChar;
begin
    Result :=  xed_reg_class_enum_t2str(get_class);
end;

function x86_register.get_gpr_class: TXED_Reg_Class_enum;
begin
    Result := xed_gpr_reg_class(FXED_Reg);
end;

function x86_register.get_largest_enclosing_register32: x86_register;
begin
    Result := xed_get_largest_enclosing_register32(FXED_Reg);
end;

function x86_register.get_largest_enclosing_register: x86_register;
begin
    Result := xed_get_largest_enclosing_register(FXED_Reg);
end;

function x86_register.get_width_bits :TXEDUnsignedInt32;
begin
    Result := xed_get_register_width_bits(FXED_Reg);
end;

function x86_register.get_width_bits64:TXEDUnsignedInt32;
begin
    Result := xed_get_register_width_bits64(FXED_Reg);
end;

function x86_register.is_gpr: Boolean;
begin
    Result := get_class = XED_REG_CLASS_GPR;
end;

function x86_register.is_low_gpr: Boolean;
begin
    case  FXED_Reg of
      XED_REG_AL,
		  XED_REG_CL,
		  XED_REG_DL,
		  XED_REG_BL,
		  XED_REG_SPL,
		  XED_REG_BPL,
		  XED_REG_SIL,
		  XED_REG_DIL: Result := True;
      XED_REG_AH,
		  XED_REG_CH,
		  XED_REG_DH,
		  XED_REG_BH:  Result := False;
      else
       raise Exception.Create('Error in is_low_gpr()');
    end;
end;
function x86_register.is_high_gpr: Boolean;
begin
    case  FXED_Reg of
      XED_REG_AL,
		  XED_REG_CL,
		  XED_REG_DL,
		  XED_REG_BL,
		  XED_REG_SPL,
		  XED_REG_BPL,
		  XED_REG_SIL,
		  XED_REG_DIL: Result := False;
      XED_REG_AH,
		  XED_REG_CH,
		  XED_REG_DH,
		  XED_REG_BH:  Result := True;
      else
       raise Exception.Create('Error in is_low_gpr()');
    end;
end;

function x86_register.get_gpr8_low: x86_register;
begin
   case  FXED_Reg of
     XED_REG_AL,
		 XED_REG_AH,
		 XED_REG_AX,
		 XED_REG_EAX,
		 XED_REG_RAX :  Result := XED_REG_AL;
		 XED_REG_CL,
		 XED_REG_CH,
		 XED_REG_CX,
		 XED_REG_ECX,
		 XED_REG_RCX: Result := XED_REG_CL;
		 XED_REG_DL,
		 XED_REG_DH,
		 XED_REG_DX,
		 XED_REG_EDX,
		 XED_REG_RDX: Result := XED_REG_DL;
		 XED_REG_BL,
		 XED_REG_BH,
		 XED_REG_BX,
		 XED_REG_EBX,
		 XED_REG_RBX: Result := XED_REG_BL;
		 XED_REG_SPL,
		 XED_REG_SP,
		 XED_REG_ESP,
		 XED_REG_RSP: Result := XED_REG_SPL;
		 XED_REG_BPL,
		 XED_REG_BP,
		 XED_REG_EBP,
		 XED_REG_RBP: Result := XED_REG_BPL;
		 XED_REG_SIL,
		 XED_REG_SI,
		 XED_REG_ESI,
		 XED_REG_RSI: Result := XED_REG_SIL;
		 XED_REG_DIL,
		 XED_REG_DI,
		 XED_REG_EDI,
		 XED_REG_RDI: Result := XED_REG_DIL;
		 XED_REG_R8B,
		 XED_REG_R8W,
		 XED_REG_R8D,
		 XED_REG_R8: Result := XED_REG_R8B;
		 XED_REG_R9B,
		 XED_REG_R9W,
		 XED_REG_R9D,
		 XED_REG_R9: Result := XED_REG_R9B;
		 XED_REG_R10B,
		 XED_REG_R10W,
		 XED_REG_R10D,
		 XED_REG_R10: Result := XED_REG_R10B;
		 XED_REG_R11B,
		 XED_REG_R11W,
		 XED_REG_R11D,
		 XED_REG_R11: Result := XED_REG_R11B;
		 XED_REG_R12B,
		 XED_REG_R12W,
		 XED_REG_R12D,
		 XED_REG_R12: Result := XED_REG_R12B;
		 XED_REG_R13B,
		 XED_REG_R13W,
		 XED_REG_R13D,
		 XED_REG_R13: Result := XED_REG_R13B;
		 XED_REG_R14B,
		 XED_REG_R14W,
		 XED_REG_R14D,
		 XED_REG_R14: Result := XED_REG_R14B;
		 XED_REG_R15B,
		 XED_REG_R15W,
		 XED_REG_R15D,
		 XED_REG_R15: Result := XED_REG_R15B;
		else
		  raise Exception.Create('Error in get_gpr8_low() : '+ get_name);
   end;
end;

function x86_register.get_gpr8_high: x86_register;
begin
   case  FXED_Reg of
     XED_REG_AL,
		 XED_REG_AH,
		 XED_REG_AX,
		 XED_REG_EAX,
		 XED_REG_RAX :  Result := XED_REG_AH;
		 XED_REG_CL,
		 XED_REG_CH,
		 XED_REG_CX,
		 XED_REG_ECX,
		 XED_REG_RCX: Result := XED_REG_CH;
		 XED_REG_DL,
		 XED_REG_DH,
		 XED_REG_DX,
		 XED_REG_EDX,
		 XED_REG_RDX: Result := XED_REG_DH;
		 XED_REG_BL,
		 XED_REG_BH,
		 XED_REG_BX,
		 XED_REG_EBX,
		 XED_REG_RBX: Result := XED_REG_BH;
		 XED_REG_SPL,
		 XED_REG_SP,
		 XED_REG_ESP,
		 XED_REG_RSP: Result := XED_REG_INVALID;
		 XED_REG_BPL,
		 XED_REG_BP,
		 XED_REG_EBP,
		 XED_REG_RBP: Result := XED_REG_INVALID;
		 XED_REG_SIL,
		 XED_REG_SI,
		 XED_REG_ESI,
		 XED_REG_RSI: Result := XED_REG_INVALID;
		 XED_REG_DIL,
		 XED_REG_DI,
		 XED_REG_EDI,
		 XED_REG_RDI: Result := XED_REG_INVALID;
		 XED_REG_R8B,
		 XED_REG_R8W,
		 XED_REG_R8D,
		 XED_REG_R8: Result := XED_REG_INVALID;
		 XED_REG_R9B,
		 XED_REG_R9W,
		 XED_REG_R9D,
		 XED_REG_R9: Result := XED_REG_INVALID;
		 XED_REG_R10B,
		 XED_REG_R10W,
		 XED_REG_R10D,
		 XED_REG_R10: Result := XED_REG_INVALID;
		 XED_REG_R11B,
		 XED_REG_R11W,
		 XED_REG_R11D,
		 XED_REG_R11: Result := XED_REG_INVALID;
		 XED_REG_R12B,
		 XED_REG_R12W,
		 XED_REG_R12D,
		 XED_REG_R12: Result := XED_REG_INVALID;
		 XED_REG_R13B,
		 XED_REG_R13W,
		 XED_REG_R13D,
		 XED_REG_R13: Result := XED_REG_INVALID;
		 XED_REG_R14B,
		 XED_REG_R14W,
		 XED_REG_R14D,
		 XED_REG_R14: Result := XED_REG_INVALID;
		 XED_REG_R15B,
		 XED_REG_R15W,
		 XED_REG_R15D,
		 XED_REG_R15: Result := XED_REG_INVALID;
		else
		  raise Exception.Create('Error in get_gpr8_high()');
   end;
end;

function x86_register.get_gpr16: x86_register;
begin
   case  FXED_Reg of
     XED_REG_AL,
		 XED_REG_AH,
		 XED_REG_AX,
		 XED_REG_EAX,
		 XED_REG_RAX :  Result := XED_REG_AX;
		 XED_REG_CL,
		 XED_REG_CH,
		 XED_REG_CX,
		 XED_REG_ECX,
		 XED_REG_RCX: Result := XED_REG_CX;
		 XED_REG_DL,
		 XED_REG_DH,
		 XED_REG_DX,
		 XED_REG_EDX,
		 XED_REG_RDX: Result := XED_REG_DX;
		 XED_REG_BL,
		 XED_REG_BH,
		 XED_REG_BX,
		 XED_REG_EBX,
		 XED_REG_RBX: Result := XED_REG_BX;
		 XED_REG_SPL,
		 XED_REG_SP,
		 XED_REG_ESP,
		 XED_REG_RSP: Result := XED_REG_SP;
		 XED_REG_BPL,
		 XED_REG_BP,
		 XED_REG_EBP,
		 XED_REG_RBP: Result := XED_REG_BP;
		 XED_REG_SIL,
		 XED_REG_SI,
		 XED_REG_ESI,
		 XED_REG_RSI: Result := XED_REG_SI;
		 XED_REG_DIL,
		 XED_REG_DI,
		 XED_REG_EDI,
		 XED_REG_RDI: Result := XED_REG_DI;
		 XED_REG_R8B,
		 XED_REG_R8W,
		 XED_REG_R8D,
		 XED_REG_R8: Result := XED_REG_R8W;
		 XED_REG_R9B,
		 XED_REG_R9W,
		 XED_REG_R9D,
		 XED_REG_R9: Result := XED_REG_R9W;
		 XED_REG_R10B,
		 XED_REG_R10W,
		 XED_REG_R10D,
		 XED_REG_R10: Result := XED_REG_R10W;
		 XED_REG_R11B,
		 XED_REG_R11W,
		 XED_REG_R11D,
		 XED_REG_R11: Result := XED_REG_R11W;
		 XED_REG_R12B,
		 XED_REG_R12W,
		 XED_REG_R12D,
		 XED_REG_R12: Result := XED_REG_R12W;
		 XED_REG_R13B,
		 XED_REG_R13W,
		 XED_REG_R13D,
		 XED_REG_R13: Result := XED_REG_R13W;
		 XED_REG_R14B,
		 XED_REG_R14W,
		 XED_REG_R14D,
		 XED_REG_R14: Result := XED_REG_R14W;
		 XED_REG_R15B,
		 XED_REG_R15W,
		 XED_REG_R15D,
		 XED_REG_R15: Result := XED_REG_R15W;
		else
		  raise Exception.Create('Error in get_gpr16()');
   end;
end;

function x86_register.get_gpr32: x86_register;
begin
   case  FXED_Reg of
     XED_REG_AL,
		 XED_REG_AH,
		 XED_REG_AX,
		 XED_REG_EAX,
		 XED_REG_RAX :  Result := XED_REG_EAX;
		 XED_REG_CL,
		 XED_REG_CH,
		 XED_REG_CX,
		 XED_REG_ECX,
		 XED_REG_RCX: Result := XED_REG_ECX;
		 XED_REG_DL,
		 XED_REG_DH,
		 XED_REG_DX,
		 XED_REG_EDX,
		 XED_REG_RDX: Result := XED_REG_EDX;
		 XED_REG_BL,
		 XED_REG_BH,
		 XED_REG_BX,
		 XED_REG_EBX,
		 XED_REG_RBX: Result := XED_REG_EBX;
		 XED_REG_SPL,
		 XED_REG_SP,
		 XED_REG_ESP,
		 XED_REG_RSP: Result := XED_REG_ESP;
		 XED_REG_BPL,
		 XED_REG_BP,
		 XED_REG_EBP,
		 XED_REG_RBP: Result := XED_REG_EBP;
		 XED_REG_SIL,
		 XED_REG_SI,
		 XED_REG_ESI,
		 XED_REG_RSI: Result := XED_REG_ESI;
		 XED_REG_DIL,
		 XED_REG_DI,
		 XED_REG_EDI,
		 XED_REG_RDI: Result := XED_REG_EDI;
		 XED_REG_R8B,
		 XED_REG_R8W,
		 XED_REG_R8D,
		 XED_REG_R8: Result := XED_REG_R8D;
		 XED_REG_R9B,
		 XED_REG_R9W,
		 XED_REG_R9D,
		 XED_REG_R9: Result := XED_REG_R9D;
		 XED_REG_R10B,
		 XED_REG_R10W,
		 XED_REG_R10D,
		 XED_REG_R10: Result := XED_REG_R10D;
		 XED_REG_R11B,
		 XED_REG_R11W,
		 XED_REG_R11D,
		 XED_REG_R11: Result := XED_REG_R11D;
		 XED_REG_R12B,
		 XED_REG_R12W,
		 XED_REG_R12D,
		 XED_REG_R12: Result := XED_REG_R12D;
		 XED_REG_R13B,
		 XED_REG_R13W,
		 XED_REG_R13D,
		 XED_REG_R13: Result := XED_REG_R13D;
		 XED_REG_R14B,
		 XED_REG_R14W,
		 XED_REG_R14D,
		 XED_REG_R14: Result := XED_REG_R14D;
		 XED_REG_R15B,
		 XED_REG_R15W,
		 XED_REG_R15D,
		 XED_REG_R15: Result := XED_REG_R15D;
		else
		  raise Exception.Create('Error in get_gpr32()');
   end;
end;

function x86_register.get_gpr64: x86_register;
begin
   case  FXED_Reg of
     XED_REG_AL,
		 XED_REG_AH,
		 XED_REG_AX,
		 XED_REG_EAX,
		 XED_REG_RAX :  Result := XED_REG_RAX;
		 XED_REG_CL,
		 XED_REG_CH,
		 XED_REG_CX,
		 XED_REG_ECX,
		 XED_REG_RCX: Result := XED_REG_RCX;
		 XED_REG_DL,
		 XED_REG_DH,
		 XED_REG_DX,
		 XED_REG_EDX,
		 XED_REG_RDX: Result := XED_REG_RDX;
		 XED_REG_BL,
		 XED_REG_BH,
		 XED_REG_BX,
		 XED_REG_EBX,
		 XED_REG_RBX: Result := XED_REG_RBX;
		 XED_REG_SPL,
		 XED_REG_SP,
		 XED_REG_ESP,
		 XED_REG_RSP: Result := XED_REG_RSP;
		 XED_REG_BPL,
		 XED_REG_BP,
		 XED_REG_EBP,
		 XED_REG_RBP: Result := XED_REG_RBP;
		 XED_REG_SIL,
		 XED_REG_SI,
		 XED_REG_ESI,
		 XED_REG_RSI: Result := XED_REG_RSI;
		 XED_REG_DIL,
		 XED_REG_DI,
		 XED_REG_EDI,
		 XED_REG_RDI: Result := XED_REG_RDI;
		 XED_REG_R8B,
		 XED_REG_R8W,
		 XED_REG_R8D,
		 XED_REG_R8: Result := XED_REG_R8;
		 XED_REG_R9B,
		 XED_REG_R9W,
		 XED_REG_R9D,
		 XED_REG_R9: Result := XED_REG_R9;
		 XED_REG_R10B,
		 XED_REG_R10W,
		 XED_REG_R10D,
		 XED_REG_R10: Result := XED_REG_R10;
		 XED_REG_R11B,
		 XED_REG_R11W,
		 XED_REG_R11D,
		 XED_REG_R11: Result := XED_REG_R11;
		 XED_REG_R12B,
		 XED_REG_R12W,
		 XED_REG_R12D,
		 XED_REG_R12: Result := XED_REG_R12;
		 XED_REG_R13B,
		 XED_REG_R13W,
		 XED_REG_R13D,
		 XED_REG_R13: Result := XED_REG_R13;
		 XED_REG_R14B,
		 XED_REG_R14W,
		 XED_REG_R14D,
		 XED_REG_R14: Result := XED_REG_R14;
		 XED_REG_R15B,
		 XED_REG_R15W,
		 XED_REG_R15D,
		 XED_REG_R15: Result := XED_REG_R15;
		else
		  raise Exception.Create('Error in get_gpr64()');
   end;
end;

{ x86_instruction }

constructor x86_instruction.Create(addr: UInt64);
begin
    FAddr    := addr;
    FDecInst := default(TXEDDecodedInstruction);
    SetLength(FBytes,16);
end;

procedure x86_instruction.decode(buf: pbyte; length: uint32; mmode: TXEDMachineMode; stack_addr_width: TXEDAddressWidth);
var
  xedd      : TXEDDecodedInstructionPtr;
  xed_error : TXEDErrorEnum;

begin
    xedd := @FDecInst;
    // initialize for xed_decode
	  xed_decoded_inst_zero(xedd);
	  xed_decoded_inst_set_mode(xedd, mmode, stack_addr_width);

    // decode array of bytes to xed_decoded_inst_t
    CopyMemory(@FBytes[0],buf,length) ;
	  xed_error := xed_decode(xedd, @FBytes[0], length);
    FInst := AnsiString(get_string);

    case xed_error of
      XED_ERROR_NONE: Exit;
      else
        raise Exception.Create('xed_decode failed at Address: '+ IntToHex(FAddr));
    end;
end;

function x86_instruction.get_category: TXED_Category_Enum;
begin
    Result := xed_decoded_inst_get_category(@FDecInst);
end;

function x86_instruction.get_extension: TXED_Extension_Enum;
begin
    Result := xed_decoded_inst_get_extension(@FDecInst);
end;

function x86_instruction.get_iclass: TXED_iClass_Enum;
begin
    Result := xed_decoded_inst_get_iclass(@FDecInst);
end;

function x86_instruction.get_isa_set: TXEDIsaSetEnum;
begin
    Result := xed_decoded_inst_get_isa_set(@FDecInst);
end;

function x86_instruction.get_machine_mode_bits: Cardinal;
begin
    Result := xed_decoded_inst_get_machine_mode_bits(@FDecInst);
end;

function x86_instruction.get_name: PAnsiChar;
begin
    Result := xed_iclass_enum_t2str(get_iclass);
end;

function x86_instruction.get_operand(i: Cardinal): x86_operand;
var
  xi : TXEDInstructionPtr;
begin
    xi := xed_decoded_inst_inst(@FDecInst);
    var p := xed_inst_operand(xi, i);
	  Result := x86_operand( p^ );
end;

function x86_instruction.get_operands: TArray<x86_operand>;
var
  operands   : TArray<x86_operand>;
  xi         : TXEDInstructionPtr;
  operand    : x86_operand;
  noperands,i: Cardinal;
begin
    xi        := xed_decoded_inst_inst(@FDecInst);
    noperands := xed_inst_noperands(xi);
    for i := 0 to noperands - 1 do
    begin
      if noperands = 0 then Break;

      var p := xed_inst_operand(xi, i);
      operand := x86_operand(p^ );
      operands := operands + [ operand];
    end;
    Result := operands;
end;


function x86_instruction.get_length: xed_uint_t;
begin
    Result := xed_decoded_inst_get_length(@FDecInst);
end;
function x86_instruction.get_addr: uint64;
begin
    Result := FAddr;
end;

function x86_instruction.get_byte(byte_index: xed_uint_t): xed_uint_t;
begin
    Result := xed_decoded_inst_get_byte(@FDecInst, byte_index);
end;
function x86_instruction.get_bytes: TArray<TXEDUnsignedInt8>;
var
 bytes : TArray<TXEDUnsignedInt8>;
 len,i : xed_uint_t;
begin
    len := get_length;
	  for i := 0 to len - 1 do
       bytes := bytes + [ get_byte(i) ];
	Result := bytes;
end;

function x86_instruction.get_operand_length_bits(operand_index: xed_uint_t): xed_uint_t;
begin
    Result := xed_decoded_inst_operand_length_bits(@FDecInst, operand_index);
end;
function x86_instruction.get_iform_enum: TXED_iform_Enum;
begin
   Result := xed_decoded_inst_get_iform_enum(@FDecInst);
end;

function x86_instruction.operands_const: TXEDOperandValuesPtr;
begin
    Result :=  xed_decoded_inst_operands_const(@FDecInst);
end;
procedure x86_instruction.get_read_written_registers(var read_registers, written_registers: TArray<x86_register>);
var
  operands : TArray<x86_operand>;
  operand  : x86_operand;
begin
    operands := get_operands;
	  for operand in  operands do
    begin
        var targetReg  : x86_register;
        var hasRead    : Boolean ;
        var hasWritten : Boolean ;
        if operand.is_register then
        begin
          // Operand is register
          targetReg  := get_register(operand.get_name);
          hasRead    := operand.is_read;
          hasWritten := operand.is_written;
        end
        else if operand.is_memory then
        begin
          // Ignore memory
          continue;
        end
        else if operand.is_immediate then
        begin
          // Ignore immediate
          continue;
        end
        else if (operand.get_name = XED_OPERAND_BASE0) or (operand.get_name = XED_OPERAND_BASE1) then
        begin
          // BASE?
          targetReg  := get_register(operand.get_name);
          hasRead    := operand.is_read;
          hasWritten := operand.is_written;
          // printf("\t\t%p BASE0/BASE1 %s R:%d W:%d\n", addr, access_register.get_name(), read, write);
        end
        else if operand.is_branch then
        begin
          // Ignore branch
          continue;
        end
        else if operand.get_name = XED_OPERAND_AGEN then
        begin
          // Ignore agen
          continue;
        end else
        begin
            raise Exception.Create('get_read_written_registers  operand name: '+ xed_operand_enum_t2str(operand.get_name));
        end;
        if not targetReg.is_pseudo and targetReg.is_valid then
        begin
          if (hasRead) then
            read_registers :=  read_registers + [ targetReg ];
          if hasWritten then
            written_registers := written_registers + [ targetReg ];
        end
    end;
end;

function x86_instruction.get_register(name: TXED_Operand_Enum = XED_OPERAND_REG0): x86_register;
begin
    Result :=  xed_decoded_inst_get_reg(@FDecInst, name);
end;

function x86_instruction.get_read_registers: TArray<x86_register>;
var
  readRegs, writtenRegs : TArray<x86_register>  ;
begin
    get_read_written_registers(readRegs, writtenRegs);
	  Result := readRegs;
end;

function x86_instruction.get_number_of_memory_operands: xed_uint_t;
begin
    Result := xed_decoded_inst_number_of_memory_operands(@FDecInst);
end;

function x86_instruction.is_mem_read(mem_idx: Cardinal = 0): Boolean;
begin
    Result := xed_decoded_inst_mem_read(@FDecInst, mem_idx) <> 0;
end;

function x86_instruction.is_mem_written(mem_idx: Cardinal = 0): Boolean;
begin
    Result := xed_decoded_inst_mem_written(@FDecInst, mem_idx) <> 0;
end;

function x86_instruction.is_mem_written_only(mem_idx: Cardinal = 0): Boolean;
begin
    Result := False;
    if xed_decoded_inst_mem_written_only(@FDecInst, mem_idx) <> 0 then
      Result := True;
end;

function x86_instruction.get_segment_register(mem_idx : Cardinal = 0): x86_register;
begin
    Result := xed_decoded_inst_get_seg_reg(@FDecInst, mem_idx);
end;

function x86_instruction.get_base_register(mem_idx: Cardinal = 0): x86_register;
begin
    Result := xed_decoded_inst_get_base_reg(@FDecInst, mem_idx);
end;

function x86_instruction.get_index_register(mem_idx: Cardinal = 0): x86_register;
begin
    Result := xed_decoded_inst_get_index_reg(@FDecInst, mem_idx);
end;

function x86_instruction.get_scale(mem_idx: Cardinal = 0):xed_uint_t;
begin
    Result :=  xed_decoded_inst_get_scale(@FDecInst, mem_idx);
end;

function x86_instruction.has_displacement: xed_uint_t;
begin
    Result :=  xed_operand_values_has_memory_displacement(@FDecInst);
end;

function x86_instruction.get_memory_displacement(mem_idx: Cardinal = 0): TXEDUnsignedInt64;
begin
    Result :=  xed_decoded_inst_get_memory_displacement(@FDecInst, mem_idx);
end;

function x86_instruction.get_memory_displacement_width(mem_idx : Cardinal= 0): xed_uint_t;
begin
    Result :=  xed_decoded_inst_get_memory_displacement_width(@FDecInst, mem_idx);
end;

function x86_instruction.get_memory_displacement_width_bits(mem_idx: Cardinal = 0): xed_uint_t;
begin
    Result :=  xed_decoded_inst_get_memory_displacement_width_bits(@FDecInst, mem_idx);
end;

function x86_instruction.get_memory_operand_length(mem_idx: Cardinal = 0): xed_uint_t;
begin
    Result :=  xed_decoded_inst_get_memory_operand_length(@FDecInst, mem_idx);
end;

function x86_instruction.get_branch_displacement: TXEDInt32;
begin
    Result := xed_decoded_inst_get_branch_displacement(@FDecInst);
end;

function x86_instruction.get_branch_displacement_width: xed_uint_t;
begin
    Result := xed_decoded_inst_get_branch_displacement_width(@FDecInst);
end;

function x86_instruction.get_branch_displacement_width_bits: xed_uint_t;
begin
    Result := xed_decoded_inst_get_branch_displacement_width_bits(@FDecInst);
end;

function x86_instruction.get_immediate_width: xed_uint_t ;
begin
    Result := xed_decoded_inst_get_immediate_width(@FDecInst);
end;

function x86_instruction.get_immediate_width_bits: xed_uint_t ;
begin
    Result := xed_decoded_inst_get_immediate_width_bits(@FDecInst);
end;

function x86_instruction.get_immediate_is_signed: Boolean;
begin
    // Return true if the first immediate (IMM0) is signed.
		Result := xed_decoded_inst_get_immediate_is_signed(@FDecInst) = 1;
end;

function x86_instruction.get_signed_immediate: TXEDInt32;
begin
    Result := xed_decoded_inst_get_signed_immediate(@FDecInst);
end;

function x86_instruction.get_unsigned_immediate: TXEDUnsignedInt64;
begin
    if get_signed_immediate = 0 then
			Exit( xed_decoded_inst_get_unsigned_immediate(@FDecInst) );
		Result :=  xed_sign_extend_arbitrary_to_64( xed_decoded_inst_get_signed_immediate(@FDecInst), get_immediate_width_bits);
end;

function x86_instruction.get_second_immediate : TXEDUnsignedInt8;
begin
    Result := xed_decoded_inst_get_second_immediate(@FDecInst);
end;

procedure x86_instruction.set_scale(scale: xed_uint_t);
begin
    xed_decoded_inst_set_scale(@FDecInst, scale);
end;

procedure x86_instruction.set_memory_displacement(disp: TXEDInt64; length_bytes: xed_uint_t );
begin
    xed_decoded_inst_set_memory_displacement(@FDecInst, disp, length_bytes);
end;

procedure x86_instruction.set_branch_displacement(disp: TXEDInt32; length_bytes: xed_uint_t );
begin
    xed_decoded_inst_set_branch_displacement(@FDecInst, disp, length_bytes);
end;

procedure x86_instruction.set_immediate_signed(x: TXEDInt32; length_bytes: xed_uint_t );
begin
    xed_decoded_inst_set_immediate_signed(@FDecInst, x, length_bytes);
end;

procedure x86_instruction.set_immediate_unsigned(x: TXEDUnsignedInt64; length_bytes: xed_uint_t );
begin
   xed_decoded_inst_set_immediate_unsigned(@FDecInst, x, length_bytes);
end;

procedure x86_instruction.set_memory_displacement_bits(disp: TXEDInt64; length_bits: xed_uint_t);
begin
    xed_decoded_inst_set_memory_displacement_bits(@FDecInst, disp, length_bits);
end;

procedure x86_instruction.set_branch_displacement_bits(disp: TXEDInt32; length_bits: xed_uint_t);
begin
   xed_decoded_inst_set_branch_displacement_bits(@FDecInst, disp, length_bits);
end;

procedure x86_instruction.set_immediate_signed_bits(x: TXEDInt32; length_bits: xed_uint_t);
begin
    xed_decoded_inst_set_immediate_signed_bits(@FDecInst, x, length_bits);
end;

procedure x86_instruction.set_immediate_unsigned_bits(x: TXEDUnsignedInt64; length_bits: xed_uint_t);
begin
    xed_decoded_inst_set_immediate_unsigned_bits(@FDecInst, x, length_bits);
end;

procedure x86_instruction.init_from_decode;
begin
    xed_encoder_request_init_from_decode(@FDecInst);
end;

procedure x86_instruction.set_iclass(iclass: TXED_iClass_Enum);
begin
   xed_encoder_request_set_iclass(@FDecInst, iclass);
end;

procedure x86_instruction.set_operand_order(i: xed_uint_t; name: TXED_Operand_Enum);
begin
   xed_encoder_request_set_operand_order(@FDecInst, i, name);
end;

procedure x86_instruction.set_uimm0(uimm: TXEDUnsignedInt64; nbytes: xed_uint_t);
begin
    xed_encoder_request_set_uimm0(@FDecInst, uimm, nbytes);
end;

procedure x86_instruction.encode;
var
  olen : TXEDUnsignedInt32;
  buf  : Array[0..15] of Byte;
begin
    if xed_encode(@FDecInst, @buf[0], 16, @olen) = XED_ERROR_NONE then
      decode(@buf[0], olen, XED_MACHINE_MODE_LEGACY_32);
end;

function x86_instruction.uses_rflags: xed_bool_t;
begin
    Result := xed_decoded_inst_uses_rflags(@FDecInst);
end;

function x86_instruction.get_read_flag_set: TXED_Flag_SetPtr;
var
  rfi : TXED_Simple_FlagPtr;
begin
    rfi    := xed_decoded_inst_get_rflags_info(@FDecInst);
		Result := xed_simple_flag_get_read_flag_set(rfi);
end;

function x86_instruction.get_written_flag_set: TXED_Flag_SetPtr;
var
  rfi : TXED_Simple_FlagPtr;
begin
    rfi    := xed_decoded_inst_get_rflags_info(@FDecInst);
		Result := xed_simple_flag_get_written_flag_set(rfi);
end;

function x86_instruction.get_written_registers: TArray<x86_register>;
var
  readRegs, writtenRegs : TArray<x86_register>  ;
begin
    get_read_written_registers(readRegs, writtenRegs);
   	Result := writtenRegs;
end;

function x86_instruction.ToStr:string;
var
  buf: array[0..63] of AnsiChar;
begin
    sprintf(buf, 64);
    Result := Format('%08x %s',[get_addr,PAnsiChar(@buf[0])]);
end;

procedure x86_instruction.sprintf(buf: PAnsiChar; length: Integer);
begin
   xed_format_context(XED_SYNTAX_INTEL, @FDecInst, buf, length, FAddr, nil, nil);
end;

function x86_instruction.get_string: string;
var
  buf: array[0..63] of AnsiChar;
begin
   sprintf(buf, 64);
	 Result := string( AnsiString( PAnsiChar(@buf[0])) );
end;

class operator x86_instruction.implicit(i: x86_instruction): TXEDDecodedInstruction;
begin
    Result := i.FDecInst;
end;

function x86_instruction.is_branch: Boolean;
begin
    Result := False;

    case get_category of
      XED_CATEGORY_COND_BR,
		  XED_CATEGORY_UNCOND_BR: Result := true;
    end;
end;

end.
