import React from 'react';
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  TextField,
  Select,
  MenuItem,
  FormControl,
  IconButton,
  Button,
  Box,
  Typography,
  Alert
} from '@mui/material';
import {
  Add as AddIcon,
  Delete as DeleteIcon,
  Inbox as InboxIcon
} from '@mui/icons-material';

interface Column {
  key: string;
  label: string;
  type: 'text' | 'number' | 'select';
  options?: { value: string; label: string }[];
  placeholder?: string;
  required?: boolean;
  maxLength?: number;
}

interface DataTableProps {
  data: any[];
  columns: Column[];
  onAdd: () => void;
  onRemove: (index: number) => void;
  onChange: (index: number, field: string, value: string) => void;
  addButtonText?: string;
  emptyMessage?: string;
  className?: string;
}

export const DataTable: React.FC<DataTableProps> = ({
  data,
  columns,
  onAdd,
  onRemove,
  onChange,
  addButtonText = 'Adicionar Item',
  emptyMessage = 'Nenhum item adicionado'
}) => {
  const renderCell = (item: any, column: Column, index: number) => {
    const value = item[column.key] || '';

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
      onChange(index, column.key, e.target.value);
    };

    const commonProps = {
      value,
      placeholder: column.placeholder,
      required: column.required,
      size: 'small' as const,
      sx: { minWidth: 120 }
    };

    switch (column.type) {
      case 'select':
        return (
          <FormControl size="small" sx={{ minWidth: 120 }}>
            <Select
              value={value}
              onChange={(e) => onChange(index, column.key, e.target.value as string)}
              displayEmpty
            >
              <MenuItem value="">
                <em>Selecione...</em>
              </MenuItem>
              {column.options?.map((option) => (
                <MenuItem key={option.value} value={option.value}>
                  {option.label}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        );

      case 'number':
        return (
          <TextField
            {...commonProps}
            type="number"
            onChange={handleChange}
            inputProps={{ maxLength: column.maxLength }}
          />
        );

      default:
        return (
          <TextField
            {...commonProps}
            type="text"
            onChange={handleChange}
            inputProps={{ maxLength: column.maxLength }}
          />
        );
    }
  };

  return (
    <Box sx={{ mb: 3 }}>
      <Box sx={{ mb: 2, display: 'flex', justifyContent: 'flex-start' }}>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={onAdd}
          color="primary"
        >
          {addButtonText}
        </Button>
      </Box>

      {data.length === 0 ? (
        <Box
          sx={{
            textAlign: 'center',
            py: 4,
            borderRadius: 2,
            border: '2px dashed',
            borderColor: 'divider',
            bgcolor: 'grey.50'
          }}
        >
          <InboxIcon sx={{ fontSize: 48, color: 'text.secondary', mb: 1 }} />
          <Typography variant="body2" color="text.secondary">
            {emptyMessage}
          </Typography>
        </Box>
      ) : (
        <TableContainer component={Paper} sx={{ borderRadius: 2, boxShadow: 2 }}>
          <Table size="small">
            <TableHead>
              <TableRow sx={{ bgcolor: 'primary.light' }}>
                {columns.map((column) => (
                  <TableCell
                    key={column.key}
                    sx={{
                      fontWeight: 'bold',
                      color: 'primary.contrastText'
                    }}
                  >
                    {column.label}
                    {column.required && (
                      <Typography
                        component="span"
                        sx={{ color: 'error.main', ml: 0.5 }}
                      >
                        *
                      </Typography>
                    )}
                  </TableCell>
                ))}
                <TableCell
                  sx={{
                    fontWeight: 'bold',
                    color: 'primary.contrastText',
                    textAlign: 'center'
                  }}
                >
                  Ações
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {data.map((item, index) => (
                <TableRow
                  key={index}
                  sx={{
                    '&:nth-of-type(odd)': { bgcolor: 'action.hover' },
                    '&:hover': { bgcolor: 'action.selected' }
                  }}
                >
                  {columns.map((column) => (
                    <TableCell key={column.key} sx={{ py: 1 }}>
                      {renderCell(item, column, index)}
                    </TableCell>
                  ))}
                  <TableCell sx={{ textAlign: 'center', py: 1 }}>
                    <IconButton
                      color="error"
                      size="small"
                      onClick={() => onRemove(index)}
                      title="Remover item"
                    >
                      <DeleteIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      )}
    </Box>
  );
};