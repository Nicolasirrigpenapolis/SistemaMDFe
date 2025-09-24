import React, { useState, useEffect } from 'react';
import {
  Paper,
  Typography,
  Grid,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Autocomplete,
  TextField,
  Box,
  CircularProgress,
  Alert
} from '@mui/material';
import { LocationOn as LocationIcon } from '@mui/icons-material';
import { localidadeService } from '../../../services/localidadeService';

interface Estado {
  sigla: string;
  nome: string;
}

interface Municipio {
  id: number;
  nome: string;
}

interface LocalidadeSelectorProps {
  label: string;
  ufValue: string;
  municipioValue: string;
  onUfChange: (uf: string) => void;
  onMunicipioChange: (municipio: string) => void;
  required?: boolean;
}

export const LocalidadeSelector: React.FC<LocalidadeSelectorProps> = ({
  label,
  ufValue,
  municipioValue,
  onUfChange,
  onMunicipioChange,
  required = false
}) => {
  const [estados, setEstados] = useState<Estado[]>([]);
  const [municipios, setMunicipios] = useState<Municipio[]>([]);
  const [carregandoEstados, setCarregandoEstados] = useState(false);
  const [carregandoMunicipios, setCarregandoMunicipios] = useState(false);
  const [erro, setErro] = useState<string | null>(null);

  // Carregar estados do banco de dados
  useEffect(() => {
    const carregarEstados = async () => {
      setCarregandoEstados(true);
      setErro(null);

      try {
        const estadosData = await localidadeService.obterEstados();
        if (estadosData && estadosData.length > 0) {
          setEstados(estadosData);
        }
      } catch (err) {
        setErro('Erro ao carregar estados');
        console.error('Erro ao carregar estados:', err);
      } finally {
        setCarregandoEstados(false);
      }
    };

    carregarEstados();
  }, []);

  // Carregar municípios do banco quando UF muda
  useEffect(() => {
    const carregarMunicipios = async () => {
      if (ufValue && ufValue.length === 2) {
        setCarregandoMunicipios(true);
        setErro(null);

        try {
          const municipiosData = await localidadeService.obterMunicipiosPorEstado(ufValue);
          if (municipiosData && municipiosData.length > 0) {
            const municipiosMapeados = municipiosData.map((m: any) => ({
              id: m.id,
              nome: m.nome
            }));
            setMunicipios(municipiosMapeados);
          } else {
            setMunicipios([]);
          }
        } catch (err) {
          setErro('Erro ao carregar municípios');
          setMunicipios([]);
          console.error('Erro ao carregar municípios:', err);
        } finally {
          setCarregandoMunicipios(false);
        }
      } else {
        setMunicipios([]);
        onMunicipioChange(''); // Limpar município
      }
    };

    carregarMunicipios();
  }, [ufValue, onMunicipioChange]);

  const handleUfChange = (event: any) => {
    const uf = event.target.value;
    onUfChange(uf);
    onMunicipioChange(''); // Limpar município
  };

  const handleMunicipioChange = (event: any, value: Municipio | null) => {
    onMunicipioChange(value ? value.nome : '');
  };

  const selectedMunicipio = municipios.find(m => m.nome === municipioValue) || null;

  return (
    <Paper
      elevation={2}
      sx={{
        p: 3,
        mb: 2,
        borderRadius: 2,
        border: '1px solid',
        borderColor: 'divider'
      }}
    >
      <Box display="flex" alignItems="center" mb={2}>
        <LocationIcon sx={{ mr: 1, color: 'primary.main' }} />
        <Typography variant="h6" component="h4" color="primary.main">
          {label}
          {required && (
            <Typography component="span" sx={{ color: 'erro.main', ml: 0.5 }}>
              *
            </Typography>
          )}
        </Typography>
      </Box>

      {erro && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {erro}
        </Alert>
      )}

      <Grid container spacing={2}>
        {/* Estado */}
        <Grid size={{ xs: 12, md: 6 }}>
          <FormControl fullWidth required={required}>
            <InputLabel>Estado</InputLabel>
            <Select
              value={ufValue}
              label="Estado"
              onChange={handleUfChange}
              disabled={carregandoEstados}
            >
              <MenuItem value="">
                <em>Selecione o estado</em>
              </MenuItem>
              {estados.map(estado => (
                <MenuItem key={estado.sigla} value={estado.sigla}>
                  {estado.sigla} - {estado.nome}
                </MenuItem>
              ))}
            </Select>
            {carregandoEstados && (
              <Box display="flex" justifyContent="center" mt={1}>
                <CircularProgress size={20} />
              </Box>
            )}
          </FormControl>
        </Grid>

        {/* Município */}
        <Grid size={{ xs: 12, md: 6 }}>
          <Autocomplete
            options={municipios}
            getOptionLabel={(option) => option.nome}
            value={selectedMunicipio}
            onChange={handleMunicipioChange}
            disabled={!ufValue || carregandoMunicipios}
            loading={carregandoMunicipios}
            isOptionEqualToValue={(option, value) => option.id === value.id}
            renderInput={(params) => (
              <TextField
                {...params}
                label="Município"
                required={required}
                placeholder={
                  !ufValue
                    ? 'Primeiro selecione o estado'
                    : 'Digite para buscar...'
                }
                InputProps={{
                  ...params.InputProps,
                  endAdornment: (
                    <>
                      {carregandoMunicipios ? (
                        <CircularProgress color="inherit" size={20} />
                      ) : null}
                      {params.InputProps.endAdornment}
                    </>
                  ),
                }}
              />
            )}
            renderOption={(props, option) => (
              <Box component="li" {...props}>
                <LocationIcon sx={{ mr: 1, fontSize: 16, color: 'text.secondary' }} />
                {option.nome}
              </Box>
            )}
            noOptionsText={
              !ufValue
                ? 'Selecione um estado primeiro'
                : carregandoMunicipios
                ? 'Carregando...'
                : 'Nenhum município encontrado'
            }
          />
        </Grid>
      </Grid>
    </Paper>
  );
};