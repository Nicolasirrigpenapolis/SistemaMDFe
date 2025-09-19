import React from 'react';
import {
  TextField,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  FormHelperText,
  Box
} from '@mui/material';

interface Option {
  value: string;
  label: string;
}

interface FormFieldProps {
  label: string;
  type?: 'text' | 'number' | 'email' | 'tel' | 'datetime-local' | 'select' | 'textarea';
  value: string | number;
  onChange: (value: string) => void;
  placeholder?: string;
  required?: boolean;
  disabled?: boolean;
  error?: string;
  help?: string;
  options?: Option[];
  min?: number;
  max?: number;
  step?: number | string;
  maxLength?: number;
  rows?: number;
  className?: string;
  fullWidth?: boolean;
  variant?: 'outlined' | 'filled' | 'standard';
  size?: 'small' | 'medium';
}

export const FormField: React.FC<FormFieldProps> = ({
  label,
  type = 'text',
  value,
  onChange,
  placeholder,
  required = false,
  disabled = false,
  error,
  help,
  options = [],
  min,
  max,
  step,
  maxLength,
  rows = 3,
  fullWidth = true,
  variant = 'outlined',
  size = 'medium'
}) => {
  const hasError = !!error;
  const helperText = error || help;

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement> | any) => {
    onChange(e.target.value);
  };

  if (type === 'select') {
    return (
      <Box sx={{ mb: 2 }}>
        <FormControl
          fullWidth={fullWidth}
          variant={variant}
          size={size}
          error={hasError}
          required={required}
          disabled={disabled}
        >
          <InputLabel>{label}</InputLabel>
          <Select
            value={value || ''}
            label={label}
            onChange={handleChange}
          >
            <MenuItem value="">
              <em>Selecione...</em>
            </MenuItem>
            {options.map((option) => (
              <MenuItem key={option.value} value={option.value}>
                {option.label}
              </MenuItem>
            ))}
          </Select>
          {helperText && (
            <FormHelperText>{helperText}</FormHelperText>
          )}
        </FormControl>
      </Box>
    );
  }

  return (
    <TextField
      label={label}
      type={type}
      value={value || ''}
      onChange={handleChange}
      placeholder={placeholder}
      required={required}
      disabled={disabled}
      error={hasError}
      helperText={helperText}
      fullWidth={fullWidth}
      variant={variant}
      size={size}
      multiline={type === 'textarea'}
      rows={type === 'textarea' ? rows : undefined}
      inputProps={{
        min,
        max,
        step,
        maxLength
      }}
      sx={{ mb: 2 }}
    />
  );
};