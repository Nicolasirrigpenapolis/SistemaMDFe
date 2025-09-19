import React from 'react';
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  Grid,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Typography,
  Box,
  Card,
  CardContent,
  CardActions,
  Switch,
  FormControlLabel,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Chip,
  CircularProgress,
  LinearProgress,
  Alert,
  Container,
  AppBar,
  Toolbar,
  Divider,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Fab,
  Snackbar,
  FormHelperText,
  Accordion,
  AccordionSummary,
  AccordionDetails
} from '@mui/material';
import {
  Add as AddIcon,
  Edit as EditIcon,
  Delete as DeleteIcon,
  Save as SaveIcon,
  Cancel as CancelIcon,
  Phone as PhoneIcon,
  Email as EmailIcon,
  LocationOn as LocationIcon,
  Person as PersonIcon,
  Business as BusinessIcon,
  ExpandMore as ExpandMoreIcon,
  Close as CloseIcon
} from '@mui/icons-material';

// Modal/Dialog Components
interface ModalProps {
  open: boolean;
  onClose: () => void;
  title?: string;
  children: React.ReactNode;
  actions?: React.ReactNode;
  maxWidth?: 'xs' | 'sm' | 'md' | 'lg' | 'xl';
  fullWidth?: boolean;
}

export const Modal: React.FC<ModalProps> = ({
  open,
  onClose,
  title,
  children,
  actions,
  maxWidth = 'md',
  fullWidth = true
}) => (
  <Dialog
    open={open}
    onClose={onClose}
    maxWidth={maxWidth}
    fullWidth={fullWidth}
    PaperProps={{
      sx: {
        borderRadius: 2,
        boxShadow: '0 10px 25px rgba(0, 0, 0, 0.2)'
      }
    }}
  >
    {title && (
      <DialogTitle sx={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        pb: 1
      }}>
        <Typography variant="h6" component="div">
          {title}
        </Typography>
        <IconButton onClick={onClose} size="small">
          <CloseIcon />
        </IconButton>
      </DialogTitle>
    )}
    <DialogContent sx={{ pt: 2 }}>
      {children}
    </DialogContent>
    {actions && (
      <DialogActions sx={{ p: 2, pt: 1 }}>
        {actions}
      </DialogActions>
    )}
  </Dialog>
);

// Form Components
interface TextFieldProps {
  label?: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  type?: string;
  required?: boolean;
  disabled?: boolean;
  placeholder?: string;
  maxLength?: number;
  className?: string;
  fullWidth?: boolean;
  multiline?: boolean;
  rows?: number;
  name?: string;
  variant?: 'outlined' | 'filled' | 'standard';
  size?: 'small' | 'medium';
  helperText?: string;
  error?: boolean;
}

export const CustomTextField: React.FC<TextFieldProps> = ({
  label,
  value,
  onChange,
  type = 'text',
  required = false,
  disabled = false,
  placeholder = '',
  maxLength,
  fullWidth = true,
  multiline = false,
  rows = 1,
  name,
  variant = 'outlined',
  size = 'medium',
  helperText,
  error = false,
  ...props
}) => (
  <TextField
    label={label}
    value={value}
    onChange={onChange}
    type={type}
    required={required}
    disabled={disabled}
    placeholder={placeholder}
    inputProps={{ maxLength }}
    fullWidth={fullWidth}
    multiline={multiline}
    rows={multiline ? rows : undefined}
    name={name}
    variant={variant}
    size={size}
    helperText={helperText}
    error={error}
    sx={{ mb: 2 }}
    {...props}
  />
);

// Select Component
interface SelectFieldProps {
  label?: string;
  value: string | number;
  onChange: (e: any) => void;
  options: Array<{ value: string | number; label: string }>;
  required?: boolean;
  disabled?: boolean;
  fullWidth?: boolean;
  name?: string;
  variant?: 'outlined' | 'filled' | 'standard';
  size?: 'small' | 'medium';
  helperText?: string;
  error?: boolean;
}

export const SelectField: React.FC<SelectFieldProps> = ({
  label,
  value,
  onChange,
  options,
  required = false,
  disabled = false,
  fullWidth = true,
  name,
  variant = 'outlined',
  size = 'medium',
  helperText,
  error = false
}) => (
  <FormControl fullWidth={fullWidth} variant={variant} size={size} sx={{ mb: 2 }} error={error}>
    <InputLabel required={required}>{label}</InputLabel>
    <Select
      value={value}
      label={label}
      onChange={onChange}
      required={required}
      disabled={disabled}
      name={name}
    >
      {options.map((option) => (
        <MenuItem key={option.value} value={option.value}>
          {option.label}
        </MenuItem>
      ))}
    </Select>
    {helperText && <FormHelperText>{helperText}</FormHelperText>}
  </FormControl>
);

// Button Components
interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  type?: 'button' | 'submit' | 'reset';
  variant?: 'contained' | 'outlined' | 'text';
  color?: 'primary' | 'secondary' | 'success' | 'error' | 'warning' | 'info';
  disabled?: boolean;
  startIcon?: React.ReactNode;
  endIcon?: React.ReactNode;
  fullWidth?: boolean;
  size?: 'small' | 'medium' | 'large';
  sx?: any;
}

export const CustomButton: React.FC<ButtonProps> = ({
  children,
  onClick,
  type = 'button',
  variant = 'contained',
  color = 'primary',
  disabled = false,
  startIcon,
  endIcon,
  fullWidth = false,
  size = 'medium',
  sx
}) => (
  <Button
    type={type}
    onClick={onClick}
    variant={variant}
    color={color}
    disabled={disabled}
    startIcon={startIcon}
    endIcon={endIcon}
    fullWidth={fullWidth}
    size={size}
    sx={sx || { mr: 1, mb: 1 }}
  >
    {children}
  </Button>
);

// Table Components
interface TableProps {
  children: React.ReactNode;
  headers: string[];
}

export const CustomTable: React.FC<TableProps> = ({ children, headers }) => (
  <TableContainer component={Paper} sx={{ borderRadius: 2, boxShadow: 2 }}>
    <Table>
      <TableHead>
        <TableRow sx={{ backgroundColor: 'primary.light' }}>
          {headers.map((header, index) => (
            <TableCell
              key={index}
              sx={{
                fontWeight: 'bold',
                color: 'primary.contrastText'
              }}
            >
              {header}
            </TableCell>
          ))}
        </TableRow>
      </TableHead>
      <TableBody>
        {children}
      </TableBody>
    </Table>
  </TableContainer>
);

export const CustomTableRow: React.FC<{ children: React.ReactNode; onClick?: () => void }> = ({
  children,
  onClick
}) => (
  <TableRow
    onClick={onClick}
    sx={{
      cursor: onClick ? 'pointer' : 'default',
      '&:hover': onClick ? { backgroundColor: 'action.hover' } : {}
    }}
  >
    {children}
  </TableRow>
);

export const CustomTableCell: React.FC<{
  children: React.ReactNode;
  align?: 'left' | 'center' | 'right';
  colSpan?: number;
}> = ({ children, align = 'left', colSpan }) => (
  <TableCell align={align} colSpan={colSpan}>
    {children}
  </TableCell>
);

// Card Components
interface CardProps {
  children: React.ReactNode;
  title?: string;
  actions?: React.ReactNode;
  className?: string;
}

export const CustomCard: React.FC<CardProps> = ({ children, title, actions }) => (
  <Card sx={{ borderRadius: 2, boxShadow: 2, mb: 2 }}>
    {title && (
      <CardContent sx={{ pb: 1 }}>
        <Typography variant="h6" component="div" gutterBottom>
          {title}
        </Typography>
      </CardContent>
    )}
    <CardContent sx={{ pt: title ? 0 : 2 }}>
      {children}
    </CardContent>
    {actions && (
      <CardActions sx={{ justifyContent: 'flex-end', pt: 0 }}>
        {actions}
      </CardActions>
    )}
  </Card>
);

// Grid Components
export const GridContainer: React.FC<{
  children: React.ReactNode;
  spacing?: number;
  sx?: any;
}> = ({
  children,
  spacing = 2,
  sx
}) => (
  <Grid container spacing={spacing} sx={sx}>
    {children}
  </Grid>
);

export const GridItem: React.FC<{
  children: React.ReactNode;
  xs?: number;
  sm?: number;
  md?: number;
  lg?: number;
}> = ({ children, xs = 12, sm, md, lg }) => (
  <Grid size={{ xs, sm, md, lg }}>
    {children}
  </Grid>
);

// Switch Component
interface SwitchProps {
  checked: boolean;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  label?: string;
  disabled?: boolean;
}

export const CustomSwitch: React.FC<SwitchProps> = ({
  checked,
  onChange,
  label,
  disabled = false
}) => (
  <FormControlLabel
    control={
      <Switch
        checked={checked}
        onChange={onChange}
        disabled={disabled}
      />
    }
    label={label}
  />
);

// Loading Component
export const Loading: React.FC<{ message?: string }> = ({ message = 'Carregando...' }) => (
  <Box display="flex" flexDirection="column" alignItems="center" p={4}>
    <CircularProgress sx={{ mb: 2 }} />
    <Typography variant="body2" color="text.secondary">
      {message}
    </Typography>
  </Box>
);

// Page Layout Components
export const PageContainer: React.FC<{ children: React.ReactNode; maxWidth?: false | 'xs' | 'sm' | 'md' | 'lg' | 'xl' }> = ({
  children,
  maxWidth = 'lg'
}) => (
  <Container maxWidth={maxWidth} sx={{ py: 4 }}>
    {children}
  </Container>
);

export const PageHeader: React.FC<{
  title: string;
  actions?: React.ReactNode;
  subtitle?: string;
}> = ({ title, actions, subtitle }) => (
  <Box sx={{ mb: 4 }}>
    <Box display="flex" justifyContent="space-between" alignItems="center" mb={subtitle ? 1 : 0}>
      <Typography variant="h4" component="h1" fontWeight="bold">
        {title}
      </Typography>
      {actions && (
        <Box>
          {actions}
        </Box>
      )}
    </Box>
    {subtitle && (
      <Typography variant="subtitle1" color="text.secondary">
        {subtitle}
      </Typography>
    )}
    <Divider sx={{ mt: 2 }} />
  </Box>
);

// Status Components
export const StatusChip: React.FC<{
  label: string;
  color?: 'default' | 'primary' | 'secondary' | 'error' | 'info' | 'success' | 'warning';
  variant?: 'filled' | 'outlined';
}> = ({ label, color = 'default', variant = 'filled' }) => (
  <Chip label={label} color={color} variant={variant} size="small" />
);

// Section Component
export const Section: React.FC<{
  title?: string;
  children: React.ReactNode;
  icon?: React.ReactNode;
}> = ({ title, children, icon }) => (
  <Box sx={{ mb: 3 }}>
    {title && (
      <Box display="flex" alignItems="center" mb={2}>
        {icon && <Box sx={{ mr: 1, color: 'primary.main' }}>{icon}</Box>}
        <Typography variant="h6" color="primary.main" fontWeight="medium">
          {title}
        </Typography>
      </Box>
    )}
    {children}
  </Box>
);

// Export all icons for convenience
export {
  AddIcon,
  EditIcon,
  DeleteIcon,
  SaveIcon,
  CancelIcon,
  PhoneIcon,
  EmailIcon,
  LocationIcon,
  PersonIcon,
  BusinessIcon,
  ExpandMoreIcon,
  CloseIcon
};

// Export MUI components directly for advanced usage
export {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
  TextField,
  Grid,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Typography,
  Box,
  Card,
  CardContent,
  CardActions,
  Switch,
  FormControlLabel,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Chip,
  CircularProgress,
  LinearProgress,
  Alert,
  Container,
  AppBar,
  Toolbar,
  Divider,
  List,
  ListItem,
  ListItemText,
  ListItemIcon,
  Fab,
  Snackbar,
  FormHelperText,
  Accordion,
  AccordionSummary,
  AccordionDetails
};