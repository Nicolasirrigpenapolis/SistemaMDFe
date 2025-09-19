import React, { useState, useRef, useEffect } from 'react';

interface ComboboxOption {
  id: string | number;
  label: string;
  sublabel?: string;
  icon?: string;
}

interface ComboboxProps {
  options: ComboboxOption[];
  selectedValue?: string | number | null;
  onSelect: (value: string | number, option: ComboboxOption) => void;
  placeholder?: string;
  searchPlaceholder?: string;
  label?: string;
  required?: boolean;
  disabled?: boolean;
  emptyMessage?: string;
}

export const Combobox: React.FC<ComboboxProps> = ({
  options,
  selectedValue,
  onSelect,
  placeholder = "Selecione uma opção",
  searchPlaceholder = "Buscar...",
  label,
  required = false,
  disabled = false,
  emptyMessage = "Nenhuma opção encontrada"
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const comboboxRef = useRef<HTMLDivElement>(null);

  // Encontrar opção selecionada
  const selectedOption = options.find(option => option.id === selectedValue);

  // Filtrar opções baseado na busca
  const filteredOptions = options.filter(option =>
    option.label.toLowerCase().includes(searchTerm.toLowerCase()) ||
    (option.sublabel && option.sublabel.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  // Fechar dropdown ao clicar fora
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (comboboxRef.current && !comboboxRef.current.contains(event.target as Node)) {
        setIsOpen(false);
        setSearchTerm('');
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleOptionSelect = (option: ComboboxOption) => {
    onSelect(option.id, option);
    setIsOpen(false);
    setSearchTerm('');
  };

  const handleToggle = () => {
    if (!disabled) {
      setIsOpen(!isOpen);
      if (!isOpen) {
        setSearchTerm('');
      }
    }
  };

  return (
    <div className="combobox-container" ref={comboboxRef}>
      {label && (
        <label className="combobox-label">
          {label}
          {required && <span className="required">*</span>}
        </label>
      )}

      <div className={`combobox ${isOpen ? 'open' : ''} ${disabled ? 'disabled' : ''}`}>
        <div className="combobox-trigger" onClick={handleToggle}>
          <div className="combobox-value">
            {selectedOption ? (
              <div className="selected-option">
                {selectedOption.icon && <i className={selectedOption.icon}></i>}
                <span className="option-label">{selectedOption.label}</span>
                {selectedOption.sublabel && (
                  <span className="option-sublabel">{selectedOption.sublabel}</span>
                )}
              </div>
            ) : (
              <span className="placeholder">{placeholder}</span>
            )}
          </div>
          <i className={`fas fa-chevron-down chevron ${isOpen ? 'rotated' : ''}`}></i>
        </div>

        {isOpen && (
          <div className="combobox-dropdown">
            <div className="combobox-search">
              <i className="fas fa-search search-icon"></i>
              <input
                type="text"
                placeholder={searchPlaceholder}
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                autoFocus
              />
            </div>

            <div className="combobox-options">
              {filteredOptions.length > 0 ? (
                filteredOptions.map((option) => (
                  <div
                    key={option.id}
                    className={`combobox-option ${selectedValue === option.id ? 'selected' : ''}`}
                    onClick={() => handleOptionSelect(option)}
                  >
                    {option.icon && <i className={option.icon}></i>}
                    <div className="option-content">
                      <span className="option-label">{option.label}</span>
                      {option.sublabel && (
                        <span className="option-sublabel">{option.sublabel}</span>
                      )}
                    </div>
                    {selectedValue === option.id && (
                      <i className="fas fa-check check-icon"></i>
                    )}
                  </div>
                ))
              ) : (
                <div className="combobox-empty">
                  <i className="fas fa-search"></i>
                  <span>{emptyMessage}</span>
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      <style>{`
        .combobox-container {
          position: relative;
          width: 100%;
        }

        .combobox-label {
          display: block;
          font-size: 14px;
          font-weight: 500;
          color: #374151;
          margin-bottom: 6px;
        }

        .combobox-label .required {
          color: #ef4444;
          margin-left: 2px;
        }

        .combobox {
          position: relative;
          width: 100%;
        }

        .combobox-trigger {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 12px 16px;
          background: #ffffff;
          border: 2px solid #e5e7eb;
          border-radius: 8px;
          cursor: pointer;
          transition: border-color 0.2s ease;
          min-height: 48px;
        }

        .combobox-trigger:hover {
          border-color: #d1d5db;
        }

        .combobox.open .combobox-trigger {
          border-color: #64748b;
          box-shadow: 0 0 0 3px rgba(100, 116, 139, 0.1);
        }

        .combobox.disabled .combobox-trigger {
          background: #ffffff;
          color: #9ca3af;
          cursor: not-allowed;
        }

        .combobox-value {
          flex: 1;
          min-width: 0;
        }

        .selected-option {
          display: flex;
          align-items: center;
          gap: 8px;
        }

        .selected-option i {
          color: #64748b;
          width: 16px;
          text-align: center;
        }

        .option-label {
          font-weight: 500;
          color: #1f2937;
        }

        .option-sublabel {
          font-size: 12px;
          color: #6b7280;
          margin-left: 4px;
        }

        .placeholder {
          color: #9ca3af;
        }

        .chevron {
          color: #6b7280;
          transition: transform 0.2s ease;
          font-size: 12px;
        }

        .chevron.rotated {
          transform: rotate(180deg);
        }

        .combobox-dropdown {
          position: absolute;
          top: 100%;
          left: 0;
          right: 0;
          z-index: 1000;
          background: #ffffff;
          border: 1px solid #e5e7eb;
          border-radius: 8px;
          box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
          margin-top: 4px;
          max-height: 300px;
          overflow: hidden;
        }

        .combobox-search {
          position: relative;
          padding: 12px;
          border-bottom: 1px solid #f3f4f6;
        }

        .search-icon {
          position: absolute;
          left: 24px;
          top: 50%;
          transform: translateY(-50%);
          color: #9ca3af;
          font-size: 14px;
        }

        .combobox-search input {
          width: 100%;
          padding: 8px 12px 8px 36px;
          border: 1px solid #e5e7eb;
          border-radius: 6px;
          font-size: 14px;
          outline: none;
        }

        .combobox-search input:focus {
          border-color: #64748b;
          box-shadow: 0 0 0 2px rgba(100, 116, 139, 0.1);
        }

        .combobox-options {
          max-height: 240px;
          overflow-y: auto;
        }

        .combobox-option {
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 12px 16px;
          cursor: pointer;
          transition: background-color 0.15s ease;
        }

        .combobox-option:hover {
          background: transparent;
        }

        .combobox-option.selected {
          background: transparent;
          color: #475569;
        }

        .combobox-option i {
          color: #64748b;
          width: 16px;
          text-align: center;
        }

        .option-content {
          flex: 1;
          min-width: 0;
        }

        .combobox-option .option-label {
          display: block;
          font-weight: 500;
          color: #1f2937;
        }

        .combobox-option .option-sublabel {
          display: block;
          font-size: 12px;
          color: #6b7280;
          margin-top: 2px;
        }

        .check-icon {
          color: #475569;
          font-size: 12px;
        }

        .combobox-empty {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 8px;
          padding: 24px;
          color: #9ca3af;
          font-size: 14px;
        }

        .combobox-empty i {
          font-size: 24px;
          opacity: 0.5;
        }
      `}</style>
    </div>
  );
};