import React from 'react';
import './Icon.css';

interface IconProps {
  name: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  color?: string;
  className?: string;
  style?: React.CSSProperties;
}

const Icon: React.FC<IconProps> = ({
  name,
  size = 'md',
  color,
  className = '',
  style = {}
}) => {
  const sizeClasses = {
    sm: 'fa-sm',
    md: '',
    lg: 'fa-lg',
    xl: 'fa-xl'
  };

  const iconClasses = `fas fa-${name} ${sizeClasses[size]} ${className}`.trim();

  const iconStyle = {
    ...style,
    ...(color && { color })
  };

  return <i className={iconClasses} style={iconStyle} />;
};

export default Icon;