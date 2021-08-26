unit XED.ExtensionEnum;

{$Z4}
interface

type
  TXED_Extension_Enum = (
        XED_EXTENSION_INVALID,
        XED_EXTENSION_3DNOW,
        XED_EXTENSION_3DNOW_PREFETCH,
        XED_EXTENSION_ADOX_ADCX,
        XED_EXTENSION_AES,
        XED_EXTENSION_AMD_INVLPGB,
        XED_EXTENSION_AMX_BF16,
        XED_EXTENSION_AMX_INT8,
        XED_EXTENSION_AMX_TILE,
        XED_EXTENSION_AVX,
        XED_EXTENSION_AVX2,
        XED_EXTENSION_AVX2GATHER,
        XED_EXTENSION_AVX512EVEX,
        XED_EXTENSION_AVX512VEX,
        XED_EXTENSION_AVXAES,
        XED_EXTENSION_AVX_VNNI,
        XED_EXTENSION_BASE,
        XED_EXTENSION_BMI1,
        XED_EXTENSION_BMI2,
        XED_EXTENSION_CET,
        XED_EXTENSION_CLDEMOTE,
        XED_EXTENSION_CLFLUSHOPT,
        XED_EXTENSION_CLFSH,
        XED_EXTENSION_CLWB,
        XED_EXTENSION_CLZERO,
        XED_EXTENSION_ENQCMD,
        XED_EXTENSION_F16C,
        XED_EXTENSION_FMA,
        XED_EXTENSION_FMA4,
        XED_EXTENSION_GFNI,
        XED_EXTENSION_HRESET,
        XED_EXTENSION_INVPCID,
        XED_EXTENSION_KEYLOCKER,
        XED_EXTENSION_KEYLOCKER_WIDE,
        XED_EXTENSION_LONGMODE,
        XED_EXTENSION_LZCNT,
        XED_EXTENSION_MCOMMIT,
        XED_EXTENSION_MMX,
        XED_EXTENSION_MONITOR,
        XED_EXTENSION_MONITORX,
        XED_EXTENSION_MOVBE,
        XED_EXTENSION_MOVDIR,
        XED_EXTENSION_MPX,
        XED_EXTENSION_PAUSE,
        XED_EXTENSION_PCLMULQDQ,
        XED_EXTENSION_PCONFIG,
        XED_EXTENSION_PKU,
        XED_EXTENSION_PREFETCHWT1,
        XED_EXTENSION_PTWRITE,
        XED_EXTENSION_RDPID,
        XED_EXTENSION_RDPRU,
        XED_EXTENSION_RDRAND,
        XED_EXTENSION_RDSEED,
        XED_EXTENSION_RDTSCP,
        XED_EXTENSION_RDWRFSGS,
        XED_EXTENSION_RTM,
        XED_EXTENSION_SERIALIZE,
        XED_EXTENSION_SGX,
        XED_EXTENSION_SGX_ENCLV,
        XED_EXTENSION_SHA,
        XED_EXTENSION_SMAP,
        XED_EXTENSION_SMX,
        XED_EXTENSION_SNP,
        XED_EXTENSION_SSE,
        XED_EXTENSION_SSE2,
        XED_EXTENSION_SSE3,
        XED_EXTENSION_SSE4,
        XED_EXTENSION_SSE4A,
        XED_EXTENSION_SSSE3,
        XED_EXTENSION_SVM,
        XED_EXTENSION_TBM,
        XED_EXTENSION_TDX,
        XED_EXTENSION_TSX_LDTRK,
        XED_EXTENSION_UINTR,
        XED_EXTENSION_VAES,
        XED_EXTENSION_VIA_PADLOCK_AES,
        XED_EXTENSION_VIA_PADLOCK_MONTMUL,
        XED_EXTENSION_VIA_PADLOCK_RNG,
        XED_EXTENSION_VIA_PADLOCK_SHA,
        XED_EXTENSION_VMFUNC,
        XED_EXTENSION_VPCLMULQDQ,
        XED_EXTENSION_VTX,
        XED_EXTENSION_WAITPKG,
        XED_EXTENSION_WBNOINVD,
        XED_EXTENSION_X87,
        XED_EXTENSION_XOP,
        XED_EXTENSION_XSAVE,
        XED_EXTENSION_XSAVEC,
        XED_EXTENSION_XSAVEOPT,
        XED_EXTENSION_XSAVES,
        XED_EXTENSION_LAST);

/// This converts strings to #xed_extension_enum_t types.
/// @param s A C-string.
/// @return #xed_extension_enum_t
/// @ingroup ENUM
function str2xed_extension_enum_t(s: PAnsiChar): TXED_Extension_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_extension_enum_t types.
/// @param p An enumeration element of type xed_extension_enum_t.
/// @return string
/// @ingroup ENUM
function xed_extension_enum_t2str(const p: TXED_Extension_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_extension_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_extension_enum_t_last:TXED_Extension_Enum;cdecl; external 'xed.dll';

implementation

end.
